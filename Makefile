
install:
	@mkdir -p ${HOME}/.local/bin
	@mkdir -p ${HOME}/.local/share
	@chmod 755 src/bibleq/bq.sh
	@cp -rf src/bibleq ${HOME}/.local/share 
	@ln -s ${HOME}/.local/share/bibleq/bq.sh ${HOME}/.local/bin/bq

uninstall:
	@rm -rfv ${HOME}/.local/share/bibleq
	@rm -fv ${HOME}/.local/bin/bq