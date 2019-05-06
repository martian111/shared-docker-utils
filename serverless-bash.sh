function sls() {
    local _runtime=""
    if [[ -f serverless.yml ]]; then
        _runtime=`grep "runtime:" serverless.yml | cut -d ":" -f 2 | tr -d '[:space:]'`
    fi

    if [[ $_runtime = "python3.6" ]]; then
        docker run --rm -v $HOME/.aws/config:/root/.aws/credentials -v $PWD:/src martian111/serverless-python3.6 "$@"
    elif [[ $_runtime = "python3.7" ]]; then
        docker run --rm -v $HOME/.aws/config:/root/.aws/credentials -v $PWD:/src martian111/serverless-python3.7 "$@"
    else
        docker run --rm -v $HOME/.aws/config:/root/.aws/credentials -v $PWD:/src martian111/serverless "$@"
    fi
}
