FROM python:3.6

# update apt-get
RUN apt-get update -y && apt-get upgrade -y

# Install dev tools and other system dependences
RUN apt-get install -y vim

# Install Anaconda
RUN curl -s -o /tmp/anaconda.tgz https://codeload.github.com/DamnWidget/anaconda/tar.gz/v2.1.29 && \
    mkdir -p /opt/anaconda && \
    tar -xf /tmp/anaconda.tgz --strip-components 1 -C /opt/anaconda && \
    rm -f /tmp/anaconda.tgz

# Other tools
# - python-in-docker is used by Anaconda plugin in Sublime Text 3
COPY python-in-docker.sh /bin/python-in-docker
RUN chmod 755 /bin/python-in-docker
COPY entry.sh /bin/docker-entry
RUN chmod 755 /bin/docker-entry

# Working directory
RUN mkdir -p /src
WORKDIR /src

ENTRYPOINT ["/bin/docker-entry"]

