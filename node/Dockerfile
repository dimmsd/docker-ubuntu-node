ARG UBUNTU_VERSION
FROM dimmsd/ubuntu-base:$UBUNTU_VERSION
MAINTAINER Dimm <tirri@yandex.ru>
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get -y install --no-install-recommends \
    git sudo curl build-essential libssl-dev libpng-dev autoconf \
# clean
    && apt-get -y autoremove \
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
# dirs
    && mkdir -p /tmp/utils \
    && mkdir -p /tmp/utils_node \
    && mkdir -p /tmp/user_template \
    && mkdir -p /var/www/node \
    && mkdir -p /var/www/main \
    && mkdir -p /var/www/default

COPY ./node-init.sh /usr/local/bin/
COPY ./utils/* /tmp/utils_node/
COPY ./user_template/* /tmp/user_template/

WORKDIR /var/www/node

CMD ["/usr/local/bin/node-init.sh"]

ARG COMMIT
ENV LAST_COMMIT=$COMMIT