#! /bin/sh

xsetroot -solid plum
# xterm -ls -fn 10x20 -geo 78x36+0+0 &
# xterm -ls -fn 10x20 -geo 78x36-0-0 &

xterm -ls -fn 12x24 -geo -30-30 &
xterm -ls -fn 12x24 -geo -30+30 &
xterm -ls -fn 12x24 -geo +30-30 &
xterm -ls -fn 12x24 -geo +30+30 &

# [1] System .twmrc is in the wrong place
# [2] User   .twmrc replaces, not adds to

test -f .twmrc ||
cat .twm /etc/X11/twm/system.twmrc > .twmrc

type twm && exec twm
type dwm && exec dwm
