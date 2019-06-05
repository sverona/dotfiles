#!/bin/zsh

source ~/.profile

# source X application preferences
xrdb "$XDG_CONFIG_HOME"/X11/Xresources 

# add local font paths to xfontsel's registry
xset +fp ~/.fonts
xset +fp /usr/share/fonts/local 
xset fp rehash 

# apply keyboard overrides
if [ -s ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
fi
setxkbmap -option ctrl:nocaps
xcape -e 'Control_L=Escape'

# set cursor style  
xsetroot -cursor_name left_ptr

# set timezone
export TZ="America/Chicago"

# tell Qt apps to use GTK style
export QT_STYLE_OVERRIDE="gtk2"

# set window manager and hotkey daemon
export WM="xmonad"

# start miscellaneous background processes
for daemon in compton dunst; do
    $daemon &
done

. $XDG_CONFIG_HOME/wpg/wp_init.sh

exec "$WM" 2> "$XDG_DATA_HOME"/xsession-errors
