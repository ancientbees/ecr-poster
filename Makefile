NAME := example

SRC := \
		$(NAME).tex \
		ecrposter.cls

.PHONY: clean

$(NAME).pdf: $(SRC)
	if which latexmk > /dev/null 2>&1; then \
		latexmk -pdf -f -pdflatex='pdflatex -halt-on-error -file-line-error' $<;\
	else \
		pdflatex -halt-on-error -file-line-error $< && \
		bibtex $(patsubst %.tex,%,$<) && \
		pdflatex -halt-on-error -file-line-error $< ;\
		pdflatex -halt-on-error -file-line-error $< ;\
	fi

clean:
	$(RM) *.aux *.log *.out *.vrb $(NAME).pdf \
	$(NAME).bbl $(NAME).blg $(NAME).fdb_latexmk \
	$(NAME).toc $(NAME).fls
