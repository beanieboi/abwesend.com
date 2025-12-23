.PHONY: install
install:
	bundle

.PHONY: build
build: install
	bundle exec jekyll build

.PHONY: serve
serve: install
	bundle exec jekyll serve

.PHONY: publish
publish: build
	cd _site && \
	git init && \
	git add -A && \
	git commit -m "Deploy to GitHub Pages" && \
	git push -f origin HEAD:gh-pages
