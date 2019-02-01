#!/bin/bash

#project=$1; shift
project=${PROJECT_NAME}

new_args=()
for var in "$@"
do
    if [[ $var = *"/$project/"* ]]; then
       #echo found $var
       new_var="/src/${var#*/${project}/}"
       #echo $var to $new_var
       new_args+=("$new_var")
    else
       new_args+=("$var")
    fi
done

/src/venv/bin/python "${new_args[@]}"
