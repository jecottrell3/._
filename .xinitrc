#! /bin/sh

xsetroot -solid plum
xmodmap -e 'pointer = 1 3 2'
setxkbmap -option ctrl:nocaps -option shift:both_shiftlock
ssh-add -l || ssh-add

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

type twm	&& exec twm
type ratpoison	&& exec ratpoison
type metacity	&& exec metacity
type awesome	&& exec awesome
type dwm	&& exec dwm
