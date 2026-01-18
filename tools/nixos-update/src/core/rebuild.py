from core.utils import run
from core.utils import script_args

def rebuild():
    run("alejandra .")
    run("git add .")
    print("\033[36m↻ rebuilding...\033[0m")
    run(f"sudo nixos-rebuild switch --flake {script_args().config_path}#{script_args().hostname} --print-build-logs --verbose --log-format internal-json |& nom --json", print_output=True)
    print("\033[32m✔ rebuilt successfuly\033[0m")