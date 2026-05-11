# excel-output-spec.instructions.md
# Attach this file in Copilot Chat when working on Phase 0 or
# Phase 1 Excel output. This file is the precise specification
# that Copilot must follow when generating or updating any
# Excel file in this project.
#
# This file works alongside .skills/xlsx.md
# xlsx.md       = HOW to use Apache POI (patterns, code)
# this file      = WHAT to build (exact columns, rules, business logic)
#
# INSTRUCTIONS FOR SUNIL:
# No [FILL IN] placeholders in this file.
# Everything here is already defined and ready to use.
# Review once to confirm it matches your expectations,
# then attach it to every Phase 0 and Phase 1 session.
# ================================================================

---

## PART 1 — MASTER RECONCILIATION REPORT SPECIFICATION
## Phase 0 output. Built by ReconciliationReportWriter.java

---

### FILE DETAILS

Class that generates this:   ReconciliationReportWriter.java
File name pattern:            Reconciliation_Report_{yyyyMMdd_HHmmss}.xlsx
Sheet 1 name:                 Reconciliation
Sheet 2 name:                 Summary
Output location:              config.getProperty("report.outputPath")
Freeze pane:                  Row 1 (header row frozen)
Auto filter:                  Applied to header row after data written
Row height header:            20pt
Row height data:              16pt

---

### SHEET 1 — RECONCILIATION COLUMNS

Total columns: 8
Column order is fixed. Never change it.

COL 0 — ADO Tag
  Header text:      "ADO Tag"
  Column width:     15 characters (15 * 256 in POI units)
  Data type:        String
  Format:           Always includes @ symbol. Example: @12345
  Source:           ADO API response — testCase.id prefixed with @
  Required:         YES — never empty
  Validation:       Must start with @
                    Must be unique across all rows
                    Duplicate = CRITICAL error, stop and alert Sunil

COL 1 — ADO Title
  Header text:      "ADO Title"
  Column width:     50 characters
  Data type:        String
  Format:           Exact title as returned by ADO API
  Source:           ADO API response — testCase.name
  Required:         YES
  Validation:       If empty, write "NO TITLE IN ADO" and flag MEDIUM

COL 2 — Old Framework Title
  Header text:      "Old Framework Title"
  Column width:     50 characters
  Data type:        String
  Format:           Exact Scenario or Scenario Outline title from
                    old .feature file
  Source:           FeatureFileParser.java — old framework scan
  Required:         YES if tag exists in old framework
  If tag not found in old framework: write "NOT IN OLD FRAMEWORK"

COL 3 — New Framework Title
  Header text:      "New Framework Title"
  Column width:     50 characters
  Data type:        String
  Format:           Exact Scenario or Scenario Outline title from
                    new .feature file
  Source:           NewFrameworkParser.java — new framework scan
  Required:         NO — many will be empty during migration
  If tag not found in new framework: write "NOT MIGRATED"

COL 4 — Name Match Status
  Header text:      "Name Match Status"
  Column width:     22 characters
  Data type:        String — fixed value set only
  Allowed values:
    "EXACT MATCH"       — ADO Title, Old Title, New Title all match
                          (case-insensitive comparison)
    "NAME MISMATCH"     — tag exists in both frameworks and ADO
                          but titles differ
    "NOT MIGRATED"      — tag exists in old framework and ADO
                          but missing from new framework
    "STRUCTURAL SPLIT"  — same @tag appears on 2+ scenarios in
                          old framework
    "NOT IN OLD FW"     — tag exists in ADO but not in old framework
  Validation:       Value must be one of the five above exactly.
                    No other values permitted.

COL 5 — Migration Status
  Header text:      "Migration Status"
  Column width:     18 characters
  Data type:        String — fixed value set only
  Allowed values:
    "MIGRATED"      — tag exists in new framework
    "NOT MIGRATED"  — tag missing from new framework
    "PARTIAL"       — tag exists in new framework but step definitions
                      or pages not fully implemented
  Validation:       Value must be one of the three above exactly.

