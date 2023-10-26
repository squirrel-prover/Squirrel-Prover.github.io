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

tutorial.html: tutorial_src.md squirrel-prover/examples/basic-tutorial/tutorial.sp tutorial_header.md
	./tutorial.sh
	$(PANDOC) \
	  --template $(TEMPLATE_HTML)\
	  -t html -o $@ $<

examples.html: examples_src.md
	$(PANDOC) \
	  --template $(TEMPLATE_HTML)\
	  -t html -o $@ $<

doc: 
	rm -rf documentation
	cd squirrel-prover && \
	make refman-html
	cp -r squirrel-prover/_build/default/documentation/sphinx/public documentation

jsquirrel: doc
	rm -rf jsquirrel
	cd squirrel-prover && \
	make zipsquirrel
	cp -r squirrel-prover/_build/default/app/www jsquirrel

clean:
	-rm -f *.html
