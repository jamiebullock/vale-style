# Part of vale-style
#
# SPDX-FileCopyrightText: 2026 Jamie Bullock
# SPDX-License-Identifier: Zlib

VALE ?= vale
STYLES = styles/Plain styles/Changelog styles/Comments styles/Commit styles/PullRequest styles/Licence
PROJECT = build/package/project

.PHONY: check test prose version package

check: test prose version package

styles/ai-tells: .vale.ini
	$(VALE) sync

test: styles/ai-tells
	$(VALE) test --coverage $(STYLES)

prose: styles/ai-tells
	git -c core.quotePath=false ls-files -z | xargs -0 $(VALE) --no-wrap

version:
	@version="$$(head -n 1 VERSION)"; \
	if ! printf '%s\n' "$$version" | grep -Eqx '[0-9]+\.[0-9]+\.[0-9]+' || ! printf '%s\n' "$$version" | cmp -s - VERSION; then \
	    echo "VERSION must hold major.minor.patch on one line and nothing else."; \
	    exit 1; \
	fi; \
	newest="$$(sed -n 's/^## \[\(.*\)\] - .*/\1/p' CHANGELOG.md | head -n 1)"; \
	if [ "$$newest" != "$$version" ]; then \
	    echo "The newest release in CHANGELOG.md is '$$newest' and VERSION holds $$version."; \
	    exit 1; \
	fi; \
	if grep -o 'releases/download/v[^/]*/vale-style\.zip' README.md | grep -Fqv "releases/download/v$$version/vale-style.zip"; then \
	    echo "README.md names a release that is not $$version."; \
	    exit 1; \
	fi; \
	echo "VERSION, CHANGELOG.md and README.md agree on $$version."

# git archive reads the last commit, so a change is checked here once it is
# committed.
package:
	mkdir -p $(PROJECT)
	git archive --format=zip --prefix=vale-style/ --output build/package/vale-style.zip HEAD
	printf 'StylesPath = .vale/styles\nMinAlertLevel = suggestion\nPackages = %s\n' "$(CURDIR)/build/package/vale-style.zip" > $(PROJECT)/.vale.ini
	printf '# Title\n\nThis sentence is mispelt.\n' > $(PROJECT)/README.md
	cd $(PROJECT) && $(VALE) sync
	cd $(PROJECT) && { $(VALE) --output=line README.md > alerts.txt || true; }
	cat $(PROJECT)/alerts.txt
	grep -q 'Plain.Spelling' $(PROJECT)/alerts.txt
