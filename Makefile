all: JSMpaper.pdf 
 
JSMpaper.pdf: JSMpaper.Rnw 
	Rscript -e 'library(knitr);Sweave2knitr("JSMpaper.Rnw")'
	Rscript -e 'library(knitr);knit("JSMpaper-knitr.Rnw")'
	pdflatex JSMpaper-knitr.tex
	pdflatex JSMpaper-knitr.tex
	pdflatex JSMpaper-knitr.tex
	dvipdf JSMpaper-knitr.dvi JSMpaper.pdf

clean:
	rm JSMpaper-knitr.Rnw JSMpaper-knitr.dvi JSMpaper.pdf JSMpaper-knitr.tex *.log *.aux 
