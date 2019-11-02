DESTDIR =
POFILES = $(shell ls po/*.po)
PODEPS = $(shell cat po/POTFILES.in)
MOFILES = $(patsubst %.po, %.mo, $(POFILES))
LANGUAGES = $(patsubst po/%.po, %, $(POFILES))

lang: $(MOFILES)

po/%.po: $(PODEPS)
	xgettext --files-from=po/POTFILES.in  --output=po/messages.pot
	msgmerge --update --backup=off $@ po/messages.pot

po/%.mo: po/%.po
	msgfmt -o $@ $<

install: lang
	for l in $(LANGUAGES); do \
	  install po/$$l.mo $(DESTDIR)/usr/share/locale/$$l/LC_MESSAGES/screenkey.mo; \
	done
