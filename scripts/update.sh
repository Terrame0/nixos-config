#!/usr/bin/env bash

cd /etc/nixos || exit 1
git add .

LOG=$(mktemp /tmp/nixos-build.XXXXXX.log)

spinner() {
    local pid=$1
    local delay=0.2
    local spin='|\-/'
    tput civis 2>/dev/null || true
    while kill -0 "$pid" 2>/dev/null; do
        for ((i=0; i<${#spin}; i++)); do
            printf "\r%s building nixos…" "${spin:i:1}"
            sleep "$delay"
        done
    done
    printf "\r\033[K"
    tput cnorm 2>/dev/null || true
}

sudo nixos-rebuild switch --flake . >"$LOG" 2>&1 &
PID=$!

spinner "$PID"
wait "$PID"
STATUS=$?

if (( STATUS == 0 )); then
    GEN_INFO=$(sudo nixos-rebuild list-generations | grep current)
    read -r GEN_NUMBER _ GEN_DATE GEN_TIME GEN_VERSION _ <<< "$GEN_INFO"
    printf "\033[32m✔ build successful\033[0m\n"
    COMMIT_MSG="[gen ${GEN_NUMBER} | ver ${GEN_VERSION} | ${GEN_DATE} ${GEN_TIME}]"
    printf "built system ${COMMIT_MSG}\n"
    git commit -m "$COMMIT_MSG"
    rm -f "$LOG"
    exit 0
else
    printf "\033[31m✖ build failed\033[0m\n" >&2
    sed -n '/^error:/,$p' "$LOG" >&2
    rm -f "$LOG"
    exit 1
fi
