.PHONY: build
build:
	bundle exec middleman build

.PHONY: publish
publish:
	ALLOW_DIRTY=1 bundle exec rake publish