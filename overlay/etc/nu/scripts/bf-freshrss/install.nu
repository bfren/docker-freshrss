use bf

const installed = "FR_INSTALLED"

# Mark the application as installed.
export def complete [] { bf env set $installed 1}

# Check whether or not the application is installed.
export def check [] { bf env check $installed }

# Get the first user's name and password - BF_FR_USER_NAME / BF_FR_USER_PASS are documented (and set in the Dockerfile),
# BF_FR_USER / BF_FR_PASS are read as a fallback because earlier versions only used those
export def credentials []: nothing -> record<user: string, pass: string> {
    {
        user: (bf env FR_USER_NAME (bf env --safe FR_USER))
        pass: (bf env FR_USER_PASS (bf env --safe FR_PASS))
    }
}
