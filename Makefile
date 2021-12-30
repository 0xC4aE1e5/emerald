all: emerald empkg

emerald:
	(echo '#!/usr/bin/env ruby' && cat main.rb) > emerald
	chmod +x emerald
install: all
	cp emerald /usr/local/bin
	cp empkg /usr/local/bin
uninstall:
	rm -f /usr/local/bin/emerald
	rm -f /usr/local/bin/empkg || true
update: uninstall install
