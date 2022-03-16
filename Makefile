SHELL := /usr/bin/env bash

EMACS ?= emacs
EASK ?= eask

PKG-FILES := eask-mode.el

TEST-FILES := $(shell ls test/eask-mode-*.el)

.PHONY: clean checkdoc lint build compile unix-test

ci: clean build compile

build:
	$(EASK) install

compile:
	@echo "Compiling..."
	@$(EASK) $(EMACS) -Q --batch \
		-L . \
		--eval '(setq byte-compile-error-on-warn t)' \
		-f batch-byte-compile $(PKG-FILES)

unix-test:
	@echo "Testing..."
	$(EASK) exec ert-runner -L . $(LOAD-TEST-FILES) -t '!no-win' -t '!org'

clean:
	rm -rf .eask *.elc
