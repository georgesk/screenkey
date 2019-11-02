DESTDIR =
POFILES = $(shell ls po/*.po)
PODEPS = $(shell cat po/POTFILES.in)
MOFILES = $(patsubst %.po, %.mo, $(POFILES)) 

lang: $(MOFILES)

po/%.po: $(PODEPS)
	xgettext --files-from=po/POTFILES.in  --output=po/messages.pot
	msgmerge --update --backup=off $@ po/messages.pot
po/%.mo: po/%.po
	msgfmt -o $@ $<
