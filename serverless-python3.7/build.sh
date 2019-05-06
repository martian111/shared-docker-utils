#!/bin/bash

_version=`grep -o -e 'npm install -g serverless@\(.*\)$' Dockerfile | cut -d @ -f 2`
_old=${1:-no}

docker build -t martian111/serverless-python3.7:$_version . || exit 11
if [[ $_old != "--old" ]]; then
    docker tag martian111/serverless-python3.7:$_version martian111/serverless-python3.7:latest
fi

