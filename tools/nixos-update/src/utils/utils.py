import subprocess
import argparse
import os
import sys

class script_args:
    instance = None
    
    def __new__(cls, args=None):
        if cls.instance is None:
            if args is None:
                raise ValueError("no args specified")
            cls.instance = super().__new__(cls)
            cls.instance.initialized = False
        return cls.instance
    
    def __init__(self, args=None):
        if not getattr(self, 'initialized'):
            for attr_name, attr_value in args.__dict__.items():
                if not attr_name.startswith('__'):
                    setattr(self, attr_name.lower(), attr_value)
            self.initialized = True

class log:
    instance = None 
    def __new__(cls):
        if cls.instance is None:
            cls.instance = super().__new__(cls)
            cls.instance.initialized = False
        return cls.instance

    def __init__(self):
        if not getattr(self, 'initialized'):
            open(self.path, 'w').close()
            self.initialized = True
        
    def write(self,str:str):
        with open(self.path, 'a') as file:
            file.write(str)

    def delete(self):
        os.remove(self.path)
        
def run(cmd: str):
    if script_args().verbose_log:
        log().write(f"running: [{cmd}]")
    print(f"\033[34m[{cmd}]\033[0m")
    try:
        result = subprocess.run(cmd, shell=True, check=True, capture_output=True, text=True)
        if result.stderr:
            log().write(result.stderr)
        if result.stdout:
            log().write(result.stdout)
        return result
    except subprocess.CalledProcessError as e:
        print(f"\033[31m✖ command failed with exit code {e.returncode}, check log for info: {log().path}\033[0m")
        if e.stderr:
            log().write(e.stderr)
        if e.stdout:
            log().write(e.stdout)
        log().write(f"returncode: {e.returncode}")
        sys.exit(e.returncode)
    except Exception as e:
        print(f"\033[31m✖ an error occurred: {e}, check log for info: {log().path}\033[0m")
        log().write(f"error: {e}")
        sys.exit(1)

# def run(cmd:str):
#     print(f"\033[34m[{cmd}]\033[0m")
#     try:
#         result = subprocess.run(cmd, shell=True, check=True, capture_output=True)
#         logfile.write(result.stderr)
#         logfile.write(result.stdout)
#     except Exception:
#         f"\033[31m✖ an error has occurred, check log for info: {logfile.file_path}\033[0m\n"
#     if result.returncode != 0:
#         sys.exit(0)
#     return result

def has_local_changes():
    status = run("git status --porcelain")
    return bool(status.stdout.strip())

def has_unmerged_files():
    result = run("git diff --name-only --diff-filter=U")
    return bool(result.stdout.strip())

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--login",default=None)
    parser.add_argument("--repo",default=None)
    parser.add_argument("--config-path",default="~/nixos-config")
    parser.add_argument("--log-path",default="nixos-config")

    parser.add_argument("--verbose-log",action='store_true')
    parser.add_argument("--verbose-log",action='store_true')

    args = parser.parse_args()
    args.config_path = os.path.expanduser(args.config_path)
    script_args(args)