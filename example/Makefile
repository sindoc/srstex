BASE=.

SRSTEX_BASE=$(BASE)/..
SRSTEX_XSL=$(SRSTEX_BASE)/xsl
SRSTEX_STYLE=$(SRSTEX_XSL)/srstex.xsl
SRSTEX_BINDINGS_STYLE=$(SRSTEX_XSL)/bindings.xsl

all: reqs
.PHONY: reqs clean

reqs.tex: $(SRSTEX_STYLE) $(BASE)/reqs.xml
	xsltproc -o $@ $^

reqs-bindings.tex: $(SRSTEX_BINDINGS_STYLE) $(BASE)/reqs.xml
	xsltproc -o $@ $^

reqs: reqs.tex reqs-bindings.tex

# Uncomment this target if needed
# clean:
# 	find . -maxdepth 1 -name '*reqs*.tex' -exec rm -f {} ';'
