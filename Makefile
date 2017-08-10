all: JSMpaper-knitr.Rnw JSMpaper-knitr.tex JSMpaper-knitr.dvi JSMpaper.pdf 
 
JSMpaper-knitr.Rnw: JSMpaper.Rnw 
	Rscript -e 'library(knitr);Sweave2knitr("JSMpaper.Rnw")'

JSMpaper-knitr.tex: JSMpaper-knitr.Rnw
	Rscript -e 'library(knitr);knit("JSMpaper-knitr.Rnw")'

JSMpaper-knitr.dvi:
	pdflatex JSMpaper-knitr.tex
	pdflatex JSMpaper-knitr.tex
	pdflatex JSMpaper-knitr.tex

JSMpaper.pdf: JSMpaper-knitr.dvi
	dvipdf JSMpaper-knitr.dvi JSMpaper.pdf

clean:
	rm JSMpaper-knitr.Rnw JSMpaper-knitr.dvi JSMpaper.pdf JSMpaper-knitr.tex *.log *.aux 
