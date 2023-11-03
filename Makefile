.PHONY: setup build reset lint fmt analyze test test.watch

setup:
	make build

build:
	mix do deps.get + deps.compile + compile

reset:
	rm -fR _build deps doc

lint:
	mix format --check-formatted

fmt:
	mix format

analyze:
	mix dialyzer

test:
	mix test

test.watch:
	find -E lib test -regex .*exs?$ | entr -c mix test
