# phase2-migration.instructions.md
# Attach this file in Copilot Chat when you say "start Phase 2"
# This file gives Copilot everything it needs to migrate scripts
# from the Old Framework (Quantum + Perfecto) to the New Framework
# (Java + Selenium + BDD Cucumber) without making assumptions.
#
# ATTACH ALONGSIDE:
#   - framework-architecture.instructions.md
#   - ado-api-reference.instructions.md
#   - .skills/validation.md
#   - .skills/standard-of-working.md
#
# PREREQUISITES:
#   Phase 0 must be complete.
#   The Reconciliation Excel is the migration work queue.
#   Copilot reads it to know which scripts need migration
#   and in what priority order.
#
# INSTRUCTIONS FOR SUNIL:
#   Phase 2 starts with a LEARNING phase (Steps 1-3 below)
#   before any migration code is written or generated.
#   Do not skip the learning phase.
#   Migrating without understanding both frameworks produces
#   incorrect feature files that fail at runtime.
# ================================================================

---

## WHAT PHASE 2 BUILDS

Phase 2 is NOT a Java utility like Phase 0 and Phase 1.
Phase 2 is an AI-assisted migration workflow where:
  - Copilot reads old framework .feature files
  - Copilot generates migrated .feature files for the new framework
  - Copilot checks for existing step definitions before proposing new ones
  - Sunil reviews and approves every migration before it is written
  - Structural split cases are flagged and handled with Sunil's input

Phase 2 output:
  - New .feature files in the new framework features folder
  - New Steps.java methods (only when no existing match found)
  - New Pages.java methods (only when no existing match found)
  - Updated Reconciliation Excel (Migration Status column updated)

---

## LEARNING PHASE — MANDATORY BEFORE ANY MIGRATION

### LEARNING STEP 1 — Read the New Framework Patterns

Copilot must read a MINIMUM of 15 feature files from the new
framework before attempting any migration.

For each file read, Copilot extracts and notes:
  - Tag format and placement
  - Feature declaration style
  - Scenario vs Scenario Outline usage patterns
  - Gherkin step writing style (level of detail, vocabulary)
  - How data parameters are handled in steps
  - How Examples tables are structured
  - Naming conventions for the file itself

After reading 15+ files, Copilot presents:
"I have read {N} feature files from the new framework.
 Here are the patterns I have identified:

 Tag format:         {example: @12345 @regression @local}
 Feature naming:     {example: Patient Appointment Management}
 Scenario naming:    {example: Verify patient can view appointments}
 Step style:         {example: plain English, no technical terms}
 Data parameters:    {example: Scenario Outline with Examples table}
 File naming:        {example: PatientAppointments.feature}
 Average steps:      {N} steps per scenario

 Does this match your expectations? Confirm before I proceed."

Wait for Sunil's confirmation.

### LEARNING STEP 2 — Read the Old Framework Patterns

Copilot must read a MINIMUM of 15 feature files from the old
framework before attempting any migration.

For each file read, Copilot extracts and notes:
  - How Quantum DSL keywords are used
  - How tags are structured (should match ADO IDs)
  - What step text looks like vs new framework step text
  - How locators or element references appear in steps (if at all)
  - Data table patterns
  - Naming conventions

After reading 15+ files, Copilot presents:
"I have read {N} feature files from the old framework.
 Here are the Quantum patterns I identified:

 Tag format:         {example from actual files}
 Step style:         {example from actual files}
 Data handling:      {example from actual files}
 Differences from new framework:
   - {difference 1}
   - {difference 2}
   - {difference 3}

 Does this match your understanding? Confirm before I proceed."

Wait for Sunil's confirmation.

### LEARNING STEP 3 — Build Migration Mapping Table

After both learning steps are confirmed, Copilot builds
a mapping table showing how Quantum patterns map to Gherkin:

| Quantum Pattern | Gherkin Equivalent | Notes |
|-----------------|-------------------|-------|
| {quantum step 1}| {gherkin step 1}  | {any edge case notes} |
| {quantum step 2}| {gherkin step 2}  | ... |

This table is populated from ACTUAL examples read in Steps 1 and 2.
Not invented. Not assumed. Only from what was actually read.

