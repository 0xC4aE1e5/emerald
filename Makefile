all: emerald

emerald:
	(echo '#!/usr/bin/env ruby' && cat main.rb) > emerald
	chmod +x emerald
	
install: all
	cp emerald /usr/local/bin

uninstall:
	rm -f /usr/local/bin/emerald
	
update: uninstall install
