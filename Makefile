# Fully build thesis, as specified by README
.PHONY: thesis
thesis:
	pdflatex thesis.tex
	pdflatex thesis.tex
	bibtex thesis
	pdflatex thesis.tex
	pdflatex thesis.tex

# Quickly rebuild
.PHONY: s
s:
	bibtex thesis
	pdflatex thesis.tex

# Quickly rebuild, pdf only
.PHONY: p
p:
	pdflatex thesis.tex

TEXS = $(filter-out Pictures/common.tex,$(wildcard Pictures/*.tex))
PNGS = $(patsubst Pictures/%.tex,pngs/%.png,$(TEXS))

# Generate pngs for all figures and tables
.PHONY: pngs
pngs: $(PNGS)

$(PNGS): pngs/%.png: Pictures/%.tex
	mkdir -p pngs
	./Pictures/generate_png.sh $<

.PHONY: clean
clean:
	rm -f texput.log thesis.{aux,bbl,blg,lof,log,lot,out,pdf,toc,loa} */*.aux
	rm -rf pngs

