#!/bin/bash


_port=${ANACONDA_PORT:-19360}


cd /src
if [[ ! -d /src/venv ]]; then
    echo "Initializing venv..."
    python -m venv venv
fi

/src/venv/bin/pip install --upgrade pip
/src/venv/bin/pip install -r /src/requirements.txt

exec /src/venv/bin/python /opt/anaconda/anaconda_server/minserver.py -e /src/venv/ $_port
