FROM python:3.8-alpine

RUN apk update
RUN apk upgrade
RUN apk add ca-certificates && update-ca-certificates
RUN apk add --no-cache --update \
    curl \
    unzip \
    bash \
    openssh \
    make \
    python3-dev \
    gcc \
    musl-dev \
    libffi-dev \
    openssl-dev \
    cargo \
    go \
    nodejs npm

# Install serverless
RUN npm install -g serverless serverless-offline

# Install watcher
RUN go get -u github.com/radovskyb/watcher/...
RUN ln -s /root/go/bin/watcher /usr/local/bin/watcher
ADD scripts/serverless-watcher.sh /var/run/serverless-watcher.sh

# Install python requirements
ADD scripts/import_lib_path.py /var/task/lib/__init__.py
ADD lambda/requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt --target /var/task/lib

WORKDIR /var/task/