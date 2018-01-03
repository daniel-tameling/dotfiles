package main

import (
	"fmt"
	"strings"
	"bytes"
	// "os"
	"os/exec"
)

func main() {
	var (
		git_info  []byte
		git_dirty_cached, git_dirty, git_branch, git_remote *exec.Cmd
		git_untracked, git_stash *exec.Cmd
		err     error
		remote, branch, prefix, postfix  string
		color, green, yellow, red, turnoff string
	)
	green = "\033[0;32m"
	yellow = "\033[0;33m"
	red = "\033[0;31m"
	turnoff = "\033[0;0m"

	// git_info, err = exec.Command(cmdName, cmdArgs...).Output()
	// if err != nil {
	// 	fmt.Fprintln(os.Stderr, "There was an error running git rev-parse command: ", err)
	// 	os.Exit(1)
	// }
	git_info, _ = exec.Command("git", "rev-parse", "--git-dir", "--is-bare-repository", "--is-inside-work-tree", "--short", "HEAD").Output()
	if string(git_info) != "" {
		s := strings.Split(string(git_info), "\n")
		git_dir, is_bare, inside_work_tree, short_sha := s[0], s[1], s[2],s[3]
		remote_output := &bytes.Buffer{}
		branch_ouput := &bytes.Buffer{}
		if inside_work_tree == "true" {
			git_dirty = exec.Command("git", "diff", "--no-ext-diff", "--quiet")
			git_dirty.Start()
			git_dirty_cached = exec.Command("git", "diff", "--no-ext-diff", "--cached", "--quiet")
			git_dirty_cached.Start()
			git_untracked = exec.Command("git", "ls-files", "--others", "--exclude-standard", "--directory", "--no-empty-directory", "--error-unmatch", "--", ":/*")
			git_untracked.Start()
		}
		git_remote = exec.Command("git", "rev-list", "--count", "--left-right", "HEAD...@{upstream}")
		git_remote.Stdout = remote_output
		git_remote.Start()
		git_stash = exec.Command("git", "rev-parse", "--verify", "--quiet", "refs/stash")
		git_stash.Start()
		git_branch = exec.Command("git", "symbolic-ref", "--short", "--quiet", "HEAD")
		git_branch.Stdout = branch_ouput
		git_branch.Start()
		prefix = ""
		if short_sha == "" {
			prefix = "EMPTY:"
		}
		if is_bare == "true" {
			prefix = prefix + "BARE:"
		}
		git_remote.Wait()
		remote = ""
		if remote_output.String() != ""{
			s := strings.Split(remote_output.String(), "\t")
			forward := s[0]
			behind  := s[1]
			if forward != "0" {
				remote = "+" + forward
			}
			if behind != "0\n" {
				remote = remote + "-" + behind
			}
			if remote != "" {
				remote = remote + " "
			}
		}
		if err = git_branch.Wait(); err == nil {
			branch = branch_ouput.String()
		} else {
			branch = short_sha
		}
		postfix = " "
		color = green
		if inside_work_tree == "true" {
			if err = git_dirty_cached.Wait(); err != nil {
				color = yellow
			} else {
				if err = git_dirty.Wait(); err != nil {
					color = red
				}
			}
			if err = git_untracked.Wait(); err == nil {
				postfix = " U"
			}
		}
		if err = git_stash.Wait(); err == nil {
			postfix = postfix + "S"
		}
		output := strings.Replace(" " + color + prefix + branch + turnoff + postfix + " " + remote, "\n", "", -1)
		fmt.Println(output)
		var _ = git_dir
	}
}
