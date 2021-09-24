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

archives=( arg bz2 deb gz jar lzh rar rpm tar taz tgz Z z zip )
images=( bmp gif jpeg jpg pbm pgm png ppm tif tiff xbm xpm )
video=( asf avi dl fli flv gl m4v mkv mov mp4 mpeg mpg qt webm wmv xcf xwd )
audio=( aiff flac mp3 ogg wav wma )

for EXTENSION in ${archives[*]}; do
  LS_COLORS="${LS_COLORS}:*.${EXTENSION}=$(_ansi bright);$(_ansi red)"
done

for EXTENSION in ${images[*]} ${video[*]} ${audio[*]}; do
  LS_COLORS="${LS_COLORS}:*.${EXTENSION}=$(_ansi bright);$(_ansi magenta)"
done

export LS_COLORS
