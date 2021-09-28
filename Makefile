all: emerald empkg

emerald:
	(echo '#!/usr/bin/env ruby' && cat main.rb) > emerald
	chmod +x emerald
empkg:
	(echo '#!/usr/bin/env ruby' && cat empkg.rb) > empkg
	chmod +x empkg
install: all
	cp emerald /usr/local/bin
	cp empkg /usr/local/bin
uninstall:
	rm -f /usr/local/bin/emerald
	rm -f /usr/local/bin/empkg || true
update: uninstall install
