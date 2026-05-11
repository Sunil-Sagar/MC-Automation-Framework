# locator-change-log.md
# SKILL: locator-change-log
# ================================================================
# HOW TO INVOKE THIS SKILL:
# Type in Copilot Chat:
#   "run locator-log"
#       → appends current locator change to the tracking Excel
#   "run locator-log: manual"
#       → manually record a locator change not from Phase 3/4
#   "run locator-log: view"
#       → shows all locator changes for a specific module
#         "run locator-log: view {module name}"
#   "run locator-log: report"
#       → generates a full locator change summary report
#
# WHAT THIS SKILL DOES:
# Maintains a living Excel file that tracks every locator change,
# method modification, and Pages.java update made on this project.
#
# This replaces the manual Excel file the team currently maintains.
# Every change is recorded automatically — no manual updates needed.
#
# WHY THIS EXISTS:
# When a new tester works on a module, they need to know:
#   - What locators changed recently and why
#   - What methods were modified and what the impact is
#   - Whether a locator was auto-healed or manually fixed
#   - Who approved the change and when
# Without this log, new testers waste time debugging changes
# that are already documented nowhere.
#
# WHEN IT RUNS AUTOMATICALLY:
# After EVERY approved locator fix in Phase 3 (web^) and Phase 4
# (mobile^), this skill runs automatically to append the change.
# Sunil does not need to invoke it manually after healing sessions.
#
# WHEN TO RUN MANUALLY:
# When a developer manually updates a locator or method in Pages.java
# outside of the healing workflow.
# ================================================================

---

## TARGET FILE

File name:    Locator_Change_Log.xlsx
Location:     config.getProperty("report.outputPath")
Sheet 1:      Change Log
Sheet 2:      Summary by Module

This file is created on first use and appended on every subsequent use.
Never overwritten. Never deleted. Append only.

---

## SHEET 1 — CHANGE LOG COLUMNS

Total columns: 12
Column order is fixed. Never change it.

COL 0 — Entry ID
  Header:   "ID"
  Content:  Auto-incrementing integer. 1, 2, 3...
  Width:    8 characters

COL 1 — Date
  Header:   "Date"
  Content:  Date of change. Format: DD-MMM-YYYY
  Example:  15-Mar-2024
  Width:    14 characters

COL 2 — Module
  Header:   "Module"
  Content:  The functional module name.
            Derived from the Pages.java class name.
            Example: PatientAppointmentsPage → "Patient Appointments"
  Width:    25 characters

COL 3 — Pages.java File
  Header:   "Pages.java File"
  Content:  Just the file name, not the full path.
  Example:  PatientAppointmentsPage.java
  Width:    35 characters

COL 4 — Variable Name
  Header:   "Locator Variable"
  Content:  The exact variable name in Pages.java
  Example:  btnScheduleAppointment
  Width:    30 characters

COL 5 — Old Locator
  Header:   "Old Locator"
  Content:  Strategy + value before the change.
  Format:   {strategy}: {value}
  Example:  xpath: //button[@id='old-schedule-btn']
  Width:    60 characters

COL 6 — New Locator
  Header:   "New Locator"
  Content:  Strategy + value after the change.
  Format:   {strategy}: {value}
  Example:  xpath: //button[@data-testid='schedule-appointment']
  Width:    60 characters

COL 7 — Change Reason
  Header:   "Reason for Change"
  Content:  Why the locator was changed.
  Allowed values:
    "UI CHANGE — element ID/attribute changed by dev team"
    "AUTO-HEALED — Phase 3 web locator healing"
    "AUTO-HEALED — Phase 4 Perfecto mobile healing"
    "MANUAL FIX — locator updated manually during maintenance"
    "MIGRATION — locator added during Phase 2 migration"
    "REFACTOR — locator improved for stability"
  Width:    45 characters

COL 8 — Platform
  Header:   "Platform"
  Content:  Where this locator is used.
  Allowed values: "WEB" / "MOBILE-ANDROID" / "MOBILE-IOS" / "BOTH"
  Width:    18 characters

COL 9 — ADO Tag
  Header:   "ADO Tag"
  Content:  The @tag of the scenario that uses this locator.
            If multiple scenarios use it: most relevant one.
  Example:  @12345
  Width:    12 characters

