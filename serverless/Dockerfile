FROM node:12-alpine

# Minimal environment
# Ref:  https://serverless.com/framework/docs/getting-started/
# Ref:  https://github.com/jch254/docker-node-serverless
RUN yarn global add serverless@1.41.1

# To run the 'sls' command from the host via this Docker container, source the 
# serverless-bash.sh script from your .bash_profile script.  That will run the
# correct Docker container (this or other ones in this repository) based on the
# runtime configured in the serverless.yml file.
WORKDIR /src
ENTRYPOINT ["serverless"]