Present the table to Sunil:
"Here is the migration mapping I have built from reading your
 actual files. Please review and correct anything that is wrong.
 This table will guide every migration I perform."

Wait for Sunil's approval of the mapping table.
Only after this approval does Copilot proceed to migration.

---

## MIGRATION WORKFLOW — SINGLE SCRIPT

This is the workflow for migrating ONE script.
Follow this exactly for every single migration.

### PRE-MIGRATION CHECKS

Before migrating any script, Copilot must:

CHECK 1 — Read the Reconciliation Excel
  Find the row for this script.
  Note: ADO Tag, ADO Title, Old Title, Name Match Status,
        Split Case Flag, Action Needed.
  If Split Case Flag = YES: follow STRUCTURAL SPLIT workflow below.
  If Split Case Flag = NO: follow CLEAN MIGRATION workflow below.

CHECK 2 — Locate the old feature file
  Search old framework features folder for the file containing
  this @tag. Read the complete file.

CHECK 3 — Check if already partially migrated
  Search new framework features folder for the same @tag.
  If found: read the existing new framework file.
  Do not duplicate. Build on what is already there.
  If not found: start fresh.

### CLEAN MIGRATION WORKFLOW (Split Case Flag = NO)

CLEAN STEP 1 — Read the old scenario completely
  Read the full scenario from the old .feature file:
    - All tags
    - Scenario title
    - All Given/When/Then steps
    - Examples table if Scenario Outline
    - Background steps that apply to this scenario

CLEAN STEP 2 — Map each step to Gherkin equivalent
  For each step in the old scenario:
    a. Apply the migration mapping table from Learning Step 3
    b. If the step maps cleanly: note the Gherkin equivalent
    c. If the step has no clear mapping: flag it for Sunil review
       Never guess or invent a step that has no basis in the mapping

CLEAN STEP 3 — Check existing step definitions
  For each proposed Gherkin step:
    Search ALL Steps.java files in new framework for exact match.
    Report: "Step '{gherkin text}' — found in {filename} line {N}"
            OR "Step '{gherkin text}' — NO MATCH FOUND"
    If no match: propose new step definition — wait for approval.
    Never create a duplicate.

CLEAN STEP 4 — Check existing Pages.java methods
  For each step that needs a Pages.java method:
    Search ALL Pages.java files for existing method.
    Report: "Method '{methodName}' — found in {filename}"
            OR "Method '{methodName}' — NO MATCH FOUND"
    If no match: propose new method — wait for approval.

CLEAN STEP 5 — Generate the migrated feature file
  Draft the complete migrated .feature file:
    Line 1:   Feature-level tags (@regression and/or @smoke)
    Line 2:   Feature: {ADO Title from reconciliation Excel}
              Note: Use ADO Title as the Feature name for consistency
    Line 3:   Empty line
    Line 4:   Scenario-level tags in correct order:
              @{ADO Tag} @{suite tags} @{execution tag}
    Line 5:   Scenario: {ADO Title}
              Note: Scenario title = ADO Title exactly
    Line 6+:  Given/When/Then steps in correct order

  Present the COMPLETE draft to Sunil:
  "Here is the migrated feature file for @{tag}:

   [full file content shown here]

   Changes from old framework:
   - Title changed from '{old title}' to '{ADO title}'
   - {list any step text changes}
   - {list any new steps/methods needed}

   New step definitions needed: {list or 'None'}
   New Pages.java methods needed: {list or 'None'}

   Shall I write this to disk?"

  Wait for explicit approval before writing anything.

CLEAN STEP 6 — Write files (only after approval)
  Write the .feature file to new framework features folder.
  Write new Steps.java methods if approved.
  Write new Pages.java methods if approved.
  Update Reconciliation Excel: set Migration Status to "MIGRATED"
  Report: "Migration complete for @{tag}. Files written:
           {list of files created or modified}"

### STRUCTURAL SPLIT WORKFLOW (Split Case Flag = YES)

