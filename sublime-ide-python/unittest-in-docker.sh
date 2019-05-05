#!/bin/bash

project=${PROJECT_NAME}
subproject=$1; shift

cd /src/${subproject}
/src/${subproject}/venv/bin/python -m unittest "$@"
