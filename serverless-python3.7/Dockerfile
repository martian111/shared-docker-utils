FROM python:3.7

# Add NodeJS 8.x package repository
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

# Update system, install basic utilities and install NodeJS 8.x
RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        vim \
        nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install Serverless
# Ref:  https://blog.morizyun.com/blog/javascript-serverless-framework-aws-lambda-python-docker/index.html
RUN npm install -g serverless@1.41.1

# To run the 'sls' command from the host via this Docker container, source the 
# serverless-bash.sh script from your .bash_profile script.  That will run the
# correct Docker container (this or other ones in this repository) based on the
# runtime configured in the serverless.yml file.
WORKDIR /src
ENTRYPOINT ["serverless"]
