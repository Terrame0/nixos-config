import os
from core.utils import script_args
from core.git import clone_from_github,has_local_changes,fetch_and_merge,push_on_success,create_commit
from core.rebuild import rebuild
from core.utils import run

def main():
    run("sudo -v")
    os.makedirs(script_args().config_path, exist_ok=True)
    os.chdir(script_args().config_path)
    run("git add .")
    if not os.path.exists(f"{script_args().config_path}/.git"):
        clone_from_github()
    else:
        if has_local_changes():
            create_commit("WIP")
        fetch_and_merge()
    rebuild()
    push_on_success()