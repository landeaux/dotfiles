#!/usr/bin/env bash
# PostToolUse hook: auto-format files after Write|Edit
# Mirrors conform.nvim formatters_by_ft config.

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

run_prettierd() {
	if command -v prettierd >/dev/null; then
		prettierd "$1" <"$1" | sponge "$1"
	fi
}

run_eslint_d() {
	if command -v eslint_d >/dev/null; then
		eslint_d --fix "$1"
	fi
}

run_ruff() {
	if [ -n "$venv" ] && [ -x "$venv/bin/ruff" ]; then
		"$venv/bin/ruff" check --select I --fix "$1"
		"$venv/bin/ruff" format "$1"
	elif command -v ruff >/dev/null; then
		ruff check --select I --fix "$1"
		ruff format "$1"
	fi
}

run_stylua() {
	if command -v stylua >/dev/null; then
		stylua "$1"
	fi
}

run_shfmt() {
	if command -v shfmt >/dev/null; then
		shfmt -w "$1"
	fi
}

case "$file" in
# python: ruff_organize_imports + ruff_format
*.py)
	run_ruff "$file"
	;;
# prettierd + eslint_d
*.js | *.mjs | *.cjs)
	run_prettierd "$file"
	run_eslint_d "$file"
	;;
*.jsx)
	run_prettierd "$file"
	run_eslint_d "$file"
	;;
*.ts | *.mts | *.cts)
	run_prettierd "$file"
	run_eslint_d "$file"
	;;
*.tsx)
	run_prettierd "$file"
	run_eslint_d "$file"
	;;
*.vue)
	run_prettierd "$file"
	run_eslint_d "$file"
	;;
# prettierd only
*.md | *.mdx) run_prettierd "$file" ;;
*.css) run_prettierd "$file" ;;
*.scss) run_prettierd "$file" ;;
*.less) run_prettierd "$file" ;;
*.html) run_prettierd "$file" ;;
*.json) run_prettierd "$file" ;;
*.jsonc) run_prettierd "$file" ;;
*.yaml | *.yml) run_prettierd "$file" ;;
*.graphql | *.gql) run_prettierd "$file" ;;
*.hbs) run_prettierd "$file" ;;
# lua: stylua
*.lua)
	run_stylua "$file"
	;;
# shell: shfmt
*.sh | *.bash | *.zsh)
	run_shfmt "$file"
	;;
esac

exit 0
