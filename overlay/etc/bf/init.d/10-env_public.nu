use bf
bf env load

# Override Nginx public environment variable to point to FreshRSS source
def main [] {
    let fr_src = $"(bf env ETC_SRC)/freshrss"
    bf env set FR_SRC $fr_src
    bf env set NGINX_PUBLIC $"($fr_src)/p"
}
