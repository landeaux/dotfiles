# CLAUDE.md

## Responses

- Provide concise, focused responses. Skip non-essential context and keep examples minimal.

## Git & Commits

- Use conventional commits: `type(scope):` where type is `feat`, `fix`, `refactor`, `chore`, `docs`, etc. Scope is
  optional.
- Do not commit ephemeral session artifacts: plan-mode/superpowers specs and plans (e.g., `docs/plans/*.md`,
  `docs/superpowers/plans/*.md`, `docs/superpowers/specs/*.md`), code-review writeups, and scratch files generated
  during a session. Don't reference them from committed files, MR/PR descriptions, issues, commit messages, or code
  comments. This is scoped to session scratch — some projects legitimately track files under `docs/` (design docs,
  ADRs), so don't blanket-skip everything in `docs/`.
- When committing, only commit what the user specifies. Do not commit when told not to. Always check for leftover
  debugging code before committing.
- In a multi-change task, run change → verify → commit as one cycle per change. Don't batch all edits and commit at the
  end — each commit should be independently verifiable and the working tree should never hold unrelated edits.
- Each commit should do one thing. Separate behavioral changes from structural refactors — commit the refactor first
  (preserving existing behavior), then the behavioral change separately, so each is reviewable in isolation.

## Code Style & Principles

- Prefer the simplest solution first. Do not over-engineer or add premature abstractions. When refactoring, narrow scope
  to exactly what's requested — don't expand to related changes unless asked.

## Code Quality

- Fix lint/type errors properly — never use `noqa`, `type: ignore`, or casts unless explicitly approved. Prefer
  restructuring code to satisfy the checker.

## Testing

- Drive behavior changes with TDD: establish baseline green, write/adjust a test that fails for the right reason, make
  the change, re-run to confirm green, then commit. Don't write tests-after — they pass immediately and prove nothing
  about whether they exercise the new behavior.
- Exceptions that need no failing test: doc-only changes (comments, docstrings) and pure refactors (no behavior change).
  Verify the relevant baseline (lint/tests), make the change, stay green, commit.

## Code Review

- Do not edit production code or add tests during code review tasks unless explicitly asked. Reviews should be read-only
  analysis by default.

## Tool Use

- Don't pass `git -C <path>` when the shell's working directory is already the target repository — use plain
  `git status`, `git branch --show-current`, etc. The Bash tool's cwd persists across calls, so `-C` is redundant.
  (Running from outside the repo, `-C` is still fine.)

## GitLab (glab)

- When creating a draft MR, use `--draft` alone — it auto-prefixes the title with `Draft:`. Do not also add a
  `Draft:` prefix to `--title`, or the title becomes `Draft: Draft: ...`.

---

@~/.claude/CLAUDE.local.md
