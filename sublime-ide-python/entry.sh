#!/bin/bash


_port=${ANACONDA_PORT:-19360}


cd /src
if [[ -f /src/${PROJECT_NAME}/requirements.txt || \
      -f /src/${PROJECT_NAME}/requirements-dev.txt ]]; then
    _project_base=/src/${PROJECT_NAME}
else
    _project_base=/src
fi

_venv=${_project_base}/venv
if [[ ! -d ${_venv} ]]; then
    echo "Initializing venv..."
    python -m venv ${_venv} || exit 1
fi

_pip=${_venv}/bin/pip
${_pip} install --upgrade pip  || exit 2
if [[ -f ${_project_base}/requirements-dev.txt ]]; then
    ${_pip} install -r ${_project_base}/requirements-dev.txt || exit 3
else
    ${_pip} install -r ${_project_base}/requirements.txt || exit 4
fi


# Run post-venv setup script, if any
if [[ -x /bin/docker-entry-post-venv ]]; then
    source /bin/docker-entry-post-venv || exit 10
fi


# Start Anaconda Server (for IDE)
exec ${_venv}/bin/python /opt/anaconda/anaconda_server/minserver.py \
    -e ${_venv}/ $_port
