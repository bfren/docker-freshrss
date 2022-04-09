FROM bfren/nginx-php:php8.0-4.2.11

LABEL org.opencontainers.image.source="https://github.com/bfren/docker-freshrss"

ARG BF_IMAGE
ARG BF_VERSION

ENV \
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
