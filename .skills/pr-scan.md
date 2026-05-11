# pr-scan.md
# SKILL: pr-scan
# ================================================================
# HOW TO INVOKE THIS SKILL:
# Type in Copilot Chat:
#   "run pr-scan"              — scans all files touched this session
#   "run pr-scan: {file path}" — scans a specific file
#   "run pr-scan: phase {N}"   — scans all output from a phase
#
# WHAT THIS SKILL DOES:
# Performs a privacy and security review on every file before
# it is committed to the repository or shared with the client.
# This is a non-negotiable step on this project because:
#   1. This is a HEALTHCARE application
#   2. Real patient data (names, records, appointments, results)
#      exists in the application being tested
#   3. Any accidental exposure of patient data is a compliance
#      violation with serious legal and contractual consequences
#   4. The client (MC) must approve all changes — a privacy
#      violation could end the engagement immediately
#
# This skill runs automatically as part of validation.md (Rule U5).
# It can also be run manually at any time for extra assurance.
#
# WHEN TO RUN MANUALLY:
# — Before every git commit
# — Before sharing any file with the client or team
# — After any test run that touched real application data
# — Whenever Sunil is unsure if a file is safe to share
# ================================================================

---

## WHAT pr-scan CHECKS

pr-scan has FIVE check categories:
  Category 1 — Patient Data Check
  Category 2 — Authentication and Credentials Check
  Category 3 — Configuration and Environment Check
  Category 4 — Code and Logic Check
  Category 5 — Repository Safety Check

Every file is checked against all five categories.
A file passes pr-scan only when ALL five categories pass.
A single failure in any category means the file cannot be
committed or shared until the issue is resolved.

---

## CATEGORY 1 — PATIENT DATA CHECK

### What Copilot scans for:

PD-1: Patient names
  Scan for: full names, first names, last names that appear
  to be real person names in test data, comments, or log output.
  Flag any name that is not a clearly generic placeholder.
  Safe examples:    "Test Patient 001", "John Doe Test", "Patient A"
  Unsafe examples:  "Sarah Johnson", "Michael Brown", "Mary Williams"

PD-2: Patient identification numbers
  Scan for: patient IDs, medical record numbers (MRN), member IDs,
  account numbers, insurance IDs, social security numbers,
  date of birth combinations that could identify a person.
  Safe examples:    "MRN_TEST_001", "PATIENT_ID_PLACEHOLDER"
  Unsafe examples:  Any real-looking numeric ID that was copied
                    from a real session or real test run.

PD-3: Health records and medical information
  Scan for: diagnosis names, medication names, lab result values,
  appointment details with real dates and real doctor names,
  any clinical data that could be tied to a real patient.

PD-4: Contact information
  Scan for: real email addresses, phone numbers, physical addresses,
  zip codes paired with names.
  Safe: "test@testdomain.com", "555-0100", "123 Test Street"
  Unsafe: Any address or contact that looks real and was not
          explicitly created as test data by the team.

PD-5: Screenshots and attachments
  If the output references screenshot file paths, flag them.
  Screenshots taken during test runs may contain patient data
  visible on the screen.
  Copilot cannot view image files directly, so it must:
  — Flag every screenshot path found in the output
  — Remind Sunil to manually review each screenshot before
    committing or sharing

### What happens if patient data is found:

SEVERITY: CRITICAL
ACTION:
  1. Stop all work immediately
  2. Report exactly where the data was found
     (file name, line number, exact content)
  3. Do NOT suggest how to fix it — Sunil decides
  4. Do NOT commit, push, or share anything until resolved
  5. Log the incident in .project/devlog.md with entry type RISK
  6. Wait for Sunil's explicit instruction before continuing

---

## CATEGORY 2 — AUTHENTICATION AND CREDENTIALS CHECK

### What Copilot scans for:

AC-1: PAT tokens
  Scan for: strings that match ADO PAT token format
  (typically 52-character alphanumeric strings).
  Also scan for any variable named "pat", "token", "accessToken",
  "personalAccessToken" that has a non-placeholder value.
  Safe:   ado.pat=[FILL IN]
  Unsafe: ado.pat=abc123xyz...{52 chars}

AC-2: Passwords and secrets
  Scan for: any variable named "password", "secret", "key",
  "apiKey", "secretKey", "clientSecret" with a non-placeholder value.

AC-3: Perfecto credentials
  Scan for: Perfecto security token values, Perfecto host values
  with actual credentials embedded.

AC-4: Base64 encoded credentials
  Scan for: strings that look like Base64 encoded values
  in non-utility code. Encoded credentials are still credentials.

AC-5: Hardcoded authentication headers
  Scan for: Authorization header values that contain actual
  tokens rather than reading from config.properties.

### What happens if credentials are found:

SEVERITY: CRITICAL
ACTION:
  1. Stop all work immediately
  2. Report exactly where the credential was found
  3. Replace with [FILL IN] placeholder immediately
  4. If the credential was already committed to the repository,
     alert Sunil — the PAT must be revoked and regenerated
  5. Log the incident in .project/devlog.md

---

## CATEGORY 3 — CONFIGURATION AND ENVIRONMENT CHECK

### What Copilot scans for:

CE-1: config.properties committed to repository
  Scan for: config.properties in any git staging or commit
  that contains real values instead of [FILL IN] placeholders.
  The file config.properties must NEVER be committed.
  The file config.properties.template MAY be committed
  if all values are [FILL IN] placeholders.