COL 6 — Split Case Flag
  Header text:      "Split Case Flag"
  Column width:     16 characters
  Data type:        String — fixed value set only
  Allowed values:
    "YES"           — one @tag maps to 2 or more scenarios
    "NO"            — one @tag maps to exactly one scenario
  Validation:       Value must be YES or NO exactly.

COL 7 — Action Needed
  Header text:      "Action Needed"
  Column width:     20 characters
  Data type:        String — fixed value set only
  Allowed values:
    "NONE"          — fully matched, no action needed
    "UPDATE TITLE"  — title needs updating in framework to match ADO
    "MIGRATE"       — script needs migration to new framework
    "REVIEW SPLIT"  — structural split needs manual review by Sunil
    "VERIFY"        — needs manual verification before marking done
  Validation:       Value must be one of the five above exactly.

---

### SHEET 1 — COLOR CODING LOGIC

Evaluate each row in this exact priority order:
Top priority first. First matching rule wins.

RULE 1 — STRUCTURAL SPLIT (highest priority)
  Condition:  Split Case Flag = "YES"
  Row color:  ORANGE  #FFCC99  bytes: FF CC 99
  Font color: BLACK   #000000

RULE 2 — NOT MIGRATED
  Condition:  Migration Status = "NOT MIGRATED"
  Row color:  RED     #FFC7CE  bytes: FF C7 CE
  Font color: DARK RED #9C0006

RULE 3 — NAME MISMATCH
  Condition:  Name Match Status = "NAME MISMATCH"
  Row color:  YELLOW  #FFEB9C  bytes: FF EB 9C
  Font color: DARK YELLOW #9C6500

RULE 4 — EXACT MATCH + MIGRATED (best case)
  Condition:  Name Match Status = "EXACT MATCH"
              AND Migration Status = "MIGRATED"
  Row color:  GREEN   #C6EFCE  bytes: C6 EF CE
  Font color: DARK GREEN #006100

RULE 5 — DEFAULT (all other cases)
  Row color:  WHITE   #FFFFFF
  Font color: BLACK   #000000

HEADER ROW (always):
  Background: DARK BLUE-GREY  #2F4F6F  bytes: 2F 4F 6F
  Font:       WHITE #FFFFFF, Bold, 11pt, Calibri
  Border:     THIN on all four sides

DATA ROWS:
  Font:       10pt, Calibri, not bold (except colored font rules above)
  Border:     THIN on all four sides
  Wrap text:  FALSE — single line per cell

---

### SHEET 1 — ROW ORDERING

Rows must be ordered in this sequence:
  1. STRUCTURAL SPLIT rows first (orange)
  2. NOT MIGRATED rows second (red)
  3. NAME MISMATCH rows third (yellow)
  4. EXACT MATCH rows last (green)
  5. DEFAULT rows after green

Within each group, order by ADO Tag numerically ascending.
Example: @12345 before @12890 before @13000

---

### SHEET 2 — SUMMARY TAB

Sheet name: Summary
This sheet contains aggregate statistics only.
No row-level data on this sheet.

Layout (rows top to bottom):

Row 0:  Header: "RECONCILIATION SUMMARY"
        Bold, 14pt, dark blue-grey color, merged across cols 0-1

Row 1:  Empty spacer row

Row 2:  Label: "Report generated"    Value: {date and time}
Row 3:  Label: "Total test cases"    Value: {total row count}
Row 4:  Label: "Source"              Value: "ADO Master Test Plan"

Row 5:  Empty spacer

Row 6:  Label: "MIGRATION STATUS"    Bold header
Row 7:  Label: "Migrated"            Value: {count}  {percentage}%
Row 8:  Label: "Not migrated"        Value: {count}  {percentage}%
Row 9:  Label: "Partial"             Value: {count}  {percentage}%

Row 10: Empty spacer

Row 11: Label: "MATCH STATUS"        Bold header
Row 12: Label: "Exact match"         Value: {count}  {percentage}%
Row 13: Label: "Name mismatch"       Value: {count}  {percentage}%
Row 14: Label: "Not in old FW"       Value: {count}  {percentage}%

