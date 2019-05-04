#!/bin/bash

project=${PROJECT_NAME}
test_root=$1
test_path=$2

subproject=${test_root#*/${project}/}
subproject=${subproject%%/*}

cd /src/${subproject}
/src/${subproject}/venv/bin/python -m unittest $test_path

