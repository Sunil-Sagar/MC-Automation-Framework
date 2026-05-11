# git-ado-workflow.instructions.md
# Attach this file in Copilot Chat when doing any git work,
# raising PRs, doing branch management, or any ADO repository
# related activity.
#
# This file defines the exact git and ADO workflow for the
# MC project. Every team member follows this same workflow.
# No deviations without QA Lead approval.
#
# ATTACH ALONGSIDE:
#   - .skills/pr-workflow.md
#   - .skills/pr-scan.md
#   - ado-api-reference.instructions.md
#
# INSTRUCTIONS FOR SUNIL:
# Fill in the [FILL IN] placeholders before using this file.
# Especially: repository ID, reviewer IDs, branch policy details.
# ================================================================

---

## REPOSITORY DETAILS

ADO Organization:    https://dev.azure.com/MCLM
ADO Project:         [FILL IN]
Repository name:     [FILL IN]
Repository ID:       [FILL IN — numeric ID from ADO Git settings]
Default branch:      main
Remote URL:          [FILL IN — https://MCLM@dev.azure.com/MCLM/{project}/_git/{repo}]

---

## BRANCH STRATEGY

This project uses a simple feature branch strategy.
No one commits directly to main. Ever.
All changes go through a branch and a PR.

```
main (protected — no direct push)
  ├── feature/TC-{id}-{description}    migration work
  ├── fix/TC-{id}-{description}        locator fixes, bug fixes
  ├── maintenance/TC-{id}-{description} refactoring, cleanup
  └── regression/{date}-{suite}        regression run related
```

### Branch Naming Rules
Format:     {type}/{prefix}-{id}-{short-kebab-description}
Prefix:     TC for Test Case, FR for Feature Request
Max length: 60 characters
Lowercase:  always — no uppercase in branch names
Hyphens:    use hyphens not underscores

Good:   fix/TC-12345-login-button-xpath-update
Good:   feature/TC-12890-patient-appointment-migration
Bad:    Fix_LoginButton           (uppercase, underscores)
Bad:    sunil-working-branch      (no ticket reference)
Bad:    main-copy                 (never)

### Who Creates Branches
Any team member can create a branch.
Only Sunil or QA Lead merges to main.
Client approval required before any merge to main.

---

## COMMIT MESSAGE STANDARD

Every commit must follow this format exactly.

```
{type}: {short description in present tense} [TC-{id}]

- {bullet: what was changed}
- {bullet: why it was changed}
- {bullet: what else was affected}
```

Types:
  feat     → new feature, new migration, new test
  fix      → bug fix, locator fix, broken step fix
  maint    → refactor, cleanup, no behaviour change
  test     → test script changes
  docs     → documentation, comments, KT files
  config   → config file changes

Rules:
  First line max 72 characters
  Always reference the TC ID in square brackets
  Use present tense: "update locator" not "updated locator"
  No period at end of first line
  Body lines start with a hyphen

Examples:

feat: migrate patient appointment feature to new framework [TC-12345]

- Migrated PatientAppointments.feature with 5 scenarios
- Added 2 new step definitions to AppointmentSteps.java
- Reused loginPage.clickSubmit() from existing LoginPage.java
- Reconciliation Excel updated: TC-12345 status MIGRATED

fix: update schedule button XPath after sprint 14 UI change [TC-12890]

- Old: //button[@id='schedule-btn']
- New: //button[@data-testid='schedule-appointment-btn']
- Auto-healed by Phase 3 web healer, approved by Sunil
- Locator change log and module change log updated

---

## PR TEMPLATE

Every PR raised in ADO must use this description template.
Copilot fills this in automatically when using pr-workflow skill.

```
## Summary
{2-3 sentences describing what this PR does}

## Changes Made
- [ ] Feature file(s) updated
- [ ] Steps.java updated
- [ ] Pages.java / locators updated
- [ ] config.properties updated
- [ ] Reconciliation Excel updated
- [ ] Locator change log updated
- [ ] Module change log updated

## Test Cases Covered
| ADO Tag | Scenario Title | Status After Change |
|---------|----------------|---------------------|
| @{tag}  | {title}        | PASS (verified locally) |

## Type of Change
- [ ] Migration (Quantum → BDD Cucumber)
- [ ] Locator fix (UI change)
- [ ] New test case
- [ ] Maintenance / refactor
- [ ] Bug fix

## Checklist
- [ ] pr-scan passed — no patient data or credentials
- [ ] Tests pass locally with @local tag
- [ ] Reconciliation Excel updated if migration
- [ ] No duplicate step definitions introduced
- [ ] Client approval received (for merge to main)

## Reviewer Notes
{anything specific reviewers should look at or test}
```

---

## REVIEWER ASSIGNMENT RULES

Every PR must have at least one reviewer.
Default reviewers for this project:

Primary reviewer:   [FILL IN — ADO user ID of QA Lead]
Secondary reviewer: [FILL IN — ADO user ID of second QA engineer]

For locator-only changes (no feature file changes):
  One reviewer is sufficient.

For migration changes (feature file + steps + pages):
  Both reviewers required.

For config changes:
  Sunil reviews before raising PR.
  QA Lead as mandatory reviewer.

Reviewer ADO User IDs:
  QA Lead:    [FILL IN]
  Reviewer 2: [FILL IN]
  (Find via ADO → Project Settings → Teams → member details)

---

## BRANCH POLICIES (ADO settings)

These policies are set in ADO repository settings.
If they are not set, ask Sunil to configure them.

Minimum reviewers:       1 (minimum) for all PRs
Check for comment resolution: YES — all comments resolved before merge
Build validation:        [FILL IN — if CI pipeline exists]
Linked work items:       OPTIONAL — link TC ID if possible

---

## FULL WORKFLOW — STEP BY STEP

This is the complete workflow from starting work to merging.
Follow every step. Do not skip any.

### STARTING WORK
```
Step 1: Check out latest main
  git checkout main
  git pull origin main

Step 2: Create your branch (use pr-workflow: create-branch)
  git checkout -b {branch name}

Step 3: Confirm you are on the right branch
  git branch --show-current
```

### DURING WORK
```
Step 4: Make your changes
  (work on feature files, steps, pages as needed)

Step 5: Stage changed files
  git status               (see what changed)
  git add {specific files} (never git add . blindly)
  git status               (confirm staged files look right)

Step 6: Run pr-scan before committing
  "run pr-scan" in Copilot Chat
  Only commit after pr-scan passes.

Step 7: Commit with correct message format
  git commit -m "feat: {description} [TC-{id}]" -m "- {detail}"

Step 8: Repeat steps 4-7 for each logical unit of work
  One commit per logical change, not one giant commit.
```

### PUSHING AND RAISING PR
```
Step 9: Push branch to remote
  git push origin {branch name}

Step 10: Raise PR in ADO
  "run pr-workflow: raise-pr" in Copilot Chat
  Or manually via ADO → Repos → Pull Requests → New

Step 11: Update Locator Change Log if locators changed
  "run locator-log" (automatic after Phase 3/4)
  "run locator-log: manual" (for manual locator changes)

Step 12: Update Module Change Log
  "run module-log: update {module name}"

Step 13: Notify reviewers
  Share PR URL in team channel or email
```

### REVIEW AND MERGE
```
Step 14: Respond to reviewer comments
  Make changes requested by reviewers on the same branch
  Push additional commits to the same branch
  Resolve all comments

Step 15: Check PR is ready
  "run pr-workflow: check-pr"

Step 16: Get client approval
  Client must approve changes before merge to main
  Document approval: "run project-log: decision — client approved PR {id}"

Step 17: Merge (only after all above are done)
  Merge via ADO dashboard (preferred)
  Or git merge if ADO merge is not available

Step 18: Clean up branch after merge
  git branch -d {branch name}          (delete local)
  git push origin --delete {branch name} (delete remote)

Step 19: Update Reconciliation Excel if migration PR
  Confirm Migration Status = MIGRATED for all tags in this PR
```

---

## HOTFIX PROCESS

For urgent locator fixes that cannot wait for full PR review:

1. Create a fix branch: fix/TC-{id}-hotfix-{description}
2. Make the minimal change only — nothing else
3. Run pr-scan — must pass even for hotfixes
4. Raise PR with "HOTFIX" in the title
5. Get at least one reviewer to approve quickly
6. Notify QA Lead immediately
7. Merge after one approval minimum
8. Document in project-log: "run project-log: note — hotfix deployed {description}"

---

## WHAT COPILOT WILL AND WILL NOT DO

WILL DO:
  - Show exact git commands to run
  - Build the PR description from template
  - Call ADO API to raise the PR
  - Check PR status via ADO API
  - Run pr-scan before every commit suggestion
  - Update locator and module change logs automatically

WILL NOT DO:
  - Run git commands automatically
  - Push to main directly
  - Merge without client approval confirmed
  - Skip pr-scan for any reason
  - Create a PR without Sunil reviewing the description

---

## COMMON MISTAKES TO AVOID

1. Never git add . (dot) blindly
   Always git add specific files
   Always run git status before and after staging

2. Never push directly to main
   Even for tiny one-line changes
   Branch + PR always

3. Never commit without running pr-scan
   It takes 30 seconds
   One missed patient data leak is not worth saving 30 seconds

4. Never merge without client approval
   This is a contractual requirement on this project
   Not optional even for "safe" changes

5. Never delete a branch before confirming the merge succeeded
   Check ADO PR status shows "Completed" before deleting

6. Never use generic commit messages
   Bad:  "fixes" / "changes" / "update"
   Good: "fix: update appointment button XPath [TC-12890]"