Row 15: Empty spacer

Row 16: Label: "SPLIT CASES"         Bold header
Row 17: Label: "Structural splits"   Value: {count}  {percentage}%
Row 18: Label: "No split"            Value: {count}  {percentage}%

Row 19: Empty spacer

Row 20: Label: "ACTION NEEDED"       Bold header
Row 21: Label: "None"                Value: {count}
Row 22: Label: "Update title"        Value: {count}
Row 23: Label: "Migrate"             Value: {count}
Row 24: Label: "Review split"        Value: {count}
Row 25: Label: "Verify"              Value: {count}

Row 26: Empty spacer

Row 27: Label: "OVERALL PROGRESS"    Bold header
Row 28: Label: "Migration complete"  Value: {migrated/total * 100}%
        Color: GREEN if >= 80%, YELLOW if >= 50%, RED if < 50%

Column widths on Summary sheet:
  Col 0 (labels):  30 characters
  Col 1 (values):  15 characters
  Col 2 (percent): 12 characters

---

## PART 2 — REGRESSION RUN REPORT SPECIFICATION
## Phase 1 output. Built by RunReportWriter.java

---

### FILE DETAILS

Class that generates this:   RunReportWriter.java
File name pattern:            RunReport_{suiteName}_{yyyyMMdd_HHmmss}.xlsx
Sheet 1 name:                 Run Report
Sheet 2 name:                 Summary
Output location:              config.getProperty("report.outputPath")
Freeze pane:                  Row 1 (header row frozen)
Auto filter:                  Applied to header row after data written
Row height header:            20pt
Row height data:              16pt

---

### SHEET 1 — RUN REPORT COLUMNS

Total columns: 8
Column order is fixed. Never change it.

COL 0 — ADO Tag
  Header text:      "ADO Tag"
  Column width:     15 characters
  Data type:        String
  Format:           Always includes @ symbol. Example: @12345
  Required:         YES
  Source:           Parsed from Cucumber/ExtentReport output

COL 1 — ADO Title
  Header text:      "ADO Title"
  Column width:     50 characters
  Data type:        String
  Source:           Looked up from master reconciliation Excel
                    using the ADO Tag as the key
  If not found in reconciliation:  write "TITLE NOT FOUND"

COL 2 — Scenario Title
  Header text:      "Scenario Title (Feature File)"
  Column width:     50 characters
  Data type:        String
  Format:           Exact title from the executed .feature file
  Source:           Cucumber/ExtentReport output
  Required:         YES

COL 3 — Status
  Header text:      "Status"
  Column width:     10 characters
  Data type:        String — fixed value set only
  Allowed values:   "PASS" / "FAIL" / "SKIP"
  Required:         YES — never empty
  Validation:       Value must be exactly PASS, FAIL, or SKIP.
                    No other values. No lowercase.

COL 4 — Failure Reason
  Header text:      "Failure Reason"
  Column width:     60 characters
  Data type:        String
  Required:         YES for FAIL rows — NEVER empty for failed tests
  For PASS rows:    Empty cell
  For SKIP rows:    Write reason for skip if available, else empty
  Content:          Exception class name + first line of message
                    Example: "NoSuchElementException: Unable to locate
                    element: By.xpath: //button[@id='submit']"
  Max length:       500 characters. Truncate with "..." if longer.

COL 5 — Screenshot
  Header text:      "Screenshot"
  Column width:     40 characters
  Data type:        String (file path)
  For FAIL rows:    Relative path to screenshot file
                    If no screenshot: write "No screenshot captured"
  For PASS rows:    Empty cell
  For SKIP rows:    Empty cell
  Path format:      Relative to project root, forward slashes
                    Example: output/screenshots/TC_12345_20240315.png

COL 6 — Duration (sec)
  Header text:      "Duration (sec)"
  Column width:     15 characters
  Data type:        String (numeric value or N/A)
  Format:           Decimal seconds. Example: "12.45"
                    If not available: "N/A"

