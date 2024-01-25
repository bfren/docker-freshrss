use bf
use bf-freshrss
bf env load

def main [] {
    # check whether or not the application is installed
    if (bf-freshrss install check) {
        bf clean
        bf write ok "FreshRSS is installed."
        return
    }

    # installation has not been detected or successful
    bf write error "FreshRSS setup did not complete successfully, terminating container."
}
