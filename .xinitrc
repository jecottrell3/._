#! /bin/sh

xsetroot -solid plum
xterm -ls -fn 10x20 -geo 78x40+0-0 &
xterm -ls -fn 10x20 -geo 78x40-0-0 &

# [1] System .twmrc is in the wrong place
# [2] User   .twmrc replaces, not adds to

test -f .twmrc ||
cat .twm /etc/X11/twm/system.twmrc > .twmrc

type twm && exec twm
type dwm && exec dwm