SPLIT STEP 1 — Read ALL scenarios with this tag
  Find every scenario in the old framework that shares this @tag.
  List them all to Sunil:
  "This tag @{tag} maps to {N} scenarios in the old framework:

   Scenario 1: '{title 1}' — {file path} line {N}
   Scenario 2: '{title 2}' — {file path} line {N}
   ...

   In ADO, this maps to Test Case {tag}: '{ADO title}'

   To resolve this split, we have these options:
   Option A: Keep as one scenario — combine steps logically
   Option B: Split into {N} separate scenarios with the same @tag
   Option C: Create {N} separate ADO Test Cases (requires client approval)

   Which option do you want to use for this split?"

  Wait for Sunil's decision. Never auto-resolve a structural split.

SPLIT STEP 2 — Execute based on Sunil's decision
  If Option A: follow clean migration workflow, combining steps.
  If Option B: create multiple scenarios under same @tag.
               Note in comments: "Split scenario {N} of {N}"
  If Option C: pause. This requires ADO changes.
               Tell Sunil: "This requires creating new test cases
               in ADO first. Please create them and provide the
               new Test Case IDs before I proceed."

SPLIT STEP 3 — Document the split decision
  Write a project-log entry for every structural split resolved:
  "run project-log: decision — @{tag} structural split resolved
   using Option {A/B/C}. {brief description of what was done}"

---

## BATCH PROCESSING RULES

### First 10 Scripts — Individual Review Mode
For the first 10 scripts:
  Migrate one at a time.
  Full workflow for each.
  Full review and approval for each.
  Do not move to script 11 until Sunil is satisfied with accuracy.

After script 10:
  "We have completed 10 migrations.
   Accuracy assessment:
   - {N} migrated cleanly with no issues
   - {N} needed corrections
   - {N} had step definition gaps
   - {N} had structural splits

   Are you satisfied with the accuracy?
   If yes, I can increase to batches of {N}.
   If no, let's discuss what to improve before continuing."

Wait for Sunil's decision on batch size.

### After Accuracy Confirmed — Batch Mode
Copilot processes scripts in batches of the approved size.
For each batch:
  Present all proposed migrations for the batch.
  Sunil reviews the batch as a group.
  Sunil approves or flags individual scripts for correction.
  Copilot writes all approved migrations.
  Copilot flags all rejected migrations for individual review.

Batch mode still requires:
  - Step definition check for every Gherkin step
  - Pages.java method check for every action
  - pr-scan on every generated file
  - Reconciliation Excel update after each batch

---

## MIGRATION PRIORITY ORDER

Migrate scripts in this priority order:
Use the Reconciliation Excel as the work queue.

PRIORITY 1 — Action Needed = "UPDATE TITLE" (easy wins)
  These are already migrated, just need title correction.
  Update the Scenario title in the new framework to match ADO Title.
  No step changes needed. Fast to complete.

PRIORITY 2 — Action Needed = "MIGRATE", Split = NO (clean migrations)
  Standard migrations. One old scenario to one new scenario.
  Follow clean migration workflow.

PRIORITY 3 — Action Needed = "MIGRATE", Split = YES
  Structural splits. More complex. Require Sunil's decision.
  Follow structural split workflow.

PRIORITY 4 — Action Needed = "VERIFY"
  Tags in ADO not found in old framework.
  Investigate before migrating. May not need migration.

PRIORITY 5 — Action Needed = "REVIEW SPLIT"
  Already flagged splits. Handle last after clean migrations done.

---

## STEP DEFINITION MANAGEMENT RULES

These rules prevent the most common migration mistake:
creating duplicate step definitions that break Cucumber.

RULE 1 — Search before creating
  Before proposing any new step definition:
  Search every Steps.java file in the new framework.
  Search for the EXACT annotation text (case-sensitive).
  If found anywhere: reuse. Never create duplicate.

RULE 2 — Annotation text must be exact
  The @Given/@When/@Then annotation text must exactly match
  the Gherkin step text in the feature file.
  If the step text is:
    "When the patient navigates to the appointments section"
  The annotation must be:
    @When("the patient navigates to the appointments section")
  No shortcuts. No regex unless the old framework used parameters.

RULE 3 — Parameters in steps
  If a step uses a parameter (data from Examples table):
    Gherkin: "When the patient enters {string} as username"
    Annotation: @When("the patient enters {string} as username")
    Method signature: public void enterUsername(String username)
  Always use Cucumber expression format {string}, {int}, {word}
  Not regex format (.*) unless absolutely necessary.

