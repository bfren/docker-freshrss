use bf
bf env load

# Set environment variables
def main [] {
    let fr_data = "/data"
    bf env set FR_DATA $fr_data
    bf env set FR_CONFIG $"($fr_data)/config.php"

    let fr_src = bf env FR_SRC
    bf env set FR_SRC_CLI $"($fr_src)/cli"
    bf env set FR_SRC_DATA $"($fr_src)/data"
}
