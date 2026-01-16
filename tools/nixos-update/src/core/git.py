import os
from core.utils import run, script_args
import sys

def has_local_changes():
    status = run("git status --porcelain")
    return bool(status.stdout.strip())

def has_unmerged_files():
    result = run("git diff --name-only --diff-filter=U")
    return bool(result.stdout.strip())

def stash_changes():
    print("\033[36m↶ stashing local changes\033[0m")
    run("git stash push -u -m 'autostash before merge'")

def pop_and_merge_stash():
    print("\033[36m↷ applying stashed changes\033[0m")
    run("git stash apply")
    resolve_merge_conflicts()
    run("git add .")
    run("git stash drop")

def resolve_merge_conflicts():
    while has_unmerged_files():
        conflicts = run("git diff --name-only --diff-filter=U").stdout.strip().splitlines()
        print(f"\033[33m⚠ there are unmerged files: {', '.join(conflicts)}\033[0m")
        print("\033[36m↹ attempting to merge...\033[0m")
        run("git -c merge.tool=meld -c mergetool.prompt=false mergetool")
        run("git add .")
        if os.path.exists(".git/MERGE_HEAD"):
            run('git commit -m "automatic merge commit"')
        print("\033[32m✔ merge successful\033[0m")

    for root, _, files in os.walk("."):
        for f in files:
            if f.endswith(".orig"):
                print(f"\033[36m✖ removing backup file: {f}\033[0m")
                os.remove(os.path.join(root, f))

def clone_from_github():
    errors = []
    if script_args().login is None:
        errors.append("github account name [--login]")
    if script_args().repo is None:
        errors.append("repository name [--repo]")
    if errors:
        print(f"\033[31m✖ no {' and '.join(errors)} specified\033[0m")
        sys.exit(1)
    print("\033[36m⇊ cloning...\033[0m")
    run(f"git clone git@github.com:{script_args().login}/{script_args().repo}.git {script_args().config_path}")
    print("\033[32m✔ cloned successfuly\033[0m")

def fetch_and_merge():
    print("\033[36m⇊ fetching from remote...\033[0m")
    run(f"git fetch {script_args().remote}")
    print("\033[32m✔ fetched successfuly\033[0m")
    merge_result = run(f"git merge origin/{script_args().branch}")
    if merge_result.returncode != 0:
        resolve_merge_conflicts()
    
def push_changes():
    gen_number,gen_date,gen_time,gen_version = run("sudo nixos-rebuild list-generations | grep -m9 'True'").stdout.split()[:4]
    hostname = run("hostname").stdout.strip('\n')
    commit_message_lines = [
        f"[hostname: {hostname}]",
        f"[gen: {gen_number} | ver: {gen_version}]",
        f"[{gen_date} {gen_time}]",
    ]
    commit_message=" ".join(['-m ' + line for line in commit_message_lines]) # -- forms the commit message
    run("git add .")
    print(f"\033[36m🖹 creating commit: {commit_message}\033[0m")
    for line in commit_message_lines:
        print('  '+line)
    run(f"git commit {commit_message}",nofail=True)
    print("\033[36m⇈ pushing to remote...\033[0m")
    run(f"git push {script_args().remote} {script_args().branch}")
    print("\033[32m✔ pushed successfuly\033[0m")
    