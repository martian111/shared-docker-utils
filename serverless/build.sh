#!/bin/bash

_version=`grep -o -e 'serverless@\(.*\)$' Dockerfile | cut -d @ -f 2`
_old=${1:-no}

docker build -t martian111/serverless:$_version .
if [[ $_old != "--old" ]]; then
    docker tag martian111/serverless:$_version martian111/serverless:latest
fi

