import os
from utils.utils import parse_args, script_args
from core.update_local_state import update_local_state
from core.nixos_rebuild import rebuild

def main():
    parse_args()
    os.makedirs(script_args().path, exist_ok=True)
    os.chdir(script_args().path)
    update_local_state()
    rebuild()