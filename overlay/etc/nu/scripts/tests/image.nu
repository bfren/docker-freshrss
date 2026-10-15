use std/assert
use bf

const src = "/etc/bf/src/freshrss"


#======================================================================================================================
# installation
#======================================================================================================================

export def install__source_is_owned_by_www [] {
    # only the owner is checked - FreshRSS's own cli/access-permissions.sh (run during installation) sets the group
    # to www-data, and PHP-FPM runs as the www user so can still read the files
    assert equal "www" (^stat -c "%U" $src | str trim) "the source directory should be owned by www"
    assert equal "www" (^stat -c "%U" $"($src)/p/index.php" | str trim) "source files should be owned by www"
}

export def install__freshrss_version_matches_build [] {
    let expected = with-env {BF_ETC: "/etc/bf"} { bf build | get FreshRSS }

    assert (open --raw $"($src)/constants.php" | str contains $"'($expected)'") $"constants.php should contain FreshRSS version ($expected)"
}

export def install__required_extensions_are_loaded [] {
    let modules = ^php -m | lines | str trim | str lowercase
    let required = [ctype curl dom fileinfo gmp iconv intl mbstring pdo_mysql pdo_pgsql pdo_sqlite session xml zip]

    for x in $required { assert ($x in $modules) $"the ($x) extension should be loaded" }
}

export def install__fr_actualize_is_executable [] {
    assert ((which fr-actualize | length) > 0) "fr-actualize should be on the PATH"
}


#======================================================================================================================
# nginx
#======================================================================================================================

export def nginx__freshrss_configuration_is_valid [] {
    # test a copy, as tests run in parallel
    let dir = mktemp --directory
    ^cp -a /etc/nginx/. $dir
    let result = ^nginx -t -c $"($dir)/nginx.conf" | complete
    rm --recursive --force $dir

    assert equal 0 $result.exit_code $"nginx -t failed: ($result.stderr)"
}
