use bf
use bf-freshrss
bf env load

def main [] {
    # get variables
    let fr_data = bf env FR_DATA
    let fr_src_data = bf env fr_src_data

    # ensure /data is symlinked from source
    if ($fr_src_data | bf fs is_not_symlink) {
        bf write $"Deleting ($fr_src_data) and recreating it as a symlink."
        rm --force $fr_src_data
        ^ln -s $fr_data $fr_src_data
    }

    # if there is a valid config file, mark the installation as complete
    if (bf env FR_CONFIG | path exists) { bf-freshrss install complete }
}
