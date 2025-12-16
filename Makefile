.DEFAULT_GOAL := cv.pdf
.PHONY: clean

clean:
	rm -f cv.aux cv.log cv.pdf cv.out

cv.pdf: clean
	lualatex cv.tex
