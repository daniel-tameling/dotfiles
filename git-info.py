#!/usr/bin/env python
import subprocess

green = "\033[0;32m"
yellow = "\033[0;33m"
red = "\033[0;31m"
turnoff = "\033[0;0m"
git_info = subprocess.Popen("git rev-parse --git-dir --is-bare-repository --is-inside-work-tree --short HEAD 2>/dev/null", shell=True, stdout=subprocess.PIPE)
git_info_stdout =  git_info.communicate()[0]
#is git repo
if (git_info_stdout != ""):
    git_dir = git_info_stdout.split()[0]
    is_bare = git_info_stdout.split()[1]
    inside_work_tree = git_info_stdout.split()[2]
    try:
        short_sha =  git_info_stdout.split()[3]
        prefix = ""
    except:
        prefix = "EMPTY:"
    if inside_work_tree == "true":
        git_dirty = subprocess.Popen("git diff --no-ext-diff --quiet", shell=True, stdout=subprocess.PIPE)
        git_dirty_cache = subprocess.Popen("git diff --no-ext-diff --cached --quiet", shell=True, stdout=subprocess.PIPE)
        git_untracked = subprocess.Popen("git ls-files --others --exclude-standard --directory --no-empty-directory --error-unmatch -- ':/*'", shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    git_remote = subprocess.Popen("git rev-list --count --left-right HEAD...@{upstream} 2>/dev/null", shell=True, stdout=subprocess.PIPE)
    git_stash = subprocess.Popen("git rev-parse --verify --quiet refs/stash", shell=True, stdout=subprocess.PIPE)
    git_branch = subprocess.Popen("git symbolic-ref --short --quiet HEAD", shell=True, stdout=subprocess.PIPE)
    if (is_bare == "true"):
        prefix = prefix + "BARE:"
    remote = git_remote.communicate()[0]
    if remote != "":
        forward = remote.split()[0]
        behind = remote.split()[1]
        remote = ""
        if forward != "0":
            remote = "+" + forward
        if behind != "0":
            remote = remote + "-" + behind
        if remote != "":
            remote = remote + " "
    branch = git_branch.communicate()[0]
    if git_branch.returncode != 0:
        branch = short_sha
    color = green
    postfix = " "
    if inside_work_tree == "true":
        git_dirty_cache.communicate()
        if git_dirty_cache.returncode != 0:
            color = yellow
        else:
            git_dirty.communicate()
            if git_dirty.returncode != 0:
                color = red
        git_untracked.communicate()
        if git_untracked.returncode == 0:
            postfix = " U"
    git_stash.communicate()
    if git_stash.returncode == 0:
        postfix = postfix + "S"
    branch = " " + color + prefix + branch + turnoff + " "
    output = (branch + postfix + remote).replace("\n","")
    print(output)
