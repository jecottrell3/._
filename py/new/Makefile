all:		gen
install:	gen copy

ks:
	mkdir ks

gen:	ks
	./kick.py

grub:
	rsync -crvp ks /grub

copy:
	rsync -crvp ks /boot

clean:
	rm -f ks/*
