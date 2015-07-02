response.pdf: corrections.pdf diff.pdf
	pdfjam corrections.pdf diff.pdf
	mv diff-pdfjam.pdf response.pdf

diff.tex: wsc15paper.tex first_submission.tex
	latexdiff first_submission.tex wsc15paper.tex

diff.pdf: diff.tex
	pdflatex diff.tex
	bibtex diff
	pdflatex diff.tex

corrections.pdf: corrections.tex
	pdflatex corrections.tex
