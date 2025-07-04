FROM ghcr.io/bfren/nginx-php:php8.4.10-7.4.2

LABEL org.opencontainers.image.source="https://github.com/bfren/docker-freshrss"

ARG BF_IMAGE
ARG BF_PUBLISHING
ARG BF_VERSION

COPY ./overlay /

ENV \
    # server environment ('production' or 'development' for additional log messages)
    BF_FR_ENVIRONMENT="production" \
    # base URL of FreshRSS instance
    BF_FR_BASE_URL= \
    # display language (see FreshRSS documentation for supported language)
    BF_FR_LANGUAGE="en" \
    # default user name
    BF_FR_USER_NAME= \
    # default user password
    BF_FR_USER_PASS= \
    # database type ('sqlite', 'mysql' or 'pgsql')
    BF_FR_DB_TYPE="mysql" \
    # database host
    BF_FR_DB_HOST= \
    # database user
    BF_FR_DB_USER= \
    # database password
    BF_FR_DB_PASS= \
    # database name
    BF_FR_DB_NAME="freshrss"\
    # database table prefix (will have an underscore added, e.g. 'fr_')
    BF_FR_DB_PREFIX="fr"

RUN bf-install

VOLUME [ "/data" ]
