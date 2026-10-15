use bf
use bf-freshrss
bf env load

def main [] {
    # get source data directory
    let fr_src_data = bf env FR_SRC_DATA

    # if data source is not a symlink, the content setup has not worked correctly
    if ($fr_src_data | bf fs is_not_symlink) { bf write error $"($fr_src_data) is not set up correctly." }

    # if an existing installation was detected, do not proceed
    if (bf env check FR_INSTALLED) {
        bf write "Existing installation detected - do not reinstall."
        bf-freshrss install complete
        return
    }

    # get variables
    let credentials = bf-freshrss install credentials
    let fr_user = $credentials.user
    let fr_pass = $credentials.pass
    let fr_environment = bf env FR_ENVIRONMENT
    let fr_language = bf env FR_LANGUAGE
    let fr_base_url = bf env FR_BASE_URL
    let fr_db_type = bf env FR_DB_TYPE
    # host, user and password are not used by SQLite, so may be empty
    let fr_db_host = bf env --safe FR_DB_HOST
    let fr_db_user = bf env --safe FR_DB_USER
    let fr_db_pass = bf env --safe FR_DB_PASS
    let fr_db_name = bf env FR_DB_NAME
    let fr_db_prefix = bf env FR_DB_PREFIX

    # use CLI to run automated installation
    bf write "Using CLI to install FreshRSS."
    cd (bf env FR_SRC)

    # ensure all the needed directories are in the data dir
    bf write  " .. preparing data directories"
    ^php ./cli/prepare.php

    # install default database
    bf write " .. installing database"
    let args = [
        "--default_user" $fr_user
        "--environment" $fr_environment
        "--base_url" $fr_base_url
        "--language" $fr_language
        "--db-type" $fr_db_type
        "--db-host" $fr_db_host
        "--db-user" $fr_db_user
        "--db-password" $fr_db_pass
        "--db-base" $fr_db_name
        "--db-prefix" $fr_db_prefix
        "--disable_update" "true"
    ]
    ^php ./cli/do-install.php ...$args

    # create user
    bf write " .. creating user account"
    ^php ./cli/create-user.php --user $fr_user --password $fr_pass
    ^php ./cli/actualize-user.php --user $fr_user

    # reset permissions
    cd ..
    ^sh cli/access-permissions.sh
    bf ch --owner www:www --recurse (bf env FR_DATA)

    # setup complete
    bf-freshrss install complete
}
