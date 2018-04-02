package main

import (
	"fmt"
	"strings"
	"bytes"
	"os"
	"os/exec"
	"flag"
)

func rm_empty_and_join(s... string) string {
	var idx int
	// s[0] is branch and thus always non-empty
	idx = 1
	for i := 1; i < len(s); i++ {
		if s[i] != "" {
			s[idx] = s[i]
			idx++
		}
	}
	return strings.Join(s[:idx], " ")
}

// returns green, yellow, red, turnoff with shell escapes for corresponding prompts
func getcolorcodes(prompt string) (string, string, string, string) {
	if prompt == "zsh" {
		return "%{%F{green}%}" , "%{%F{yellow}%}" , "%{%F{red}%}" , "%{%f%}" 
	} else if prompt == "bash"{
		return "\\[\033[0;32m\\]" , "\\[\033[0;33m\\]" , "\\[\033[0;31m\\]" , "\\[\033[0;0m\\]"
	} else {
		return "\033[0;32m" , "\033[0;33m" , "\033[0;31m" , "\033[0;0m"

	}
}

func main() {
	var (
		git_info  []byte
		git_dirty_cached, git_dirty, git_branch, git_remote *exec.Cmd
		git_untracked, git_stash *exec.Cmd
		err     error
		empty, bare, branch string
		forward, behind string
		stash, untracked string
		color, green, yellow, red, turnoff string
		helpPtr *bool
		promptPtr *string
	)
	helpPtr = flag.Bool("help", false, "Print this help and exit")
	promptPtr = flag.String("prompt", "", "format colors so `[bash,zsh]` prompts know they have zero width")
	flag.Parse()

	if *helpPtr {
		fmt.Fprintf(os.Stderr, "Usage of %s:\n", os.Args[0])
		flag.PrintDefaults()
		os.Exit(0)
	}

	green, yellow, red, turnoff = getcolorcodes(*promptPtr)

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
		if short_sha == "" {
			empty = "EMPTY:"
		} else {
			empty = ""
		}
		if is_bare == "true" {
			bare = "BARE:"
		} else {
			bare = ""
		}
		git_remote.Wait()
		forward = ""
		behind = ""
		if remote_output.String() != "" {
			s := strings.Split(remote_output.String(), "\t")
			if s[0] != "0" {
				forward = "+" + s[0]
			}
			if s[1] != "0\n" {
				behind = "-" + s[1]
			}
		}
		if err = git_branch.Wait(); err == nil {
			branch = strings.Replace(branch_ouput.String(), "\n", "", -1)
		} else {
			branch = short_sha
		}
		if err = git_stash.Wait(); err == nil {
			stash = "S"
		} else {
			stash = ""
		}
		untracked = ""
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
				untracked = "U"
			}
		}
		fmt.Println(rm_empty_and_join(color + empty + bare + branch + turnoff, stash + untracked, forward + behind))
		var _ = git_dir
	}
}
