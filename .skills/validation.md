# validation.md
# SKILL: validation
# ================================================================
# HOW TO INVOKE THIS SKILL:
# This skill is NOT called manually by Sunil in most cases.
# It runs automatically before Copilot marks ANY task as done.
# Copilot must run this checklist silently before saying
# "Task complete" on any output it produces.
#
# Sunil can also invoke it manually:
#   "run validation" — validates the last output produced
#   "run validation: {file path}" — validates a specific file
#   "run validation: phase {N}" — validates all output from a phase
#
# WHAT THIS SKILL DOES:
# Acts as a quality gate. Before any output is marked complete,
# Copilot checks it against every rule in this file.
# If any rule fails, Copilot does NOT mark the task complete.
# It reports exactly which rule failed, why, and what needs
# to be fixed before proceeding.
#
# This skill has FOUR validation layers:
#   Layer 1 — Universal rules (apply to every single output)
#   Layer 2 — Java code rules (apply to all Java files)
#   Layer 3 — Feature file rules (apply to all .feature files)
#   Layer 4 — Phase-specific rules (apply per phase)
# ================================================================

---

## LAYER 1 — UNIVERSAL RULES
# These apply to EVERY output Copilot produces.
# No exceptions. No phase is exempt from these rules.

### U1 — No assumptions made
RULE: Every value, path, class name, method name, and configuration
      used in the output must have been READ from an actual file
      in the project, or explicitly provided by Sunil.
CHECK: Can Copilot point to the exact file and line where each
       value came from? If not, the output fails this rule.
FAIL ACTION: List every assumed value. Ask Sunil to confirm each one
             before the output is accepted.

### U2 — No files modified without approval
RULE: Every file that was created or modified this task must have
      been explicitly approved by Sunil before the change was made.
CHECK: Was each file change presented to Sunil and approved?
FAIL ACTION: List every file that was changed. Confirm with Sunil
             that each change was approved. If any was not,
             revert it and present it for approval.

### U3 — No new dependencies added without approval
RULE: No new entry was added to pom.xml without Sunil explicitly
      approving the addition after being shown it was missing.
CHECK: Was pom.xml checked before the dependency was added?
       Was the addition approved by Sunil?
FAIL ACTION: Remove the unapproved dependency. Present it to Sunil
             and wait for approval before re-adding.

### U4 — No placeholder code
RULE: The output contains zero instances of:
      "// TODO", "// add your logic here", "// implement this",
      "// placeholder", or any other incomplete code marker.
CHECK: Search the output for these strings. If any found, fail.
FAIL ACTION: Complete every placeholder before marking done.
             Never deliver incomplete code.

### U5 — No patient data or sensitive information
RULE: The output contains no patient names, patient IDs, health
      records, test results, personal information, or any data
      that could identify a real person.
      PAT tokens, passwords, and credentials must not appear
      in any file other than config.properties, and even there
      the actual value should be a placeholder like [FILL IN].
CHECK: Scan all output for personal data patterns and credentials.
FAIL ACTION: Remove immediately. Alert Sunil. This is a
             healthcare project — data exposure is a critical failure.

### U6 — No auto-commits or auto-pushes
RULE: No git command was executed automatically.
      No file was pushed to any repository without Sunil's
      explicit instruction and approval.
CHECK: Were any git commands run? If yes, was each one
       explicitly requested and approved by Sunil?
FAIL ACTION: This is a critical failure. Alert Sunil immediately
             with exactly what was pushed and to which branch.

### U7 — One task at a time
RULE: Only one task was completed in this output.
      Copilot did not bundle multiple tasks together without
      Sunil approving the bundle first.
CHECK: Does the output cover exactly one approved task?
FAIL ACTION: Split the output. Present each task separately.

### U8 — Plain English explanation provided
RULE: Every piece of code produced is accompanied by a plain
      English explanation of what each section does.
CHECK: Is there an explanation? Does it cover every section?
       Is it written clearly enough for a mid-level QA engineer?
FAIL ACTION: Add the explanation before marking done.

---

## LAYER 2 — JAVA CODE RULES
# These apply to every Java file produced or modified.

