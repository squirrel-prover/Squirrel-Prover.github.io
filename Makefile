PANDOC = pandoc --syntax-definition squirrel.xml
IFORMAT = markdown

FLAGS = --standalone --mathjax=$(MATHJAX)


ifdef MATHJAX_LOCAL
  MATHJAX = ${MATHJAX_LOCAL}
else
  MATHJAX ?= "https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"
endif

TEMPLATE_HTML = template/template.html

all: index.html tutorial.html examples.html

index.html: index_src.md
	$(PANDOC) \
	  --template $(TEMPLATE_HTML)\
          --citeproc\
	  -t html -o $@ $<

tutorial.html: tutorial_src.md squirrel-prover/examples/tutorial/tutorial.sp tutorial_header.md
	./tutorial.sh
	$(PANDOC) \
	  --template $(TEMPLATE_HTML)\
	  -t html -o $@ $<

examples.html: examples_src.md
	$(PANDOC) \
	  --template $(TEMPLATE_HTML)\
	  -t html -o $@ $<

clean:
	-rm -f *.html
