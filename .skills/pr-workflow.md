# pr-workflow.md
# SKILL: pr-workflow
# ================================================================
# HOW TO INVOKE THIS SKILL:
# Type in Copilot Chat:
#   "run pr-workflow"
#       → guides you through the full PR workflow end to end
#   "run pr-workflow: create-branch"
#       → creates a new branch for current work item
#   "run pr-workflow: raise-pr"
#       → raises a PR in ADO for the current branch
#   "run pr-workflow: check-pr"
#       → checks status of open PRs in ADO
#   "run pr-workflow: merge-confirm"
#       → confirms PR is approved and safe to merge
#
# WHAT THIS SKILL DOES:
# Guides the complete git + ADO PR workflow from branch creation
# to merge confirmation. Replaces the manual PR process currently
# done by the team.
#
# THE WORKFLOW HAS FIVE STAGES:
#   Stage 1 — Create branch from ADO work item
#   Stage 2 — Work and commit
#   Stage 3 — Push branch to remote
#   Stage 4 — Raise PR in ADO
#   Stage 5 — Review, approve, and merge
#
# RULES THAT NEVER CHANGE:
# - Copilot NEVER runs git commands automatically
# - Copilot NEVER raises a PR without Sunil's explicit approval
# - Copilot NEVER merges without client sign-off confirmed
# - Every git command is shown to Sunil first
# - Sunil runs the commands. Copilot shows what to run.
# ================================================================

---

## STAGE 1 — CREATE BRANCH

When "run pr-workflow: create-branch" is invoked:

Copilot asks:
"What are you working on?
 A. New feature / migration (feature branch^)
 B. Bug fix / locator fix (fix branch^)
 C. Maintenance / refactor (maintenance branch^)
 D. Regression run related change (regression branch^)"

Wait for answer. Then ask:
"What is the ADO Work Item ID or Test Case ID this branch
 relates to? Example: 12345"

Wait for answer. Then present the branch name to create:

BRANCH NAMING CONVENTION:
  Feature:     feature/TC-{id}-{short-description}
  Fix:         fix/TC-{id}-{short-description}
  Maintenance: maintenance/TC-{id}-{short-description}
  Regression:  regression/{date}-{suite-name}

Examples:
  feature/TC-12345-patient-appointment-migration
  fix/TC-12890-login-locator-xpath-update
  maintenance/TC-13000-appointment-page-refactor
  regression/20240315-smoke-suite

Copilot presents:
"Here is the branch to create:

 Branch name: {branch name}
 Base branch: main (or confirm with Sunil^)

 Git command to run:
   git checkout main
   git pull origin main
   git checkout -b {branch name}

 Run these commands in your terminal.
 Confirm when done and I will continue."

Wait for Sunil to confirm branch is created.

---

## STAGE 2 — WORK AND COMMIT

During the work session, when Sunil is ready to commit:

Copilot presents the commit message following this format:

COMMIT MESSAGE FORMAT:
  First line:   {type}: {short description} [TC-{id}]
  Blank line
  Body:         {what was changed and why — bullet points}

Types:
  feat      → new feature or migration
  fix       → bug fix or locator fix
  maint     → maintenance or refactor
  test      → test script changes
  docs      → documentation changes
  config    → configuration changes

Examples:
  feat: migrate patient appointment feature to new framework [TC-12345]

  - Migrated PatientAppointments.feature from old framework
  - Added 3 new step definitions to AppointmentSteps.java
  - Reused existing loginPage.clickLogin() from LoginPage.java
  - Updated reconciliation Excel: TC-12345 status = MIGRATED

  fix: update login button XPath after UI change [TC-12890]

  - Old XPath: //button[@id='old-login-btn']
  - New XPath: //button[@data-testid='login-submit']
  - Verified on Chrome locally and passing
  - Locator change log updated

Copilot presents:
"Here is the commit command:

 git add {list of files changed}
 git commit -m '{first line of message}' -m '{body}'

 Before committing:
 Running pr-scan silently...
 {pr-scan result}

 If pr-scan passed: run the commands above.
 If pr-scan failed: resolve issues first. Do not commit."

---

## STAGE 3 — PUSH BRANCH

When Sunil is ready to push:

Copilot presents:
"Push command:

 git push origin {branch name}

 This pushes to the remote branch only.
 It does NOT merge to main.
 It does NOT raise a PR automatically.

 Run this command. Confirm when done."

Wait for confirmation.

---

## STAGE 4 — RAISE PR IN ADO

