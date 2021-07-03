all: blang

blang:
	crystal build main.cr
	mv main blang

install: blang
	cp blang /usr/local/bin

uninstall:
	rm -f /usr/local/bin/blang

update: uninstall install