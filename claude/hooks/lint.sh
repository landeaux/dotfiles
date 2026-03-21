#!/usr/bin/env bash
# PostToolUse hook: lint files after Write|Edit
# Mirrors none-ls diagnostics config.
# Always exits 0 — lint errors are reported as directive messages on stdout
# so Claude receives them as actionable context.

set -uo pipefail

file=$(jq -r '.tool_response.filePath // .tool_input.file_path')

# Resolve project root (nearest dir with .venv) from the file being edited,
# so the hook works even when CWD differs (e.g. git worktrees).
find_venv() {
	local dir
	dir=$(dirname "$1")
	while [ "$dir" != "/" ]; do
		if [ -d "$dir/.venv" ]; then
			echo "$dir/.venv"
			return 0
		fi
		dir=$(dirname "$dir")
	done
	return 1
}

venv=$(find_venv "$file") || venv=""

run_ruff() {
	local out
	if [ -n "$venv" ] && [ -x "$venv/bin/ruff" ]; then
		out=$("$venv/bin/ruff" check "$1" 2>&1) || true
	elif command -v ruff >/dev/null; then
		out=$(ruff check "$1" 2>&1) || true
	else
		return
	fi
	if [ -n "$out" ] && ! echo "$out" | grep -q "^All checks passed"; then
		echo "Ruff check failed. Please fix these lint errors:"
		echo "$out"
	fi
}

run_mypy() {
	local out
	if [ -n "$venv" ] && [ -x "$venv/bin/mypy" ]; then
		out=$("$venv/bin/mypy" "$1" 2>&1) || true
	elif command -v mypy >/dev/null; then
		out=$(mypy "$1" 2>&1) || true
	else
		return
	fi
	if [ -n "$out" ] && ! echo "$out" | grep -q "^Success:"; then
		echo "Mypy type check failed. Please fix these type errors:"
		echo "$out"
	fi
}

run_eslint_d() {
	local out
	if command -v eslint_d >/dev/null; then
		out=$(eslint_d "$1" 2>&1) || true
	else
		return
	fi
	if [ -n "$out" ]; then
		echo "ESLint check failed. Please fix these lint errors:"
		echo "$out"
	fi
}

run_markdownlint() {
	local out
	if command -v markdownlint-cli2 >/dev/null; then
		out=$(markdownlint-cli2 --config ~/.markdownlint-cli2.jsonc "$1" 2>&1) || true
	else
		return
	fi
	if [ -n "$out" ]; then
		echo "Markdownlint check failed. Please fix these lint errors:"
		echo "$out"
	fi
}

run_selene() {
	local out
	if command -v selene >/dev/null; then
		out=$(selene "$1" 2>&1) || true
	else
		return
	fi
	if [ -n "$out" ]; then
		echo "Selene check failed. Please fix these lint errors:"
		echo "$out"
	fi
}

run_hadolint() {
	local out
	if command -v hadolint >/dev/null; then
		out=$(hadolint "$1" 2>&1) || true
	else
		return
	fi
	if [ -n "$out" ]; then
		echo "Hadolint check failed. Please fix these lint errors:"
		echo "$out"
	fi
}

case "$file" in
# python: ruff check + mypy
*.py)
	run_ruff "$file"
	run_mypy "$file"
	;;
# js/ts/vue: eslint_d
*.js | *.mjs | *.cjs | *.jsx | *.ts | *.mts | *.cts | *.tsx | *.vue)
	run_eslint_d "$file"
	;;
# markdown: markdownlint-cli2
*.md | *.mdx)
	run_markdownlint "$file"
	;;
# lua: selene
*.lua)
	run_selene "$file"
	;;
# dockerfile: hadolint
Dockerfile | Dockerfile.* | *.dockerfile)
	run_hadolint "$file"
	;;
esac

exit 0