RULE 4 — One method per annotation
  Never put two annotations on one method.
  Each step gets its own method.
  Even if two steps do the same thing, they get separate methods
  that both call the same Pages.java method.

RULE 5 — Steps.java contains NO logic
  The step method body is ONE line: a call to Pages.java.
  Never add if/else, loops, or assertions in Steps.java.
  All logic goes in Pages.java methods.

---

## PAGES.JAVA MANAGEMENT RULES

RULE 1 — Search before creating
  Before proposing any new Pages.java method:
  Search every Pages.java file in new framework for a method
  that performs the same action on the same element.
  If found: reuse. Never duplicate.

RULE 2 — One method per action
  Each Pages.java method does ONE thing.
  "clickLoginButton" clicks the login button. Nothing else.
  Never combine multiple actions in one method.
  This makes maintenance easier when locators change.

RULE 3 — Locator naming follows convention
  Follow the naming convention from framework-architecture.instructions.md
  [FILL IN — confirm with Sunil: btn/txt/lbl/lnk prefix conventions]
  Example: private By btnLogin = By.id("login-button");

RULE 4 — Never hardcode waits
  If the old framework used Thread.sleep() or hardcoded waits:
  Replace with WebDriverWait and ExpectedConditions.
  Never introduce Thread.sleep() in migrated code.

RULE 5 — @local vs @perfecto locators
  If a locator works differently on web vs mobile:
  The Pages.java method must handle both cases.
  Use a config flag or the execution tag to branch:
  String executionMode = config.get("execution.mode");
  if ("perfecto".equals(executionMode)) { ... } else { ... }

---

## RECONCILIATION EXCEL UPDATE RULES

After every successful migration:
  Open Reconciliation Excel.
  Find the row with the matching ADO Tag.
  Update:
    New Framework Title → exact Scenario title written in new FW
    Migration Status    → "MIGRATED"
    Name Match Status   → "EXACT MATCH" if title matches ADO
                          "NAME MISMATCH" if title differs
    Action Needed       → "NONE" if fully resolved
                          "UPDATE TITLE" if title still differs

Do not update the Reconciliation Excel until the migration
is written to disk and confirmed by Sunil.
Never update it speculatively.

---

## PHASE 2 COMPLETION CRITERIA

Phase 2 is NOT complete until ALL of these are true:
  1. All 400 scripts have Migration Status = MIGRATED in Excel
     OR have been explicitly deferred by Sunil with documented reason
  2. No duplicate @tags exist in the new framework
  3. No orphan Gherkin steps (every step has a matching definition)
  4. No duplicate step definitions exist anywhere
  5. Reconciliation Excel updated with final migration status
  6. pr-scan passed on all migrated feature files
  7. At least one full regression run completed successfully
     after migration to confirm no runtime errors
  8. Sunil has signed off that Phase 2 is complete

---

## IMPORTANT REMINDERS FOR PHASE 2

1. Never skip the learning phase. It is not optional.
   Migrating without understanding both frameworks produces
   incorrect step text that fails at runtime.

2. The ADO Title becomes the Scenario title in the new framework.
   This is the source of truth for naming.
   Not the old framework title. Not an invented title. ADO Title.

3. Never delete old framework files.
   They are preserved until the client confirms old framework
   is fully sunset. Phase 2 only CREATES in new framework.

4. Structural splits cannot be auto-resolved.
   Every structural split requires a decision from Sunil.
   Document every decision in project-log.

5. Batch mode does not mean less rigorous.
   Every batch output is still validated and pr-scanned.
   Speed of batch processing does not reduce quality standards.

6. If a Gherkin step cannot be mapped from the Quantum step,
   do not invent a step. Stop and ask Sunil:
   "I could not find a Gherkin equivalent for this step:
    '{quantum step text}'
    How should this be written in the new framework?"

7. This is a healthcare project.
   Test data in Examples tables must never contain real patient data.
   If old framework Examples tables contain real data:
   Replace with generic placeholders and flag to Sunil immediately.
