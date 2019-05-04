#!/bin/bash

project=${PROJECT_NAME}

new_args=()
#echo "$@"
for var in "$@"
do
    if [[ $var = *"/$project/"* ]]; then
        #echo found $var
	subproject=${var#*/${project}/}
	subproject=${subproject%%/*}
	#echo subproject $subproject
        if [[ -d "/src/${project}/venv" ]]; then
            # Ref:
            # https://www.thegeekstuff.com/2010/07/bash-string-manipulation/
            new_var="/src/${project}/${var##*/${project}/}"
        else
            new_var="/src/${var#*/${project}/}"
        fi
        #echo $var to $new_var
        new_args+=("$new_var")
    else
        new_args+=("$var")
    fi
done

if [[ -d "/src/${project}/venv" ]]; then
    /src/${project}/venv/bin/python "${new_args[@]}"
elif [[ -d "/src/${subproject}/venv" ]]; then
    cd /src/${subproject}
    PYTHONPATH=/src/${subproject} \
        /src/${subproject}/venv/bin/python "${new_args[@]}"
else
    /src/venv/bin/python "${new_args[@]}"
fi
