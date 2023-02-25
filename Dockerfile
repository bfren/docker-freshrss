FROM bfren/nginx-php:php8.2-5.3.27

LABEL org.opencontainers.image.source="https://github.com/bfren/docker-freshrss"

ARG BF_IMAGE
ARG BF_VERSION

ENV \
    # disable debug output by default
    BF_DEBUG=0 \
    # server environment ('production' or 'development' for additional log messages)
    FRESHRSS_ENVIRONMENT="production" \
    # base URL of FreshRSS instance
    FRESHRSS_BASE_URL= \
    # display language (see FreshRSS documentation for supported language)
    FRESHRSS_LANG="en" \
    # default user name
    FRESHRSS_USER_NAME= \
    # default user password
    FRESHRSS_USER_PASS= \
    # database type ('sqlite', 'mysql' or 'pgsql')
    FRESHRSS_DB_TYPE="mysql" \
    # database host
    FRESHRSS_DB_HOST= \
    # database user
    FRESHRSS_DB_USER= \
    # database password
    FRESHRSS_DB_PASS= \
    # database name
    FRESHRSS_DB_NAME="freshrss"\
    # database table prefix (will have an underscore added, e.g. 'fr_')
    FRESHRSS_DB_PREFIX="fr"

COPY ./overlay /

RUN bf-install

VOLUME [ "/data" ]
