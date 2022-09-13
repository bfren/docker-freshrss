FROM bfren/nginx-php:php8.1-5.2.5

LABEL org.opencontainers.image.source="https://github.com/bfren/docker-freshrss"

ARG BF_IMAGE
ARG BF_VERSION

ENV \
    # disable debug output by default
    BF_DEBUG=0 \
    # base URL of FreshRSS instance
    FRESHRSS_BASE_URL= \
    # [Optional] default user name
    FRESHRSS_USER_NAME= \
    # [Optional] default user password
    FRESHRSS_USER_PASS= \
    # MySQL / MariaDB database host
    FRESHRSS_DB_HOST= \
    # MySQL / MariaDB database user
    FRESHRSS_DB_USER= \
    # MySQL / MariaDB database password
    FRESHRSS_DB_PASS= \
    # MySQL / MariaDB database name
    FRESHRSS_DB_NAME=

COPY ./overlay /

RUN bf-install

VOLUME [ "/data" ]