COL 10 — Approved By
  Header:   "Approved By"
  Content:  Who approved this change.
  Default:  "Sunil Sagar"
  Width:    20 characters

COL 11 — Notes
  Header:   "Notes"
  Content:  Any additional context for future reference.
            What test was failing, what sprint, any caveats.
  Width:    50 characters

---

## SHEET 2 — SUMMARY BY MODULE

This sheet is regenerated every time a new entry is added.

Columns:
  Module Name | Total Changes | Last Changed | Most Recent Reason

One row per module. Sorted by Last Changed date descending.
Most recently changed module appears at top.

This is the sheet a new tester reads first to understand
what has changed in the module they are about to work on.

---

## AUTOMATIC RUN AFTER PHASE 3 OR PHASE 4 FIX

When a locator fix is approved and written in Phase 3 or Phase 4,
Copilot automatically runs this skill with the following data:

From Phase 3 (web healing):
  Module:        derived from Pages.java class name
  Pages.java:    the file that was modified
  Variable:      the locator variable name
  Old Locator:   the failed locator
  New Locator:   the Claude-suggested locator
  Reason:        "AUTO-HEALED — Phase 3 web locator healing"
  Platform:      "WEB"
  ADO Tag:       the tag of the failing scenario
  Approved By:   "Sunil Sagar"

From Phase 4 (mobile healing):
  Same as above but:
  Reason:    "AUTO-HEALED — Phase 4 Perfecto mobile healing"
  Platform:  "MOBILE-ANDROID" or "MOBILE-IOS" based on device

Copilot says after appending:
"Locator change logged.
 Entry ID: {N}
 Module: {module}
 Change: {old value} → {new value}
 Locator_Change_Log.xlsx updated."

---

## MANUAL ENTRY FORMAT

When "run locator-log: manual" is invoked:

Copilot asks these questions one at a time:
  1. "Which Pages.java file was modified?"
  2. "What is the variable name of the locator that changed?"
  3. "What was the old locator value? (strategy: value)"
  4. "What is the new locator value? (strategy: value)"
  5. "Why was this changed?"
     Show the allowed values list and wait for selection.
  6. "Which platform? WEB / MOBILE-ANDROID / MOBILE-IOS / BOTH"
  7. "Which ADO tag does this relate to?"
  8. "Any additional notes?"

After all answers collected, Copilot presents:
"Here is the entry I will append:

 Module:    {module}
 File:      {file}
 Variable:  {variable}
 Old:       {old locator}
 New:       {new locator}
 Reason:    {reason}
 Platform:  {platform}
 Tag:       {tag}
 Notes:     {notes}

 Append this to Locator_Change_Log.xlsx? (yes / no)"

Wait for approval before appending.

---

## VIEW COMMAND

When "run locator-log: view {module}" is invoked:

Copilot reads Locator_Change_Log.xlsx and filters by module.
Presents all changes for that module in a readable format:

"Locator changes for module: {module name}
 Total changes: {N}

 Most recent first:

 [{date}] {variable}
   Old: {old locator}
   New: {new locator}
   Reason: {reason}
   Notes: {notes}

 [{date}] {variable}
   ...

 Use this context before working on the {module} module."

---

## IMPORTANT RULES FOR THIS SKILL

1. This file is APPEND ONLY. Never overwrite existing entries.
   Past entries are permanent. They are the audit trail.

2. Module name is always derived from the Pages.java class name.
   PatientAppointmentsPage.java → "Patient Appointments"
   Strip "Page" suffix and add spaces between words.
   Consistent naming is critical for the Summary sheet to work.

3. Never log sensitive patient data in any column.
   The Notes column especially — no patient names, no test data values.
   Log only: element names, locator strategies, technical context.

4. This file is safe to share with the client and new team members.
   It is a technical change log, not a test data log.
   Run pr-scan before sharing externally.

5. The Summary sheet is always regenerated fresh when a new entry
   is added. It always reflects the current state.

6. If the file does not exist when this skill runs:
   Create it with the header rows first, then append the entry.
   Never fail silently if the file is missing.
