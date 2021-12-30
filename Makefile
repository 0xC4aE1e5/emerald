all: emerald

emerald:
	(echo '#!/usr/bin/env -S ruby --disable-all' && cat main.rb) > emerald
	chmod +x emerald
install: all
	cp emerald /usr/local/bin
uninstall:
	rm -f /usr/local/bin/emerald
update: uninstall install
