import subprocess
import argparse
import os

def run(cmd, **kwargs):
    print(f"\033[34m[{cmd}]\033[0m")
    return subprocess.run(cmd, shell=True, **kwargs)

def has_local_changes():
    status = run(
        "git status --porcelain",
        capture_output=True, text=True
    )
    return bool(status.stdout.strip())

def has_unmerged_files():
    result = run(
        "git diff --name-only --diff-filter=U",
        capture_output=True, text=True
    )
    return bool(result.stdout.strip())

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--name",default=None)
    parser.add_argument("--repo",default=None)
    parser.add_argument("--path",default="nixos-config")
    args = parser.parse_args()
    args.path = os.path.expanduser(f"~/{args.path}")
    print(args.path)
    return args