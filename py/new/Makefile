all:		gen
install:	gen copy

ks:
	mkdir ks

gen:	ks
	./kick.py

grub:
	rsync -crvp ks /grub

copy:
	rsync -crvp ks /resq

clean:
	rm -f ks/*
