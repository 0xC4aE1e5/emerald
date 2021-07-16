all: emerald py2em em2elf

emerald:
	crystal build main.cr -o emerald

py2em:
	crystal build py2em1/py2em.cr -o py2em

em2elf:
	crystal build em2elf1/em2elf.cr -o em2elf

install: all
	cp emerald /usr/local/bin
	cp py2em /usr/local/bin
	cp em2elf /usr/local/bin

uninstall:
	rm -f /usr/local/bin/emerald

update: uninstall install