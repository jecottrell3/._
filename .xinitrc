#! /bin/sh

xsetroot -solid plum
xterm -ls -fn 10x20 -geo 78x40+0-0 &
xterm -ls -fn 10x20 -geo 78x40-0-0 &
exec twm
