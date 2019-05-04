#!/bin/bash

_version=`grep -o -e 'FROM python:.*$' Dockerfile | cut -d : -f 2`
_old=${1:-no}

docker build -t martian111/sublime-ide-python:$_version .
if [[ $_old != "--old" ]]; then
    docker tag martian111/sublime-ide-python:$_version martian111/sublime-ide-python:latest
fi

