all:		gen
install:	gen copy

ks:
	mkdir ks

gen:	ks
	./kick.py

copy:
	rsync -crvp ks /home

clean:
	rm -f ks/*
