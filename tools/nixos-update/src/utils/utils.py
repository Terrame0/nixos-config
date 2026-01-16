import subprocess
import argparse
import os
import sys

class script_args:
    instance = None
    
    def __new__(cls):
        if cls.instance is None:
            cls.instance = super().__new__(cls)
            cls.instance.initialized = False
        return cls.instance
    
    def __init__(self):
        if not getattr(self, 'initialized'):
            parser = argparse.ArgumentParser()

            # -- cli arguments
            parser.add_argument("--login",default=None)
            parser.add_argument("--repo",default=None)
            parser.add_argument("--config-path",default="~/nixos-config")
            parser.add_argument("--log-path",default="/tmp/nixos-update.log")
            parser.add_argument("--print-cmd",action="store_true")
            parser.add_argument("--branch",default="master")
            parser.add_argument("--remote",default="origin")

            args = parser.parse_args()

            # -- expands the user dir to an absolute path
            args.config_path = os.path.expanduser(args.config_path)

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
            open(script_args().log_path, 'w').close()
            self.initialized = True
        
    def write(self,str:str):
        with open(script_args().log_path, 'a') as file:
            file.write(f"{str}\n")

    def delete(self):
        os.remove(script_args().log_path)
        
def run(cmd: str, print_output = False):
    print_string = f"running: [{cmd}]"
    if script_args().print_cmd:
        print(f"\033[34m↪ {print_string}\033[0m")
    log().write(print_string)
    try:
        run_kwargs = {
            "shell":True, 
            "check":True, 
            "capture_output":True, 
            "text":True
        }

        if print_output:
            del run_kwargs["capture_output"]
            del run_kwargs["text"]
            
        result = subprocess.run(cmd, **run_kwargs)
        if result.stderr:
            log().write(result.stderr)
        if result.stdout:
            log().write(result.stdout)
        return result
    except subprocess.CalledProcessError as e:
        print(f"\033[31m✖ command failed with exit code {e.returncode}, check log for info: {script_args().log_path}\033[0m")
        if e.stderr:
            log().write(e.stderr)
        if e.stdout:
            log().write(e.stdout)
        log().write(f"returncode: {e.returncode}")
        sys.exit(e.returncode)
    except Exception as e:
        print(f"\033[31m✖ an error occurred: {e}, check log for info: {script_args().log_path}\033[0m")
        log().write(f"error: {e}")
        sys.exit(1)