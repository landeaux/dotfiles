---
name: address-self-review
description: Act on self-review findings: verify, triage, fix, record leftovers, then stop.
disable-model-invocation: true
---

Act on the findings of a self-review: an agent's review of this branch's own changes, such as a `/code-review` run
at the end of `/implement` or by hand. The findings are already in this conversation or pasted in. If none are in
context, ask the user for them.

## 0. Learn the repo

Find, from the repo's agent docs (`AGENTS.md`, `CLAUDE.md`, `CONTRIBUTING.md`, `docs/agents/`) and its config:

- **Standards**: the documents that say how code is written here (`CODING_STANDARDS.md`, `CONTRIBUTING.md` and the
  like).
- **Spec**: the originating issue or spec, from the findings, the commit messages or the branch name.
- **Checks**: the commands CI runs (tests, typecheck, lint, format), from the package scripts, task runner or CI
  config.
- **Commit conventions** and the **issue tracker**, with its triage label for new, unreviewed issues.

Done when each item is named, or noted as absent.

## 1. Verify

Treat every finding as a hypothesis. Open what it cites and check it against the current code, the standards or the
spec. Check any claim that arrives without a quote (a cause, a date, a commit's history) against its source:
`git log`, `git blame`, the tracker.

Done when every finding is marked **confirmed**, **corrected** (with the corrected claim) or **dropped** (with why).

## 2. Disposition

Give each confirmed or corrected finding one disposition:

- **Fix now**: a breach of a documented standard, a bug the diff introduced, or a spec requirement that is missing,
  partial or implemented wrongly within this ticket.
- **User's call**: a smell or other judgement call, or scope creep. Recommend apply, keep or drop, with a reason.
- **Follow-up**: valid, but outside this ticket's spec.
- **Drop**: the repo's standards endorse it, or tooling already enforces it.

Show the user a table of finding, verdict and disposition, then wait. Done when the user has approved every
disposition.

## 3. Fix

Work the **Fix now** findings, plus the **User's call** findings the user chose to apply, one at a time:

- **Behaviour or spec defect**: write a regression test that goes red against the reviewed code, then fix it to
  green. Call the Skill tool with "tdd" when that skill is available.
- **Simplifying a branch or guard**: first name the input the old branch handled and show it in a test. The reviewer
  saw only the diff; that input lives outside it.
- **Standards or refactoring fix**: apply it.

Done when every finding to fix has a change, and every behaviour fix has a test that was seen red.

## 4. Checks

Run the focused test for each fix as you go, then the full set of checks from step 0 once. Done when all are green.

## 5. Commit

Commit to the current branch, following the repo's commit conventions.

## 6. Record leftovers

Give every remaining finding a home:

- **Follow-up**: an issue per finding on the repo's tracker, with its triage label, a reference to the originating
  issue, and the finding's citation in the body. With no tracker, list them in the report.
- **Dropped judgement calls and kept scope creep**: one line each with the reason, in the PR body if a PR exists,
  otherwise in the report.

Done when no confirmed finding is left without a fix, an issue or a recorded reason.

## 7. Report and stop

Report a table of finding → outcome (fixed in `<sha>`, `#<issue>`, kept, dropped), plus the check results.

When a class of finding has come up before, propose the standards rule or lint rule that would catch it next time,
for the user to decide.

The run ends here. A fresh review belongs to the user to start, ideally from a new session, since each review of new
code finds new judgement calls.