When "run pr-workflow: raise-pr" is invoked:

Copilot first checks:
- Is pr-scan complete and passed? If not, run it first.
- Is the branch pushed to remote? Ask Sunil to confirm.

Then Copilot calls ADO API to create the PR:

ADO PR Creation Endpoint:
POST https://dev.azure.com/{org}/{project}/_apis/git/repositories/
     {repositoryId}/pullrequests?api-version=7.0

Request body:
{
  "title": "{commit type}: {description} [TC-{id}]",
  "description": "{full description of changes}",
  "sourceRefName": "refs/heads/{branch name}",
  "targetRefName": "refs/heads/main",
  "reviewers": [
    {"id": "{reviewer ADO user ID}"}
  ],
  "isDraft": false
}

Before making the API call, Copilot presents:
"I am about to raise a PR in ADO with these details:

 Title:       {title}
 Description: {description}
 From branch: {branch name}
 To branch:   main
 Reviewers:   {list of reviewers}

 Repository ID: [FILL IN — confirm with Sunil]
 Reviewer IDs:  [FILL IN — confirm with Sunil]

 Shall I raise this PR? (yes / no)"

Wait for explicit yes before making the API call.

After PR is raised, Copilot presents:
"PR raised successfully.
 PR ID:  {id from response}
 PR URL: {url from response}

 Next steps:
 1. Share the PR URL with your reviewers
 2. Wait for reviewer approval
 3. Once approved: run 'run pr-workflow: merge-confirm'
    before merging to main"

---

## STAGE 5 — REVIEW AND MERGE CONFIRMATION

When "run pr-workflow: check-pr" is invoked:

Copilot calls ADO API to check PR status:
GET https://dev.azure.com/{org}/{project}/_apis/git/repositories/
    {repositoryId}/pullrequests/{pullRequestId}?api-version=7.0

Copilot presents:
"PR Status:
 PR ID:        {id}
 Title:        {title}
 Status:       {active / completed / abandoned}
 Reviewers:
   {reviewer name}: {approved / waiting / rejected}
 Merge status: {can be merged / conflicts / policies not met}"

When "run pr-workflow: merge-confirm" is invoked:

Copilot checks:
  1. All reviewers have approved
  2. No merge conflicts
  3. All ADO branch policies met
  4. pr-scan passed on all changed files
  5. Client approval confirmed by Sunil

Copilot presents:
"PR Merge Checklist:
 ================================================
 All reviewers approved:     {YES / NO}
 No merge conflicts:         {YES / NO}
 Branch policies met:        {YES / NO}
 pr-scan passed:             {YES / NO}
 Client approval confirmed:  {confirm with Sunil}
 ================================================

 REMINDER: Client approves all changes before merge to main.
 Have you received client approval for these changes?

 If ALL above are YES and client has approved:
 You can merge via ADO dashboard or run:
   git checkout main
   git pull origin main
   git merge {branch name}
   git push origin main

 Copilot will NOT run these commands automatically.
 You run them after confirming all checks above."

---

## CONFIG.PROPERTIES KEYS NEEDED

Add these if not already present:
  ado.repositoryId=[FILL IN — Git repo ID from ADO]
  ado.reviewerIds=[FILL IN — comma separated ADO user IDs]
  ado.defaultBranch=main

To find your repository ID:
GET https://dev.azure.com/{org}/{project}/_apis/git/repositories
    ?api-version=7.0
Look for the "id" field of your repository in the response.

To find reviewer ADO user IDs:
GET https://dev.azure.com/{org}/_apis/graph/users?api-version=7.1-preview.1
Or look up via: GET https://dev.azure.com/{org}/_apis/identities
Ask Sunil to provide reviewer email addresses and Copilot will
look up their IDs via ADO API before raising the PR.

---

## IMPORTANT RULES FOR THIS SKILL

1. Copilot NEVER runs git commands automatically.
   It shows the exact commands. Sunil runs them.

2. pr-scan MUST pass before any commit or PR is raised.
   No exceptions. Healthcare project.

3. Client approval is required before merging to main.
   Copilot always reminds Sunil of this at the merge step.

4. PR description must include the ADO Test Case ID.
   This links the PR to the work item in ADO automatically.

5. Never push directly to main. Always via branch and PR.
   If Sunil asks to push directly to main: remind him of
   the branch and PR policy and wait for his decision.

6. Reviewer IDs must be confirmed before the first PR.
   Add them to config.properties once and reuse every time.
