##
# colors.sh
#
# set colors
#

# standard generic file kind colors

LS_COLORS="no=$(_ansi off)"                                # normal text (everything but filenames)
LS_COLORS="$LS_COLORS:fi=$(_ansi off)"                     # regular file
LS_COLORS="$LS_COLORS:di=$(_ansi bright);$(_ansi yellow)"  # directory
LS_COLORS="$LS_COLORS:ln=$(_ansi cyan)"                    # symbolic link
LS_COLORS="$LS_COLORS:pi=$(_ansi yellow)"                  # named pipe
LS_COLORS="$LS_COLORS:so=$(_ansi bright);$(_ansi magenta)" # socket
LS_COLORS="$LS_COLORS:do=$(_ansi bright);$(_ansi magenta)" # door
LS_COLORS="$LS_COLORS:bd=$(_ansi yellow)"                  # block device
LS_COLORS="$LS_COLORS:cd=$(_ansi yellow)"                  # character device
LS_COLORS="$LS_COLORS:or=$(_ansi bright);$(_ansi green)"   # orphaned symbolic link
LS_COLORS="$LS_COLORS:ex=$(_ansi bright);$(_ansi green)"   # executable file

# color by file extension

archives=( tar tgz arg taz lzh zip z Z gz bz2 deb rpm jar rar )
images=( jpg jpeg gif bmp pbm pgm ppm xbm xpm tif tiff png )
video=( mpg mpeg fli flv avi mkv gl dl xcf xwd mp4 asf qt mov wmv )
audio=( ogg mp3 aiff wav wma )

for EXTENSION in ${archives[*]}; do
  LS_COLORS="${LS_COLORS}:*.${EXTENSION}=$(_ansi bright);$(_ansi red)"
done

for EXTENSION in ${images[*]} ${video[*]} ${audio[*]}; do
  LS_COLORS="${LS_COLORS}:*.${EXTENSION}=$(_ansi bright);$(_ansi magenta)"
done

export LS_COLORS
