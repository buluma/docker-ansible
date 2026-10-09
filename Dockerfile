FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# RUN chmod +x entrypoint.sh
# COPY entrypoint.sh /usr/src/entrypoint.sh

RUN apt-get update && apt-get install -y \
	python3-pip \
	rsync \
	git \
	openssh-client \
	wget \
	gnupg \
	ca-certificates \
	&& rm -rf /var/lib/apt/lists/*
RUN pip3 install --no-cache-dir \
	ansible \
	boto \
	boto3

ARG GOSU_VERSION=1.17
RUN apt-get update && apt-get install -y \
        build-essential \
        libxml2-utils && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN for server in keyserver.ubuntu.com \
        hkp://keyserver.ubuntu.com:80 \
        pgp.mit.edu; \
    do \
        gpg --keyserver "$server" --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && break || echo "Trying new server..."; \
    done
RUN wget -O /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
    && wget -O /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

# RUN chmod +x entrypoint.sh
# COPY entrypoint.sh /entrypoint.sh
# ENTRYPOINT ["/entrypoint.sh"]
# ENTRYPOINT ["/usr/src/entrypoint.sh"]
CMD ["ansible-playbook","--help"]
