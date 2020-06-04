#/bin/bash

line() {
    printf '%20s\n' | tr ' ' -
}

# nice error handling
err() {
    line
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
    line
}

# nice date log
log_date() {
    line
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&1
    line
}


update() {
    log_date "installing updates"
    sudo apt update
    sudo apt upgrade -yq
}

if ! update; then
    line
    err "Unable to update"
    exit "${E_DID_NOTHING}"
else
    log_date "updates probably installed correctly"
fi