### J1 — Three-layer architecture respected
RULE: No Selenium logic or locators exist in Steps.java files.
      No business logic exists in .feature files.
      All locators exist only in Pages.java files.
      All Selenium actions exist only in Pages.java files.
CHECK: Read every Java file in the output.
       Does each file contain only what its layer allows?
FAIL ACTION: Move misplaced code to the correct layer.
             Present the corrected version to Sunil.

### J2 — No duplicate step definitions
RULE: No new @Given/@When/@Then annotation was created that
      exactly matches an annotation already existing in any
      other Steps.java file in the project.
CHECK: Search ALL Steps.java files for matching annotation text.
       If a match exists anywhere, the new definition must not exist.
FAIL ACTION: Remove the duplicate. Confirm the existing definition
             is being used correctly instead.

### J3 — No hardcoded values
RULE: No URL, credential, environment name, file path, ADO ID,
      PAT token, or configuration value is hardcoded in any
      Java file. All such values must come from config.properties.
CHECK: Search output Java files for string literals that should
       be configuration values.
FAIL ACTION: Move hardcoded values to config.properties.
             Read them via config.getProperty() in the Java file.

### J4 — Error handling present
RULE: Every method that makes an external call (ADO API, file read,
      file write, DOM access, Perfecto API) must have a try-catch
      block that handles failure gracefully.
      Failures must be logged with enough detail to diagnose.
      The program must never silently crash.
CHECK: Does every external call have a try-catch?
       Does the catch block log the error with context?
FAIL ACTION: Add error handling to every uncovered call.

### J5 — Config reading follows standard pattern
RULE: config.properties is always loaded using the same pattern
      already established in the project. Copilot does not
      invent a new way to read config in each class.
CHECK: Does the config reading pattern match what already exists
       in the project? Read existing classes to verify.
FAIL ACTION: Replace with the established pattern.

### J6 — Naming conventions followed
RULE: All class names, method names, variable names, and
      locator variable names follow the conventions defined
      in framework-architecture.instructions.md
CHECK: Compare every name in the output against the conventions.
FAIL ACTION: Rename to match conventions. Present to Sunil.

### J7 — No System.out.println in production code
RULE: Use proper logging. No System.out.println statements
      in any Java file that will be committed to the repository.
      Use the logging approach already established in the project.
CHECK: Search output for System.out.println.
FAIL ACTION: Replace with the established logging approach.

### J8 — Apache POI version consistency
RULE: Apache POI usage must match the version already in pom.xml.
      Do not use API methods from a different version.
CHECK: What version is in pom.xml? Does the code use only
       methods available in that version?
FAIL ACTION: Update code to match the version in pom.xml.

---

## LAYER 3 — FEATURE FILE RULES
# These apply to every .feature file produced or modified.

### F1 — Tags are never changed
RULE: @tags in feature files are ADO Test Case IDs.
      They must never be changed, removed, reordered, or renamed.
      The tag in the feature file must exactly match the
      Test Case ID in ADO.
CHECK: Compare every @tag in the output against the original
       source (old framework or ADO). Are they identical?
FAIL ACTION: This is a critical failure. Restore the original tags.
             Alert Sunil immediately.

### F2 — Gherkin language is correct
RULE: Every step starts with Given, When, Then, And, or But.
      No steps start with other words.
      Scenario keyword is either Scenario or Scenario Outline.
      Examples table is present for every Scenario Outline.
CHECK: Read every step in the output feature file.
FAIL ACTION: Correct the Gherkin syntax before marking done.

### F3 — Step text matches existing step definitions
RULE: Every Gherkin step written in a feature file must have
      a matching @Given/@When/@Then annotation somewhere in
      the project's Steps.java files, OR a new step definition
      has been proposed and approved by Sunil.
      No orphan steps allowed — they cause Undefined Step errors.
CHECK: For every step in the output, find its matching annotation.
FAIL ACTION: List every step with no matching definition.
             Propose new step definitions for each. Wait for approval.

### F4 — Feature file naming convention followed
RULE: Feature file names follow the naming convention defined
      in framework-architecture.instructions.md
CHECK: Does the file name match the convention?
FAIL ACTION: Rename to match the convention.

