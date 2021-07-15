all: emerald

emerald:
	crystal build main.cr
	mv main emerald

install: emerald
	cp emerald /usr/local/bin

uninstall:
	rm -f /usr/local/bin/emerald

update: uninstall install