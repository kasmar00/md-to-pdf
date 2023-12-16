all: stamped.pdf

install:
	pipenv install
	npm i

stamped.pdf: out.pdf stamp.pdf
	./cpdf -stamp-on stamp.pdf out.pdf -o stamped.pdf

out.pdf: site/print_page/index.html print-headless.js
	node print-headless.js file:///Users/marcin.kasznia/hobby/mkdocs/site/print_page/index.html out.pdf 'title'

site/print_page/index.html: docs/
	pipenv run mkdocs build

stamp.pdf: stamp.html
	node print-headless.js file:///Users/marcin.kasznia/hobby/mkdocs/stamp.html stamp.pdf 'title'

clean:
	rm stamp.pdf out.pdf
	rm -r site