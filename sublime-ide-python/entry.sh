#!/bin/bash


_port=${ANACONDA_PORT:-19360}


init_project_dir() {
    local _project_base=$1
    local _venv=${_project_base}/venv
    if [[ ! -d ${_venv} ]]; then
        echo "Initializing ${_venv}..."
        python -m venv ${_venv} || exit 1
    fi

    local _pip=${_venv}/bin/pip
    ${_pip} install --upgrade pip  || exit 2
    if [[ -f ${_project_base}/requirements-dev.txt ]]; then
        ${_pip} install -r ${_project_base}/requirements-dev.txt || exit 3
    else
        ${_pip} install -r ${_project_base}/requirements.txt || exit 4
    fi
}


cd /src
extra_paths=()
if [[ -f /src/${PROJECT_NAME}/requirements.txt || \
      -f /src/${PROJECT_NAME}/requirements-dev.txt ]]; then
    init_project_dir /src/${PROJECT_NAME}
    extra_paths+=("/src/${PROJECT_NAME}")
elif [[ -f /src/requirements.txt || \
        -f /src/requirements-dev.txt ]]; then
    init_project_dir /src
    extra_paths+=("/src")
else
    for subdir in *; do
        if [[ ! -d $subdir ]]; then
            continue
        fi
        if [[ -f $subdir/requirements.txt || -f $subdir/requirements-dev.txt ]]
        then
            init_project_dir /src/$subdir
            extra_paths+=("/src/$subdir")
        fi
    done
fi

# Run post-venv setup script, if any
if [[ -x /bin/docker-entry-post-venv ]]; then
    source /bin/docker-entry-post-venv || exit 10
fi

# https://stackoverflow.com/a/17841619/1034436
function join_by { local IFS="$1"; shift; echo "$*"; }

# Start Anaconda Server (for IDE)
_paths=$(join_by , "${extra_paths[@]}")
echo "Starting Anaconda Server with extra paths: $_paths"
exec env python3 /opt/anaconda/anaconda_server/minserver.py -e $_paths $_port

