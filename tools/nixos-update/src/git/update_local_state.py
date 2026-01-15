import os
from utils.utils import run, has_local_changes, has_unmerged_files
import sys
import argparse

def check_github_auth():
    # -- tries to authenticate using the system public ssh key
    auth_result = run("ssh -T git@github.com",capture_output=True,text=True)
    if "successfully authenticated" not in (auth_result.stdout + auth_result.stderr):
        print("\033[31m✖ github authentication failed\033[0m",file=sys.stderr)
        sys.exit(1)
    else:
        print("\033[32m✔ github authentication successful\033[0m")

def stash_changes():
    print("\033[36m↓ stashing local changes\033[0m")
    run("git stash push -u -m 'autostash before merge'")

def pop_and_merge_stash():
    print("\033[36m↑ applying stashed changes\033[0m")
    run("git stash apply")
    resolve_merge_conflicts()
    run("git add .")
    run("git stash drop")

def resolve_merge_conflicts():
    while has_unmerged_files():
        conflicts = run(
            "git diff --name-only --diff-filter=U",
            capture_output=True, text=True
        ).stdout.strip().splitlines()
        print(f"\033[33m⚠ there are unmerged files: {', '.join(conflicts)}\033[0m")
        for f in conflicts:
            run("git -c merge.tool=meld -c mergetool.prompt=false mergetool")
            run("git add .")
        if os.path.exists(".git/MERGE_HEAD"):
            run('git commit -m "automatic merge commit"', check=True)

    for root, _, files in os.walk("."):
        for f in files:
            if f.endswith(".orig"):
                print(f"\033[36m✖ removing backup file: {f}\033[0m")
                os.remove(os.path.join(root, f))

def clone_from_github(args:argparse.ArgumentParser):
    errors = []
    if args.name is None:
        errors.append("github account name (--name)")
    if args.repo is None:
        errors.append("repository name (--repo)")
    if errors:
        print(f"\033[31m✖ no {' and '.join(errors)} specified\033[0m")
        sys.exit(1)
    run(f"git clone git@github.com:{args.name}/{args.repo}.git {args.path}")

def fetch_and_merge(args:argparse.ArgumentParser):
    run("git fetch origin", check=True)
    merge_result = run("git merge origin/master")
    if merge_result.returncode != 0:
        resolve_merge_conflicts()

def update_local_state(args:argparse.ArgumentParser):
    check_github_auth()
    if not os.path.exists(f"{args.path}/.git"):
        clone_from_github(args)
    else:
        stashed = False
        if has_local_changes():
            stash_changes()
            stashed = True
        fetch_and_merge(args)
        if stashed:
            pop_and_merge_stash()
    