# data-explore.md
# SKILL: data-explore
# ================================================================
# HOW TO INVOKE THIS SKILL:
# Type in Copilot Chat:
#   "run data-explore: {file path}"
#       → profiles a specific file
#   "run data-explore: {file path} full"
#       → full deep profile including distributions
#   "run data-explore: compare {file1} {file2}"
#       → compares structure of two files side by side
#   "run data-explore: reconciliation"
#       → profiles the master reconciliation Excel specifically
#   "run data-explore: run-report"
#       → profiles the latest run report Excel specifically
#
# WHAT THIS SKILL DOES:
# Automatically profiles any dataset the project works with.
# Saves the 20 minutes previously spent writing exploratory
# queries before any real analysis or reporting work begins.
#
# Produces a structured DATA PROFILE REPORT covering:
#   - File summary (type, size, row count, column count)
#   - Column inventory (name, type, population rate)
#   - Null and empty value counts per column
#   - Value distributions for key columns
#   - Anomalies and data quality flags
#   - Readiness assessment for its intended use
#
# DATASETS THIS PROJECT WORKS WITH:
#   1. Master Reconciliation Excel  (Phase 0 output)
#   2. Regression Run Report Excel  (Phase 1 output)
#   3. Old Framework feature files  (input for Phase 0 and 2)
#   4. New Framework feature files  (input for Phase 0 and 2)
#   5. ADO API response data        (input for Phase 0)
#   6. ExtentReport HTML output     (input for Phase 1)
# ================================================================

---

## WHAT COPILOT DOES WHEN data-explore IS INVOKED

Step 1: Identify the file type
        Is it Excel (.xlsx), feature file (.feature),
        HTML (.html), JSON, or plain text?
        Use the file extension to determine the reading approach.

Step 2: Read the file completely
        Do not sample. Read every row, every column, every field.
        For large files (400+ rows) reading everything is still
        required — 400 rows is not large by any standard.

Step 3: Generate the DATA PROFILE REPORT
        Follow the format defined in Section 2 below.

Step 4: Present the report to Sunil
        Do not ask questions first. Read, profile, present.
        After presenting, ask:
        "Would you like me to investigate any specific column
        or anomaly further?"

---

## SECTION 1 — READING APPROACH BY FILE TYPE

### 1.1 — Excel Files (.xlsx)
Use Apache POI XSSFWorkbook to read.
Follow the safe cell value reader pattern from xlsx.md.
Read every sheet, not just the first one.
For each sheet: count rows (excluding header), count columns,
read every cell value.

