all: emerald py2em

emerald:
	crystal build main.cr -o emerald

py2em:
	crystal build py2em1/py2em.cr -o py2em

install: all
	cp emerald /usr/local/bin

uninstall:
	rm -f /usr/local/bin/emerald

update: uninstall install