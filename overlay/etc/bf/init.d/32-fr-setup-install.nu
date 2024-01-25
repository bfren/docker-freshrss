use bf
use bf-freshrss
bf env load

def main [] {
    # get variables
    let fr_src_cli = bf env FR_SRC_CLI
    let fr_src_data = bf env FR_SRC_DATA
    let fr_user = bf env FR_USER
    let fr_pass = bf env FR_PASS
    let fr_environment = bf env FR_ENVIRONMENT
    let fr_base_url = bf env FR_BASE_URL
    let fr_db_type = bf env FR_DB_TYPE
    let fr_db_host = bf env FR_DB_HOST
    let fr_db_user = bf env FR_DB_USER
    let fr_db_pass = bf env FR_DB_PASS
    let fr_db_name = bf env FR_DB_NAME
    let fr_db_prefix = bf env FR_DB_PREFIX

    # if data source is not a symlink, the content setup has not worked correctly
    if ($fr_src_data | bf fs is_not_symlink) { bf write error $"($fr_src_data) is not set up correctly." }

    # if an existing installation was detected, do not proceed
    if (bf env check FR_INSTALLED) {
        bf write "Existing installation detected - do not reinstall."
        bf-freshrss install complete
        return
    }

    # use CLI to run automated installation
    bf write "Using CLI to install FreshRSS."
    cd $fr_src_cli

    # ensure all the needed directories are in the data dir
    bf write  " .. preparing data directories"
    ^php ./prepare.php

    # install default database
    bf write " .. installing database"
    let args = [
        "--default_user" $fr_user
        "--environment" $fr_environment
        "--base_url" $fr_base_url
        "--db-type" $fr_db_type
        "--db-host" $fr_db_host
        "--db-user" $fr_db_user
        "--db-password" $fr_db_pass
        "--db-base" $fr_db_name
        "--db-prefix" $fr_db_prefix
    ] | str join " "
    ^php ./do-install.php $args

    # create user
    bf write " .. creating user account"
    ^php ./create-user.php --user $fr_user --password $fr_pass
    ^php ./actualize-user.php --user $fr_user

    # disable updates
    bf write " .. disabling updates"
    ^php ./reconfigure.php --disable_update "true"

    # setup complete
    bf-freshrss install complete
}
