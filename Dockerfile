FROM bfren/nginx-php:php8.2-7.1.2

LABEL org.opencontainers.image.source="https://github.com/bfren/docker-freshrss"

ARG BF_IMAGE
ARG BF_VERSION

COPY ./overlay /

ENV \
    # server environment ('production' or 'development' for additional log messages)
    BF_FRESHRSS_ENVIRONMENT="production" \
    # base URL of FreshRSS instance
    BF_FRESHRSS_BASE_URL= \
    # display language (see FreshRSS documentation for supported language)
    BF_FRESHRSS_LANG="en" \
    # default user name
    BF_FRESHRSS_USER_NAME= \
    # default user password
    BF_FRESHRSS_USER_PASS= \
    # database type ('sqlite', 'mysql' or 'pgsql')
    BF_FRESHRSS_DB_TYPE="mysql" \
    # database host
    BF_FRESHRSS_DB_HOST= \
    # database user
    BF_FRESHRSS_DB_USER= \
    # database password
    BF_FRESHRSS_DB_PASS= \
    # database name
    BF_FRESHRSS_DB_NAME="freshrss"\
    # database table prefix (will have an underscore added, e.g. 'fr_')
    BF_FRESHRSS_DB_PREFIX="fr"

RUN bf-install

VOLUME [ "/data" ]
