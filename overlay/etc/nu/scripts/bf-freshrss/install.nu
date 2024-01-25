use bf

const installed = "FR_INSTALLED"

# Mark the application as installed.
export def complete [] { bf env set $installed 1}

# Check whether or not the application is installed.
export def check [] { bf env check $installed }
