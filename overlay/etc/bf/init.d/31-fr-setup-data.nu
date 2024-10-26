use bf
use bf-freshrss
bf env load

def main [] {
    # ensure source files exist
    if (bf env FR_SRC | bf fs is_not_dir) { bf write error "FreshRSS source files cannot be found." }

    # get variables
    let fr_data = bf env FR_DATA
    let fr_src_data = bf env FR_SRC_DATA

    # ensure /data is symlinked from source
    if ($fr_src_data | bf fs is_not_symlink) {
        bf write $"Deleting ($fr_src_data) and recreating it as a symlink."
        rm --force --recursive $fr_src_data
        ^ln -s $fr_data $fr_src_data
    }

    # if there is a valid config file, mark the installation as complete
    if (bf env FR_CONFIG | path exists) { bf-freshrss install complete }
}
