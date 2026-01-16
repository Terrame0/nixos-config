import os
from utils.utils import script_args
from core.git import clone_from_github,has_local_changes,stash_changes,fetch_and_merge,pop_and_merge_stash,push_changes
from core.rebuild import rebuild

def main():
    os.makedirs(script_args().config_path, exist_ok=True)
    os.chdir(script_args().config_path)
    if not os.path.exists(f"{script_args().config_path}/.git"):
        clone_from_github()
    else:
        stashed = False
        if has_local_changes():
            stash_changes()
            stashed = True
        fetch_and_merge()
        if stashed:
            pop_and_merge_stash()
    rebuild()
    push_changes()