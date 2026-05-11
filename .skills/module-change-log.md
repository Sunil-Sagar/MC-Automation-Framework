# module-change-log.md
# SKILL: module-change-log
# ================================================================
# HOW TO INVOKE THIS SKILL:
# Type in Copilot Chat:
#   "run module-log: {module name}"
#       → shows full change history for a specific module
#         Example: "run module-log: Patient Appointments"
#   "run module-log: update {module name}"
#       → appends a new change entry for a module
#   "run module-log: all"
#       → shows summary of all modules and their last change date
#   "run module-log: new-tester {module name}"
#       → generates a new tester briefing for a specific module
#
# WHAT THIS SKILL DOES:
# Maintains a per-module change history that any team member
# can read before working on a module.
# This is the "what happened here" document for each module.
#
# DIFFERENCE FROM locator-change-log.md:
#   locator-change-log.md  → tracks LOCATOR and METHOD changes only
#   module-change-log.md   → tracks ALL changes to a module:
#                             feature file changes, step changes,
#                             page changes, locator changes,
#                             ADO title updates, test additions,
#                             test removals, and anything else
#
# TARGET AUDIENCE:
# A new tester assigned to work on a module reads this FIRST
# before touching any file in that module.
# It tells them exactly what changed, when, why, and what to
# watch out for — saving hours of investigation time.
#
# WHEN TO UPDATE:
# After any of these actions on a module:
#   - Feature file changed (step added, removed, or modified)
#   - Steps.java method added or changed
#   - Pages.java method added, changed, or locator updated
#   - ADO test case title updated
#   - Test case migrated from old to new framework
#   - Test case added or removed from suite
#   - Known issue or flaky test identified
# ================================================================

---

## TARGET FILE

File name:    Module_Change_Log.md
Location:     .project/module-change-log.md
Format:       Markdown — readable in VS Code directly
              No Excel needed — this is a quick-read reference

---

## FILE STRUCTURE

The file is organized by module. Each module has its own section.
New entries are PREPENDED within each module section
(newest first so the reader sees the most recent change immediately).

================================================
# MODULE CHANGE LOG — MC HEALTHCARE PORTAL
# Last updated: {date}
# Purpose: Per-module change history for team reference.
#          Read this before working on any module.
================================================

---

## MODULE: Patient Appointments

Last changed: {date}
Total changes: {N}
Current state: {STABLE / ACTIVE CHANGES / KNOWN ISSUES}

### [{date}] {change type} — {short description}
Phase:      {which phase or MANUAL}
Changed by: Sunil Sagar
Files:      {list of files touched}
What:       {what was changed}
Why:        {why it was changed}
Impact:     {what else might be affected}
Watch out:  {anything a new tester should know}

### [{date}] {change type} — {short description}
...

---

## MODULE: Patient Login

...

---

## MODULE: Patient Messages

...

================================================
END OF MODULE CHANGE LOG
================================================

---

## CHANGE TYPES

Use exactly one of these types for every entry:

MIGRATION    → script migrated from old framework to new framework
LOCATOR-FIX  → locator updated due to UI change or healing
METHOD-CHANGE→ Pages.java method logic modified
STEP-CHANGE  → Steps.java method modified
FEATURE-EDIT → .feature file steps added, removed, or modified
TITLE-UPDATE → scenario title updated to match ADO
TEST-ADDED   → new test case added to this module
TEST-REMOVED → test case removed or deprecated
KNOWN-ISSUE  → flaky test or known failure documented
REFACTOR     → code improved without behaviour change
CONFIG-CHANGE→ module-specific config value changed

---

## AUTOMATIC UPDATE TRIGGERS

This skill appends automatically after these events:

AFTER PHASE 2 MIGRATION:
  Copilot appends:
    Type:    MIGRATION
    What:    @{tag} '{scenario title}' migrated to new framework
    Why:     Migration Phase 2
    Impact:  Feature file, Steps.java, Pages.java updated
    Watch:   Verify on @local before adding to @regression suite

AFTER PHASE 3 LOCATOR FIX:
  Copilot appends:
    Type:    LOCATOR-FIX
    What:    {variable name} updated in {Pages.java file}
    Why:     UI change detected, auto-healed by Phase 3
    Impact:  Any test using this locator may be affected
    Watch:   Run @{tag} and confirm pass before regression

