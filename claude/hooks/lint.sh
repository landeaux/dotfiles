#!/usr/bin/env bash
# PostToolUse hook: lint files after Write|Edit
# Mirrors none-ls diagnostics config.

set -uo pipefail

file=$(jq -r '.tool_response.filePath // .tool_input.file_path')

case "$file" in
# python: ruff check + mypy
*.py)
	if [ -x .venv/bin/ruff ]; then
		.venv/bin/ruff check "$file"
	elif command -v ruff >/dev/null; then
		ruff check "$file"
	fi

	if [ -x .venv/bin/mypy ]; then
		.venv/bin/mypy "$file"
	elif command -v mypy >/dev/null; then
		mypy "$file"
	fi
	;;
# js/ts/vue: eslint_d
*.js | *.mjs | *.cjs | *.jsx | *.ts | *.mts | *.cts | *.tsx | *.vue)
	if command -v eslint_d >/dev/null; then
		eslint_d "$file"
	fi
	;;
# markdown: markdownlint-cli2
*.md | *.mdx)
	if command -v markdownlint-cli2 >/dev/null; then
		markdownlint-cli2 "$file"
	fi
	;;
# lua: selene
*.lua)
	if command -v selene >/dev/null; then
		selene "$file"
	fi
	;;
# dockerfile: hadolint
Dockerfile | Dockerfile.* | *.dockerfile)
	if command -v hadolint >/dev/null; then
		hadolint "$file"
	fi
	;;
esac

exit 0