CE-2: Environment-specific URLs hardcoded
  Scan for: hardcoded URLs that point to real environments
  (QA, staging, production, Perfecto host).
  All environment URLs must come from config.properties.

CE-3: Test environment data mixed with production data
  Scan for: any reference to production environment names,
  production URLs, or production system identifiers in
  any test file, config file, or log output.

CE-4: .gitignore coverage
  Verify that .gitignore includes at minimum:
    config.properties
    /output/ (or whatever the output folder is)
    *.log
    target/
  If .gitignore is missing any of these, flag it.

### What happens if configuration issues are found:

SEVERITY: HIGH
ACTION:
  1. Flag the specific issue with file and line
  2. Propose the fix (move to config, add to .gitignore)
  3. Wait for Sunil's approval before making any change
  4. Do not commit until resolved

---

## CATEGORY 4 — CODE AND LOGIC CHECK

### What Copilot scans for:

CL-1: Logging of sensitive data
  Scan for: log statements that output patient data, credentials,
  or personally identifiable information.
  Check all logger.info(), logger.debug(), logger.error(),
  System.out.println() calls.
  Logs must only contain: timestamps, class names, method names,
  error messages, HTTP status codes, test case IDs, file paths.

CL-2: Stack traces exposing sensitive paths
  Scan for: printStackTrace() calls that might expose
  internal file system paths, server names, or credential paths
  in production log output.
  Use logger with message instead of raw printStackTrace.

CL-3: Commented-out real data
  Scan for: commented-out code that contains real credentials,
  real patient data, or real environment values.
  Comments are committed to the repository too.

CL-4: Debug code left in
  Scan for: debug flags set to true, test-only code paths
  that bypass authentication or data validation,
  any code comment saying "remove before commit" or "temp".

CL-5: Console output of test data
  Scan for: print statements that output test scenario data
  that might include patient information captured during
  a real test run.

### What happens if code issues are found:

SEVERITY: HIGH for CL-1, CL-2, CL-3 / MEDIUM for CL-4, CL-5
ACTION:
  Flag with file, line, and severity.
  Propose fix. Wait for approval. Never auto-fix.

---

## CATEGORY 5 — REPOSITORY SAFETY CHECK

### What Copilot scans for:

RS-1: Files that should never be committed
  Flag if any of these are in the commit scope:
    config.properties (with real values)
    Any file in the /output/ folder
    Any .log file
    Any screenshot file (.png, .jpg, .jpeg)
    Any file larger than 10MB
    Any binary file that is not intentionally tracked

RS-2: Commit message safety
  If Sunil provides a commit message, scan it for:
  — Patient data accidentally included in the message
  — Credentials or PAT tokens in the message
  — Internal system names that should not be public

RS-3: Branch safety
  If pushing to a shared or main branch, remind Sunil:
  "You are about to push to {branch name}.
   This branch is shared with the team / client.
   Client approval is required before pushing to this branch.
   Have you received client approval for these changes?"

RS-4: New files review
  List every new file being committed that did not exist before.
  Sunil must explicitly confirm each new file is intentional.

### What happens if repository safety issues are found:

SEVERITY: HIGH
ACTION:
  Stop the push. Flag every issue.
  Wait for Sunil's explicit confirmation before proceeding.

---

## PR-SCAN RESULT FORMAT

### If ALL categories pass:
"pr-scan PASSED
================================================
Category 1 - Patient Data:         PASS
Category 2 - Credentials:          PASS
Category 3 - Configuration:        PASS
Category 4 - Code and Logic:       PASS
Category 5 - Repository Safety:    PASS
================================================
{N} files scanned. No privacy or security issues found.
Safe to commit and share."

### If ANY category fails:
"pr-scan FAILED — DO NOT COMMIT OR SHARE
================================================
Category 1 - Patient Data:         {PASS/FAIL}
Category 2 - Credentials:          {PASS/FAIL}
Category 3 - Configuration:        {PASS/FAIL}
Category 4 - Code and Logic:       {PASS/FAIL}
Category 5 - Repository Safety:    {PASS/FAIL}
================================================

ISSUES FOUND:

[{SEVERITY}] {category code} — {rule name}
File:    {file path}
Line:    {line number}
Found:   {exactly what was found — redacted if credential}
Risk:    {what could happen if this is committed or shared}
Action:  {what needs to be done — Sunil decides, not Copilot}

DO NOT COMMIT. DO NOT SHARE.
Resolve all issues above and run pr-scan again."

---

## IMPORTANT RULES FOR THIS SKILL

1. pr-scan is NEVER optional on this project.
   Healthcare data exposure is a compliance violation.
   There are no exceptions for "quick commits" or "small changes."

2. When a CRITICAL issue is found, Copilot stops everything.
   Not just the current task. Everything.
   No other work proceeds until the critical issue is resolved.

3. Copilot NEVER auto-fixes privacy issues.
   Sunil decides how every privacy issue is resolved.
   Copilot only identifies and reports.

4. Screenshots must always be flagged for manual review.
   Copilot cannot read image files. Sunil must check every
   screenshot manually before it leaves the workspace.

5. If in doubt, flag it.
   A false positive (flagging something safe) costs 2 minutes.
   A false negative (missing a real issue) could cost the project.

6. This skill protects the patient, the client, the team,
   and Sunil personally. Run it every time without exception.
