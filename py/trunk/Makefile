all:		gen
install:	gen copy

ks:
	mkdir ks

gen:	ks
	./kick.py

copy:
	rsync -Crvp ks /home

clean:
	rm -f ks/*
