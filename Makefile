TYPST_VERSION := 0.14.2
TYPST_TARGET := $(shell uname -m | sed s/arm64/aarch64/)-$(if $(filter Darwin,$(shell uname -s)),apple-darwin,unknown-linux-musl)
FONT_URL := https://mirrors.ctan.org/fonts/newcomputermodern/otf

TYPST := $(or $(shell command -v typst),.deps/typst)
export TYPST_FONT_PATHS ?= .deps/fonts

OUT := thesis.pdf

.PHONY: thesis two-sided watch font

two-sided: ARGS := --input two-sided=true
two-sided: OUT := thesis-two-sided.pdf

# Fails on missing alt text (PDF/UA-1) and on any warning, which Typst itself
# cannot treat as an error.
thesis two-sided: font
	$(TYPST) compile --pdf-standard ua-1 $(ARGS) thesis.typ $(OUT) 2>&1 | tee /dev/stderr | { ! grep -E '^(warning|error):' >/dev/null; }

watch: font
	$(TYPST) watch --pdf-standard ua-1 thesis.typ

# Uses the host's font if Typst finds it, otherwise downloads it into .deps/fonts/.
font: | $(TYPST)
	@$(TYPST) fonts | grep -qx 'New Computer Modern Sans' || \
	  for style in Regular Bold; do \
	    curl -fsSL --create-dirs -o .deps/fonts/NewCMSans10-$$style.otf $(FONT_URL)/NewCMSans10-$$style.otf; \
	  done

.deps/typst:
	mkdir -p .deps
	curl -fsSL https://github.com/typst/typst/releases/download/v$(TYPST_VERSION)/typst-$(TYPST_TARGET).tar.xz \
	  | tar -xJ -C .deps --strip-components 1 typst-$(TYPST_TARGET)/typst