AFTER PHASE 4 MOBILE LOCATOR FIX:
  Copilot appends:
    Type:    LOCATOR-FIX
    What:    {variable name} updated (mobile — {platform})
    Why:     Perfecto session showed locator broken
    Impact:  Mobile tests using this locator
    Watch:   Verify on Perfecto device before next regression

AFTER RECONCILIATION EXCEL TITLE UPDATE:
  Copilot appends:
    Type:    TITLE-UPDATE
    What:    Scenario title updated to match ADO title
    Why:     Name mismatch resolved in reconciliation
    Impact:  Feature file title only, no logic change
    Watch:   None — cosmetic change only

---

## NEW TESTER BRIEFING FORMAT

When "run module-log: new-tester {module}" is invoked:

Copilot reads the module section and generates a briefing:

"================================================
 NEW TESTER BRIEFING — {MODULE NAME}
 Generated: {date}
 ================================================

 CURRENT STATE: {STABLE / ACTIVE CHANGES / KNOWN ISSUES}

 WHAT THIS MODULE TESTS:
 {2-3 sentences from knowledge.md about this module's function}

 FILES YOU WILL WORK WITH:
   Feature file:  {file path}
   Steps file:    {file path}
   Pages file:    {file path}
   ADO Suite:     {suite name in ADO}

 RECENT CHANGES (last 3^):
 {last 3 entries from this module's change log}

 KNOWN ISSUES TO WATCH OUT FOR:
 {any KNOWN-ISSUE entries for this module}
 {If none: 'No known issues at this time.'}

 LOCATOR CHANGES THIS MONTH:
 {entries from Locator_Change_Log.xlsx for this module
  in the last 30 days}
 {If none: 'No locator changes in the last 30 days.'}

 BEFORE YOU START WORKING:
 1. Run: mvn test -Dcucumber.filter.tags='@{module tag} and @local'
    to confirm all tests in this module are currently passing.
 2. If any are failing: check the run report first before changing code.
 3. If you need to modify a locator: run Phase 3 healer first,
    do not change manually without checking the auto-healer output.
 ================================================"

---

## VIEW COMMAND

When "run module-log: {module name}" is invoked:

Copilot reads .project/module-change-log.md and presents
the full history for that module in plain text in chat.

Most recent entry first.
Maximum 10 entries shown. If more exist: "Run 'run module-log: all'
to see complete history."

---

## ALL MODULES SUMMARY

When "run module-log: all" is invoked:

Copilot reads .project/module-change-log.md and presents:

"MODULE SUMMARY — MC HEALTHCARE PORTAL

 Module                  | Last Changed | Changes | State
 ------------------------|--------------|---------|-------
 Patient Appointments    | 15-Mar-2024  | 8       | STABLE
 Patient Login           | 12-Mar-2024  | 3       | STABLE
 Patient Messages        | 10-Mar-2024  | 5       | KNOWN ISSUES
 Patient Health Records  | 08-Mar-2024  | 2       | ACTIVE CHANGES

 Most active module: {module with most changes}
 Last touched:       {most recently changed module}"

---

## IMPORTANT RULES FOR THIS SKILL

1. This file lives in .project/ not in .skills/.
   It is a living project document, not an instruction file.
   It grows with the project and is read by the team.

2. New entries are PREPENDED within each module section.
   Newest change at the top. Oldest at the bottom.
   This means a reader sees the most relevant context first.

3. The module name must be consistent across all entries.
   "Patient Appointments" not "PatientAppointments" not "Appointments".
   Use the same human-readable name every time.
   Derived from Pages.java class name with spaces and no "Page" suffix.

4. The "Watch out" field is the most important field.
   It tells the next person what to be careful about.
   Never leave it as "None" unless there is genuinely nothing to note.
   Think about what you wish you had known before making this change.

5. This file is safe to share with new team members.
   It does not contain patient data, credentials, or sensitive info.
   It is purely technical change history.

6. The new tester briefing combines data from THREE sources:
   - module-change-log.md (change history)
   - Locator_Change_Log.xlsx (locator changes)
   - knowledge.md (module purpose)
   All three must be read before generating the briefing.
