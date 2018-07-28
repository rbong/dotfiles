# load terminal emulator settings
xrdb ~/Xresources

# fix certain programs which require wmname detection
wmname LG3D

# set GUI options
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# load fonts
xset +fp /usr/share/fonts
xset fp rehash

# start displaying statistics
(conky | while read LINE; do xsetroot -name "$LINE"; done) &

# start notifications
dunst &

# window manager
exec dwm