### F5 — No duplicate scenarios
RULE: No scenario in the output has the exact same @tag as
      any other scenario in any other feature file in the project.
      Each ADO Test Case ID maps to exactly one scenario
      (or in structural split cases, the correct number of
      scenarios as approved by Sunil).
CHECK: Search all feature files for matching @tags.
FAIL ACTION: Alert Sunil. Duplicate tags cause duplicate ADO
             test case mapping and corrupt the reporting system.

---

## LAYER 4 — PHASE-SPECIFIC RULES

### PHASE 0 — Reconciliation Engine
P0-1: Excel output contains all required columns in correct order:
      ADO Tag | ADO Title | Old Framework Title | New Framework Title |
      Name Match Status | Migration Status | Split Case Flag | Action Needed
P0-2: Color coding applied correctly:
      Green = exact match on all fields
      Yellow = name mismatch between framework and ADO
      Red = tag exists in old framework but not in new framework
      Orange = structural split (one tag maps to multiple scenarios)
P0-3: Pagination was handled. All 400 test cases are present.
      Count of rows in Excel matches count from ADO API response.
P0-4: No ADO Test Case was missed or skipped.

### PHASE 1 — Post-Run Excel Reporter
P1-1: Every scenario from the test run appears in the report.
      No scenario result is missing.
P1-2: Pass/Fail status matches the ExtentReport HTML exactly.
      No status is inverted or misread.
P1-3: Failure reason column is populated for every failed test.
      Never blank for a failed test.
P1-4: Screenshot path is valid and points to an existing file
      for every failed test that has a screenshot.
P1-5: ADO update (if enabled) only runs after Sunil approval.

### PHASE 2 — Migration Engine
P2-1: Every migrated feature file has all original @tags intact.
P2-2: Every Gherkin step in the migrated file has a matching
      step definition confirmed to exist in the project.
P2-3: No new Pages.java method was created without approval.
P2-4: No new Steps.java method was created without approval.
P2-5: Structural split cases are flagged and not auto-resolved.
P2-6: Migrated file follows new framework naming convention.
P2-7: Original old framework file was not deleted or modified.

### PHASE 3 — Web Locator Auto-Healer
P3-1: Locator fix is only in Pages.java. Never in Steps.java
      or .feature files.
P3-2: Old locator and new locator shown side by side to Sunil
      before any file is modified.
P3-3: Fix was explicitly approved by Sunil before being written.
P3-4: Only the specific failing locator was changed.
      No other locators in the file were touched.

### PHASE 4 — Perfecto Mobile Locator Healer
P4-1: All rules from Phase 3 apply.
P4-2: Every single fix was individually approved by Sunil.
      No batch approvals for mobile locators. Ever.
P4-3: Mobile locator strategy preference order was followed
      as defined in framework-architecture.instructions.md

---

## HOW COPILOT REPORTS VALIDATION RESULTS

### If ALL rules pass:
Copilot says:
"Validation passed. All {N} rules checked. No issues found.
Task complete."

### If ANY rule fails:
Copilot says:
"Validation failed. Task is NOT complete.
The following rules failed:

FAILED: {rule code} — {rule name}
Reason: {exactly what failed and why}
Fix required: {exactly what needs to change}

FAILED: {rule code} — {rule name}
Reason: {exactly what failed and why}
Fix required: {exactly what needs to change}

I will not mark this task complete until all failed rules
are resolved. Shall I fix these now?"

Copilot then waits for Sunil's instruction.
Copilot does NOT attempt to fix validation failures
automatically without Sunil's approval.

---

## IMPORTANT RULES FOR THIS SKILL

1. Validation runs before EVERY "Task complete" statement.
   There are no exceptions. Not even for small changes.
   Not even for "quick fixes." Every output is validated.

2. Validation failures are not optional to resolve.
   If a rule fails, the task is not done.
   Period.

3. Copilot never skips a validation layer because the task
   "seems simple." Simple tasks have caused the biggest
   problems on this project. Every output gets the full check.

4. When in doubt about whether a rule applies, apply it.
   False positives (flagging something that is actually fine)
   are far less costly than false negatives (missing a real issue).

5. This is a healthcare project with a real client.
   Quality is not optional. Every output that leaves this
   workspace reflects on Sunil and the team.
