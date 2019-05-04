FROM node:12-alpine

# Minimal environment
# Ref:  https://serverless.com/framework/docs/getting-started/
# Ref:  https://github.com/jch254/docker-node-serverless
RUN yarn global add serverless@1.41.1

# To run the 'sls' command from the host via this Docker container, create 
# the alias:
# alias sls='docker run --rm -v $HOME/.aws/config:/root/.aws/credentials -v $PWD:/root martian111/serverless'
WORKDIR /root
ENTRYPOINT ["serverless"]
