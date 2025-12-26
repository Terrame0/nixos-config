#!/usr/bin/env bash

# == function defs ==

cleanup() { # -- clean up state on manual termination
    tput cnorm 2>/dev/null || true # -- restore cursor visibility
    [[ -n "${SUDO_KEEPALIVE_PID:-}" ]] && kill "$SUDO_KEEPALIVE_PID" 2>/dev/null || true # -- kill the sudo life support loop
    [[ -n "${PID:-}" ]] && kill "$PID" 2>/dev/null || true # -- kill the rebuild process
    [[ -n "${LOG:-}" ]] && rm -f "$LOG" # -- delete the log file
}

spinner() { # -- cool wait animation :)
    [[ -t 1 ]] || return 0 # -- if stdout is not a terminal, exit right away

    local pid=$1 # -- pid of the process to watch
    local delay=0.2
    local spin='|\-/'

    tput civis 2>/dev/null || true # -- make the cursor invisible
    while kill -0 "$pid" 2>/dev/null; do # -- while the process is running
        for ((i=0; i<${#spin}; i++)); do
            printf "\r%s building nixos…" "${spin:i:1}" # -- print the spinner on the same line with the use of \r
            sleep "$delay" 
        done
    done
    printf "\r\033[K" # -- erase the current line
    tput cnorm 2>/dev/null || true # -- restore cursor visibility
}

# == actual code ==

set -o pipefail # -- fail if any part of a pipeline fails
set -o nounset # -- disallow uninitialised variables

trap cleanup EXIT INT TERM # -- run the cleanup function on exit and termination signals

# -- ask for sudo permissions right away
if ! sudo -v; then
    printf "\033[31m✖ sudo authentication failed\033[0m\n" >&2
    exit 1
fi

# -- keep sudo alive if the build time is long
( while true; do sudo -v; sleep 60; done ) &
SUDO_KEEPALIVE_PID=$!

# -- move to the nixos config folder
cd /etc/nixos || exit 1
git add . # -- stage everything so the commit matches the build
LOG=$(mktemp /tmp/nixos-build.XXXXXX.log) # -- log file for build log

# -- rebuild the system in the background, writing to a log file and redirecting stderr to stdout
sudo nixos-rebuild switch --flake . >"$LOG" 2>&1 &
PID=$! # -- get the pid of the rebuild process


spinner "$PID" # -- run the spinner while the rebuild process exists
wait "$PID" # -- get the exit code from the rebuild process and ensure the process finished
STATUS=$? # -- the actual exit code

if (( STATUS == 0 )); then # -- if the rebuild is successful
    # -- if the pipe succeeded, set the generation info variables
    if GEN_INFO=$(sudo nixos-rebuild list-generations | grep -m1 current); then
        read -r GEN_NUMBER _ GEN_DATE GEN_TIME GEN_VERSION _ <<< "$GEN_INFO"
    else
        printf "\033[33m⚠ could not determine current generation\033[0m\n" >&2
        GEN_NUMBER="?"
        GEN_VERSION="?"
        GEN_DATE="?"
        GEN_TIME="?"
    fi

    printf "\033[32m✔ build successful\033[0m\n"
    COMMIT_MSG="[gen ${GEN_NUMBER} | ver ${GEN_VERSION} | ${GEN_DATE} ${GEN_TIME}]" # -- form the commit message
    printf "built system %s\n" "$COMMIT_MSG"

    # -- check if git has any changes to commit
    if ! git diff --cached --quiet; then
        # -- create a commit and push it to the remote
        git commit -m "$COMMIT_MSG"
        git push origin master
    else
        printf "\033[33m⚠ no changes to commit\033[0m\n"
    fi
    exit 0
else # -- if the rebuild failed
    printf "\033[31m✖ build failed\033[0m\n" >&2
    sed -n '/^error:/,$p' "$LOG" >&2 # -- print errors from the log to stderr
    exit 1
fi
или можно "${VAR:i:1}"