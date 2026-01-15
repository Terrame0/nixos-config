from utils.utils import run
import sys

def rebuild(args):
    run("alejandra .", capture_output=True)
    if run("sudo -v").returncode != 0:
        print("\033[31m✖ sudo authentication failed\033[0m\n",file=sys.stderr)
    run(f"sudo nixos-rebuild switch --flake {args.dir} --print-build-logs --verbose --log-format internal-json |& nom --json")

    
    
