# Git & commits

## Commit messages

Conventional commits: `type(scope): summary`, where type is `feat`, `fix`, `refactor`, `chore`, `docs`, etc. Scope is
optional.

## What goes in a commit

- In a multi-change task, run change → verify → commit as one cycle per change. Each commit is independently verifiable,
  and the working tree never holds unrelated edits.
- Each commit does one thing. Separate structural refactors from behavioural changes: commit the refactor first
  (behaviour preserved), then the behavioural change, so each is reviewable in isolation.
