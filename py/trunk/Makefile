all:		gen
install:	copy

ks:
	mkdir ks

gen:	ks
	./kick.py

copy:	gen
	rsync -vax ks /home

clean:
	rm -f ks/*
