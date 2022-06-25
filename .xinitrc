# load X settings
xrdb ~/.Xresources

# fix certain programs which require wmname detection
wmname LG3D

# set GUI options
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# HiDPI:
# export QT_SCALE_FACTOR=2
# export GDK_SCALE=2
# export ELM_SCALE=2

# load fonts
xset +fp /usr/share/fonts/TTF
xset fp rehash

# setup touchpad
if which xsetwacom > /dev/null; then
  xsetwacom set "Wacom Intuos S 2 Pad pad" Button 3 "key +ctrl z -ctrl"
  xsetwacom set "Wacom Intuos S 2 Pad pad" Button 1 "key +ctrl +shift z -shift -ctrl"
  xsetwacom set "Wacom Intuos S 2 Pad pad" Button 9 "key +"
  xsetwacom set "Wacom Intuos S 2 Pad pad" Button 8 "key -"
  xsetwacom set "Wacom Intuos S 2 Pen stylus" Button 3 "button 3"
fi

# start displaying statistics
(conky | while read LINE; do xsetroot -name "$LINE"; done) &

# start notifications
dunst &

# window manager
exec dwm
