pdfdestdir  := pdfs
pdffile     := $(pdfdestdir)/cursus.pdf
pubpdf      := $(pubdir)/$(pdffile)
wkhtmltopdf := /opt/wkhtmltox/bin/wkhtmltopdf

.PHONY: pdf
pdf: $(pdffile) $(pubpdf)

$(pdffile): $(shell find $(pubdir)/* -type f) make/pdf.mk | $(pdfdestdir) $(wkhtmltopdf)
	$(wkhtmltopdf) localhost:8000/cursus.html $@

$(pubpdf): $(pdffile)
	mkdir -p $(dir $@)
	cp -f $< $@

$(pdfdestdir):
	mkdir -p $@
