# CLAUDE.md

## Git & Commits

- When in plan mode or using superpowers skills like brainstorming and writing-plans, do not commit the generated
  planning artifacts (e.g., `docs/plans/*.md`, `docs/superpowers/plans/*.md`, `docs/superpowers/specs/*.md`).
- When committing, only commit what the user specifies. Do not commit when told not to. Always check for leftover
  debugging code before committing.

## Code Style & Principles

- Prefer the simplest solution first. Do not over-engineer or add premature abstractions. When refactoring, narrow scope
  to exactly what's requested — don't expand to related changes unless asked.

## Code Quality

- Fix lint/type errors properly — never use `noqa`, `type: ignore`, or casts unless explicitly approved. Prefer
  restructuring code to satisfy the checker.

## Code Review

- Do not edit production code or add tests during code review tasks unless explicitly asked. Reviews should be read-only
  analysis by default.

## Tool Use

- Use `fd` instead of `find` when running shell commands.
- Use `rg` instead of `grep` when running shell commands.

---

@~/.claude/CLAUDE.local.md
