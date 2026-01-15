import os
from utils.utils import parse_args
from git.update_local_state import update_local_state
from rebuild.nixos_rebuild import rebuild

def main():
    args = parse_args()
    os.makedirs(args.path, exist_ok=True)
    os.chdir(args.path)
    update_local_state(args)
    rebuild(args)
    
    
    