### 1.2 — Feature Files (.feature)
Read as plain text using Java File I/O.
Parse line by line.
Identify: tags (lines starting with @),
          feature declarations (lines starting with Feature:),
          scenario declarations (Scenario: or Scenario Outline:),
          step lines (Given/When/Then/And/But),
          examples tables (lines starting with |),
          comments (lines starting with #).

### 1.3 — HTML Files (.html — ExtentReport)
Read as plain text.
Parse for: test names, pass/fail status markers,
           error messages, timestamps.
Note: Full HTML parsing requires jsoup library.
      Check pom.xml for jsoup before attempting HTML parsing.
      If jsoup not present, flag to Sunil and use regex-based
      parsing as a fallback for simple patterns only.

### 1.4 — JSON (ADO API responses)
Parse using whatever JSON library is confirmed in pom.xml
(org.json, Jackson, or Gson — check first, never assume).
Read every field. Count items in arrays.

---

## SECTION 2 — DATA PROFILE REPORT FORMAT

Present this report every time data-explore runs.
Never skip a section. If data is not available for a section,
write "Not available — reason: {why}" instead of leaving blank.

================================================
# DATA PROFILE REPORT
File:         {file name and path}
File type:    {xlsx / feature / html / json / text}
File size:    {size in KB or MB}
Profiled on:  {date and time}
Profiled by:  Copilot — data-explore skill
================================================

## 1. FILE SUMMARY

Total rows:         {count excluding header row}
Total columns:      {count}
Sheets (if Excel):  {list of sheet names and row counts}
Encoding:           {UTF-8 / other if detectable}
Empty file:         {YES / NO}

## 2. COLUMN INVENTORY

{For each column, one row in this table format:}

| Col # | Column Name | Data Type | Populated | Null/Empty | Unique Values | Sample Values |
|-------|-------------|-----------|-----------|------------|---------------|---------------|
| 0     | ADO Tag     | String    | 400/400   | 0          | 400           | @12345, @12346 |
| 1     | ADO Title   | String    | 398/400   | 2          | 398           | "Verify patient..." |
| ...   | ...         | ...       | ...       | ...        | ...           | ... |

Data Type options:
  String    — text values
  Numeric   — numbers (integer or decimal)
  Boolean   — true/false or yes/no
  Date      — date or datetime values
  Mixed     — column contains more than one type (flag this)
  Empty     — entire column is empty (flag this)

Population rate: count of non-empty cells / total rows
If population rate < 90%, flag as LOW POPULATION.
If population rate = 0%, flag as EMPTY COLUMN.

## 3. NULL AND EMPTY VALUE ANALYSIS

Columns with null or empty values:
{List each column that has any empty values}

| Column Name | Empty Count | Empty % | Impact |
|-------------|-------------|---------|--------|
| ADO Title   | 2           | 0.5%    | LOW — 2 test cases have no ADO title |
| ...         | ...         | ...     | ...   |

Impact levels:
  CRITICAL — this column is required for the phase to work correctly
  HIGH     — this column is important and gaps will cause issues
  LOW      — this column is optional or gaps are acceptable
  NONE     — empty values are expected and acceptable here

## 4. VALUE DISTRIBUTION (KEY COLUMNS ONLY)

For columns with a fixed set of expected values
(like Status, Migration Status, Action Needed),
show the distribution:

Column: Name Match Status
  EXACT MATCH:      {count} ({percentage}%)
  NAME MISMATCH:    {count} ({percentage}%)
  NOT MIGRATED:     {count} ({percentage}%)
  STRUCTURAL SPLIT: {count} ({percentage}%)
  UNEXPECTED VALUE: {count} ({percentage}%) ← flag if > 0

Column: Migration Status
  MIGRATED:     {count} ({percentage}%)
  NOT MIGRATED: {count} ({percentage}%)
  PARTIAL:      {count} ({percentage}%)

Column: Status (Run Report)
  PASS:  {count} ({percentage}%)
  FAIL:  {count} ({percentage}%)
  SKIP:  {count} ({percentage}%)

Column: Split Case Flag
  YES: {count} ({percentage}%)
  NO:  {count} ({percentage}%)

## 5. ANOMALIES AND DATA QUALITY FLAGS

{List every anomaly found. If none found, write "No anomalies found."}

Format:
FLAG: {severity} — {column name} — {description of anomaly}
Example:
FLAG: HIGH — ADO Tag — 3 rows have duplicate @tags.
      Tags: @12345 (appears 2x), @12890 (appears 2x).
      Duplicate tags corrupt the reporting system.

FLAG: MEDIUM — New Framework Title — 15 rows contain "NOT MIGRATED"
      These scripts have not been moved to the new framework yet.

FLAG: LOW — Duration (sec) — 47 rows show "N/A" for duration.
      Screenshots may not be available for these runs.

Anomaly types to check for:
  DUPLICATE TAGS        — same @tag appears more than once
  UNEXPECTED VALUES     — value not in the expected set for that column
  MISSING REQUIRED DATA — required column has empty values
  INCONSISTENT FORMAT   — same column has values in different formats
  MISMATCHED COUNTS     — row count does not match expected total
  ORPHAN RECORDS        — tag in framework not found in ADO or vice versa

## 6. FEATURE FILE SPECIFIC ANALYSIS
(Only shown when profiling .feature files)

Total feature files scanned:    {count}
Total scenarios found:          {count}
Total scenario outlines found:  {count}
Total tags found:               {count}
Unique tags:                    {count}
Duplicate tags:                 {count and list them — CRITICAL if > 0}
Scenarios with no tags:         {count and list files — flag as HIGH}
Scenarios with @local tag:      {count}
Scenarios with @perfecto tag:   {count}
Scenarios with neither tag:     {count — flag as MEDIUM}
Scenarios with @regression:     {count}
Scenarios with @smoke:          {count}
Steps per scenario (average):   {average}
Steps per scenario (max):       {max — flag if > 15}
Steps per scenario (min):       {min — flag if < 2}
Empty feature files:            {count and list — flag as HIGH}
Feature files with no scenarios:{count and list — flag as HIGH}

## 7. READINESS ASSESSMENT

Based on the profile above, this dataset is:

FOR PHASE {N} — {READY / NOT READY / NEEDS ATTENTION}

{2-4 sentences explaining the readiness verdict.
Be specific. Name the issues that must be resolved
before the phase can proceed correctly.}

Issues that MUST be resolved before proceeding:
{Numbered list of blocking issues. If none, write "None."}

Issues that SHOULD be resolved but are not blocking:
{Numbered list. If none, write "None."}

================================================
END OF DATA PROFILE REPORT
================================================

---

## SECTION 3 — COMPARISON MODE

When "run data-explore: compare {file1} {file2}" is used:

Copilot produces a side-by-side comparison showing:

| Attribute        | File 1          | File 2          | Match? |
|------------------|-----------------|-----------------|--------|
| Row count        | 400             | 387             | NO     |
| Column count     | 8               | 8               | YES    |
| ADO Tag coverage | 400 unique tags | 387 unique tags | NO     |
| ...              | ...             | ...             | ...    |

Missing in File 2 (tags in File 1 not in File 2):
{list of missing tags}

Extra in File 2 (tags in File 2 not in File 1):
{list of extra tags}

This mode is useful for:
- Comparing old framework vs new framework tag coverage
- Comparing reconciliation report vs ADO test case list
- Comparing two run reports from different dates

---

## SECTION 4 — SPECIFIC PROFILES

### reconciliation profile
When "run data-explore: reconciliation" is used:

In addition to the standard profile, also check:
- Total row count matches ADO test case count from last API pull
- Every ADO Tag has the @ prefix
- No ADO Tag appears more than once
- Every row has a value in ADO Title column
- Color coding is consistent with Name Match Status values
- Summary section is present at the bottom of the sheet
- Migration complete percentage is calculated correctly

### run-report profile
When "run data-explore: run-report" is used:

In addition to the standard profile, also check:
- Every FAIL row has a non-empty Failure Reason
- Every FAIL row has a Screenshot value (path or "No screenshot")
- Pass rate is calculated correctly in Summary sheet
- No scenario appears in the report without an ADO Tag
- Status values are only PASS, FAIL, or SKIP — nothing else
- Suite column is populated for every row

---

## SECTION 5 — IMPORTANT RULES FOR THIS SKILL

1. Always read the entire file. Never sample.
   400 rows is the maximum this project will ever have.
   There is no reason to sample.

2. Never modify the file being profiled.
   data-explore is a READ-ONLY operation.
   If an anomaly is found, report it. Do not fix it.
   Sunil decides what to fix and when.

3. Duplicate @tags are always a CRITICAL anomaly.
   They corrupt the reporting system and the ADO mapping.
   Never downgrade this to HIGH or MEDIUM.

4. The readiness assessment must be honest.
   If the data has issues that will cause a phase to fail,
   say so clearly. Do not soften the verdict to avoid
   making Sunil uncomfortable.
   A false READY verdict wastes more time than a hard truth.

5. This is a healthcare project.
   If any column appears to contain real patient data
   (names, IDs, health information), immediately flag it
   as CRITICAL and invoke pr-scan on the file.
   Do not continue the profile until Sunil addresses it.

6. After presenting the report, always ask:
   "Would you like me to investigate any specific column
   or anomaly in more detail?"
   Then wait for Sunil's answer before doing anything else.