COL 7 — Suite
  Header text:      "Suite"
  Column width:     15 characters
  Data type:        String — fixed value set only
  Allowed values:   "regression" / "smoke"
  Required:         YES — populated from run configuration

---

### SHEET 1 — COLOR CODING LOGIC

PASS rows:
  Background: GREEN   #C6EFCE  bytes: C6 EF CE
  Font:       DARK GREEN #006100  Bold: FALSE

FAIL rows:
  Background: RED     #FFC7CE  bytes: FF C7 CE
  Font:       DARK RED #9C0006  Bold: FALSE

SKIP rows:
  Background: YELLOW  #FFEB9C  bytes: FF EB 9C
  Font:       DARK YELLOW #9C6500  Bold: FALSE

HEADER ROW:
  Background: DARK BLUE-GREY #2F4F6F  bytes: 2F 4F 6F
  Font:       WHITE #FFFFFF  Bold: TRUE  11pt  Calibri
  Border:     THIN all sides

---

### SHEET 1 — ROW ORDERING

Rows must be ordered in this sequence:
  1. FAIL rows first (most important — action needed)
  2. SKIP rows second
  3. PASS rows last

Within each group, order by ADO Tag numerically ascending.

---

### SHEET 2 — SUMMARY TAB

Sheet name: Summary

Row 0:  Header: "RUN REPORT SUMMARY"     Bold 14pt dark blue-grey
Row 1:  Empty spacer
Row 2:  Label: "Suite"                   Value: {regression or smoke}
Row 3:  Label: "Run date"                Value: {date and time}
Row 4:  Label: "Report generated"        Value: {generation timestamp}
Row 5:  Empty spacer
Row 6:  Label: "RESULTS"                 Bold header
Row 7:  Label: "Total scenarios"         Value: {total count}
Row 8:  Label: "Passed"                  Value: {count}  {percentage}%
        Color cell: GREEN #C6EFCE
Row 9:  Label: "Failed"                  Value: {count}  {percentage}%
        Color cell: RED #FFC7CE
Row 10: Label: "Skipped"                 Value: {count}  {percentage}%
        Color cell: YELLOW #FFEB9C
Row 11: Empty spacer
Row 12: Label: "Pass rate"               Value: {passed/total * 100}%
        Bold. Color: GREEN if >= 90%, YELLOW if >= 70%, RED if < 70%
Row 13: Empty spacer
Row 14: Label: "FAILED TEST CASES"       Bold header
Row 15 onwards: One row per failed test case
        Format: {ADO Tag}  {ADO Title}
        All rows colored RED #FFC7CE

Column widths on Summary sheet:
  Col 0 (labels):  25 characters
  Col 1 (values):  15 characters
  Col 2 (percent): 12 characters

---

## PART 3 — SHARED RULES FOR BOTH FILES

1. Both files must be generated to the folder defined in
   config.getProperty("report.outputPath").
   Never hardcode the output path.

2. Both files must include a timestamp in the file name.
   Use format: yyyyMMdd_HHmmss
   This ensures no file is ever overwritten by a new run.

3. Both files must have the output directory created
   automatically if it does not exist.
   Use: outputFile.getParentFile().mkdirs()

4. Both files must be closed in a finally block or
   try-with-resources after writing.

5. All styles must be created ONCE before the data loop.
   Never create a new style inside a row or cell loop.
   Excel limit: ~64,000 unique styles. Exceeding this corrupts the file.

6. Column order is fixed in both files.
   Never change it. Team processes depend on consistent positions.

7. ADO Tag column always includes the @ symbol.
   @12345 not 12345. This matches the feature file format exactly.

8. Both files must pass data-explore profiling before
   being presented to Sunil as complete.
   Run data-explore silently after generation.
   Report only if anomalies are found.

9. Both files must pass pr-scan before being shared.
   No patient data. No credentials. No real personal information.

10. When both files are generated in the same session,
    generate the Reconciliation Report first (Phase 0).
    The Run Report (Phase 1) looks up ADO Titles from
    the Reconciliation Report. It depends on Phase 0 output.
