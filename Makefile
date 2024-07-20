# Make. https://www.gnu.org/software/make/


# Setup

.PHONY: setup
setup:
	make build

.PHONY: build
build:
	mix do deps.get + deps.compile + compile

.PHONY: reset
reset:
	rm -fR _build deps doc


# Code Quality

.PHONY: lint
lint:
	mix format --check-formatted

.PHONY: fmt
fmt:
	mix format

.PHONY: analyze
analyze:
	mix dialyzer

.PHONY: test
test:
	mix test

.PHONY: test.watch
test.watch:
	find -E lib test -regex .*exs?$ | entr -c mix test

.PHONY: test.full
test.full:
	make lint \
	&& make analyze \
	&& make test


# Docs

.PHONY: docs
docs:
	mix docs

.PHONY: docs.watch
docs.watch:
	find -E . -regex .*exs?$ | grep -Ev "(\.elixir_ls|\.git|_build|deps|test)" | entr -c mix docs
