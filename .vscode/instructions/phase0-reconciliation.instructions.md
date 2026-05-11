# phase0-reconciliation.instructions.md
# Attach this file in Copilot Chat when you say "start Phase 0"
# This file gives Copilot everything it needs to build the
# Reconciliation Engine without asking unnecessary questions
# or making assumptions about the project structure.
#
# ATTACH ALONGSIDE:
#   - framework-architecture.instructions.md
#   - ado-api-reference.instructions.md
#   - excel-output-spec.instructions.md
#   - .skills/xlsx.md
#   - .skills/validation.md
#   - .skills/standard-of-working.md
#
# INSTRUCTIONS FOR SUNIL:
# Before attaching this file, complete all [FILL IN] placeholders
# in framework-architecture.instructions.md first.
# Phase 0 cannot run correctly without the folder paths.
# ================================================================

---

## WHAT PHASE 0 BUILDS

Phase 0 builds one standalone Java utility that:
  1. Scans old framework .feature files → extracts tags and titles
  2. Scans new framework .feature files → extracts tags and titles
  3. Calls ADO REST API → fetches all test cases from Master Test Plan
  4. Merges all three sources → writes master Reconciliation Excel

This utility runs independently of the test framework.
It is not a test. It is a reporting and analysis tool.
It has its own Main.java entry point and its own config.properties.

---

## JAVA CLASS PLAN

Phase 0 consists of exactly these classes.
Copilot must present this plan to Sunil and wait for approval
before writing a single line of code.

CLASS 1 — Main.java
  Package:      reconciliation
  Responsibility: Entry point. Reads config. Orchestrates all steps.
                  Calls parser classes, ADO client, and report writer
                  in the correct sequence.
  Methods:
    main(String[] args)
      → reads config.properties
      → calls FeatureFileParser for old framework
      → calls FeatureFileParser for new framework
      → calls ADOClient to fetch test cases
      → calls ReconciliationReportWriter to generate Excel
      → prints completion message with output file path

CLASS 2 — ConfigReader.java
  Package:      reconciliation
  Responsibility: Loads and provides access to config.properties values.
                  Single point of config access for all classes.
  Methods:
    getInstance()        → returns singleton ConfigReader instance
    get(String key)      → returns value for key, throws if missing
    getOrDefault(String key, String defaultValue)
                         → returns value or default if key missing

CLASS 3 — FeatureFileParser.java
  Package:      reconciliation
  Responsibility: Scans a given folder recursively for .feature files.
                  Extracts @tags and scenario titles from each file.
                  Handles all edge cases (see edge cases section below).
  Methods:
    parse(String folderPath) → returns List<FeatureScenario>
    scanFolder(File folder)  → recursive scan, returns List<File>
    parseFile(File file)     → parses one .feature file,
                               returns List<FeatureScenario>
    extractTags(String line) → extracts @tags from a tag line,
                               returns List<String>
    extractTitle(String line)→ extracts title from Scenario line,
                               returns String

CLASS 4 — FeatureScenario.java
  Package:      reconciliation
  Responsibility: Data model. Represents one scenario from a feature file.
  Fields:
    String tag            → the primary ADO tag (e.g. @12345)
    List<String> allTags  → all tags on this scenario
    String title          → exact scenario title
    String featureFilePath→ path to the .feature file
    int lineNumber        → line number in the file
    boolean isOutline     → true if Scenario Outline, false if Scenario
    String framework      → "OLD" or "NEW"

CLASS 5 — ADOClient.java
  Package:      reconciliation
  Responsibility: Calls ADO REST API to fetch all test cases from
                  Master Test Plan. Handles authentication,
                  pagination, and error responses.
  Methods:
    fetchAllTestCases()   → returns List<ADOTestCase>
    fetchPage(int skip, int top)
                          → fetches one page of results
    buildAuthHeader()     → builds Base64 encoded PAT header
    parseResponse(String json)
                          → parses JSON response into List<ADOTestCase>
    handleError(int statusCode, String body)
                          → logs error, throws appropriate exception

CLASS 6 — ADOTestCase.java
  Package:      reconciliation
  Responsibility: Data model. Represents one test case from ADO.
  Fields:
    String id             → test case ID without @ prefix (e.g. "12345")
    String tag            → test case ID with @ prefix (e.g. "@12345")
    String title          → exact test case title from ADO
    String url            → ADO URL for this test case

CLASS 7 — ReconciliationEngine.java
  Package:      reconciliation
  Responsibility: Merges old framework data, new framework data,
                  and ADO data into a unified list of reconciliation rows.
                  Applies all matching and classification logic.
  Methods:
    reconcile(List<FeatureScenario> oldFW,
              List<FeatureScenario> newFW,
              List<ADOTestCase> adoTests)
                          → returns List<ReconciliationRow>
    determineNameMatchStatus(...)  → returns String status value
    determineMigrationStatus(...)  → returns String status value
    determineSplitCaseFlag(...)    → returns String YES or NO
    determineActionNeeded(...)     → returns String action value
    detectStructuralSplits(List<FeatureScenario> scenarios)
                          → returns Map<String, List<FeatureScenario>>
                            where key = tag, value = list of scenarios
                            with that tag (only entries where size > 1)

CLASS 8 — ReconciliationRow.java
  Package:      reconciliation
  Responsibility: Data model. Represents one row in the output Excel.
  Fields:
    String adoTag
    String adoTitle
    String oldFrameworkTitle
    String newFrameworkTitle
    String nameMatchStatus
    String migrationStatus
    String splitCaseFlag
    String actionNeeded

CLASS 9 — ReconciliationReportWriter.java
  Package:      reconciliation
  Responsibility: Takes List<ReconciliationRow> and writes the
                  master Reconciliation Excel file.
                  Follows all rules from excel-output-spec.instructions.md
  Methods:
    write(List<ReconciliationRow> rows, String outputPath)
                          → creates workbook, writes both sheets,
                            saves file, returns File object
    createReconciliationSheet(XSSFWorkbook wb, List<ReconciliationRow> rows)
                          → writes Sheet 1 with header, data, colors,
                            ordering, freeze pane, auto filter
    createSummarySheet(XSSFWorkbook wb, List<ReconciliationRow> rows)
                          → writes Sheet 2 with all statistics
    createStyles(XSSFWorkbook wb)
                          → creates all styles ONCE, returns StyleMap
    getRowColor(ReconciliationRow row)
                          → returns byte[] color per color coding rules
    sortRows(List<ReconciliationRow> rows)
                          → sorts by color priority then ADO tag number

---

## RECONCILIATION LOGIC RULES

### Matching Rules

Rule 1 — Tag Normalization
  Before any comparison, normalize all tags:
  Strip leading @ if present for numeric comparison.
  Always store with @ prefix in output.
  Comparison: "12345" == "12345" (strip @ for compare, add back for store)

Rule 2 — Title Comparison
  Title comparison is CASE-INSENSITIVE and TRIM-WHITESPACE.
  "Verify Patient Login" == "verify patient login" == "Verify Patient Login  "
  Do not fail a match because of case or trailing spaces.

Rule 3 — Name Match Status Logic
  if tag exists in old FW AND new FW AND ADO:
    if all three titles match (case-insensitive): "EXACT MATCH"
    else: "NAME MISMATCH"
  if tag exists in old FW AND ADO but NOT in new FW:
    "NOT MIGRATED"
  if tag exists in old FW with 2+ scenarios having same tag:
    "STRUCTURAL SPLIT"
    (overrides all other statuses for that tag)
  if tag exists in ADO but NOT in old FW:
    "NOT IN OLD FW"

Rule 4 — Migration Status Logic
  if tag found in new FW: "MIGRATED"
  if tag NOT found in new FW: "NOT MIGRATED"
  "PARTIAL" is set manually by Sunil — never auto-assigned

Rule 5 — Split Case Detection
  if same @tag appears on 2+ scenarios in old framework: "YES"
  else: "NO"
  When split detected: create one row per ADO tag (not per scenario)
  The row represents the tag, not individual scenarios
  oldFrameworkTitle for split rows: list all titles separated by " | "
  Example: "Patient Login @smoke | Patient Login @regression"

Rule 6 — Action Needed Logic
  if migrationStatus = "MIGRATED" AND nameMatchStatus = "EXACT MATCH":
    "NONE"
  if migrationStatus = "MIGRATED" AND nameMatchStatus = "NAME MISMATCH":
    "UPDATE TITLE"
  if migrationStatus = "NOT MIGRATED" AND splitCaseFlag = "NO":
    "MIGRATE"
  if splitCaseFlag = "YES":
    "REVIEW SPLIT"
  if nameMatchStatus = "NOT IN OLD FW":
    "VERIFY"

---

## FEATURE FILE PARSING EDGE CASES

Copilot must handle ALL of these. Never skip or assume they
do not exist until the actual files are read.

EDGE CASE 1 — Multiple tags on one line
  @12345 @regression @local @smoke
  Extract all tags. Primary tag = first numeric-looking tag.
  Non-numeric tags (@regression, @local, @smoke) are suite/mode tags.
  ADO tag is the numeric one: @12345

EDGE CASE 2 — Tag on separate line from Scenario
  @12345
  @regression
  Scenario: Patient logs in
  Tags may be split across multiple lines above a Scenario.
  Collect all tag lines immediately preceding the Scenario line.

EDGE CASE 3 — Scenario Outline
  @12345
  Scenario Outline: Patient logs in with <role>
  This is a valid scenario. isOutline = true.
  Title extraction: take everything after "Scenario Outline:" and trim.

EDGE CASE 4 — Background steps
  Background:
    Given the application is running
  Background blocks have no @tag. Skip them entirely.
  Do not treat Background steps as scenarios.

EDGE CASE 5 — Comments
  # This is a comment
  Lines starting with # are comments. Skip entirely.
  Do not extract tags or titles from comment lines.

EDGE CASE 6 — Empty feature files
  Files with no Scenario or Scenario Outline declarations.
  Log a warning: "Empty feature file found: {path}"
  Include in output with title "EMPTY FEATURE FILE"

EDGE CASE 7 — Scenario with no @tag
  Scenario: Patient logs in
  (no @ tag line above it)
  Log a warning: "Scenario with no tag found: {title} in {file}"
  Skip this scenario — it cannot be mapped to ADO.

EDGE CASE 8 — Same tag in multiple feature files
  This is a STRUCTURAL SPLIT if in old framework.
  Record both occurrences with their file paths.

EDGE CASE 9 — Feature-level tags
  @regression
  Feature: Patient Management
  Feature-level tags apply to ALL scenarios in the file.
  Do not treat feature-level tags as ADO Test Case ID tags.
  Feature-level tags are suite tags, not ADO IDs.
  ADO ID tags appear directly above individual Scenario lines.

EDGE CASE 10 — Examples table in Scenario Outline
  Scenario Outline: Login with <user>
    Examples:
      | user     | password |
      | patient1 | pass1    |
  Treat the entire Scenario Outline as one scenario.
  Do not create one row per Examples table row.

---

## BUILD SEQUENCE

When Sunil says "start Phase 0", Copilot follows this exact sequence.
Present each step to Sunil. Wait for approval. Then execute.
Never skip a step. Never combine steps.

STEP 1 — Read and confirm project structure
  Read actual folder structure of both frameworks.
  Present findings. Wait for Sunil to confirm paths are correct.

STEP 2 — Present class plan
  Present the 9-class plan from the CLASS PLAN section above.
  One class at a time. Wait for approval of the full plan.

STEP 3 — Show config.properties template
  Show exactly what keys Phase 0 needs:
    reconciliation.oldFrameworkPath=[FILL IN]
    reconciliation.newFrameworkPath=[FILL IN]
    ado.org=https://dev.azure.com/MCLM
    ado.project=[FILL IN]
    ado.masterPlanId=[FILL IN]
    ado.masterSuiteId=[FILL IN]
    ado.pat=[FILL IN]
    report.outputPath=[FILL IN]
  Wait for Sunil to confirm values before proceeding.

STEP 4 — Check pom.xml
  Confirm these dependencies are present:
    Apache POI poi-ooxml (for Excel generation)
    A JSON library (org.json or Jackson or Gson)
    Java standard library (no extra dep needed for HTTP)
  If any missing, present the dependency XML and wait for approval.

STEP 5 — Build classes in this order
  5a. FeatureScenario.java        (data model — no dependencies)
  5b. ADOTestCase.java            (data model — no dependencies)
  5c. ReconciliationRow.java      (data model — no dependencies)
  5d. ConfigReader.java           (utility — no project dependencies)
  5e. FeatureFileParser.java      (depends on FeatureScenario)
  5f. ADOClient.java              (depends on ADOTestCase, ConfigReader)
  5g. ReconciliationEngine.java   (depends on all three data models)
  5h. ReconciliationReportWriter.java (depends on ReconciliationRow)
  5i. Main.java                   (depends on all classes)

  For each class:
    Present class name, responsibility, and method signatures.
    Wait for approval.
    Write complete code.
    Explain code in plain English section by section.
    Run validation.
    Wait for Sunil confirmation before next class.

STEP 6 — Test with a small batch first
  Before running against all 400 scripts:
  Set a test limit in config: reconciliation.testLimit=10
  Run against first 10 ADO test cases only.
  Review output Excel with Sunil.
  Confirm data looks correct.
  Only after Sunil confirms accuracy: remove limit and run full.

STEP 7 — Full run
  Run against all 400 test cases.
  Present output file path.
  Run data-explore on the output.
  Present profile report to Sunil.
  Wait for Sunil sign-off before marking Phase 0 complete.

---

## PHASE 0 COMPLETION CRITERIA

Phase 0 is NOT complete until ALL of these are true:
  1. Excel file generated successfully with no errors
  2. Row count in Excel matches ADO test case count from API
  3. No duplicate ADO tags in the Excel
  4. All 8 columns present and populated correctly
  5. Color coding applied correctly per color rules
  6. Both sheets present (Reconciliation and Summary)
  7. Summary statistics calculated correctly
  8. data-explore passes with no CRITICAL anomalies
  9. pr-scan passes
  10. Sunil has reviewed and verbally confirmed the output
      looks correct before Phase 0 is marked complete

---

## IMPORTANT REMINDERS FOR PHASE 0

1. This is a READ-ONLY phase for the frameworks.
   FeatureFileParser reads files. It never modifies them.
   ADOClient reads ADO. It never writes to ADO.
   The only file created is the output Excel.

2. The test limit in Step 6 must be removed before the full run.
   Never leave a hard limit in production code.

3. If the ADO API returns fewer test cases than expected,
   do not silently continue. Stop and alert Sunil.
   The count from the API must match the known total of ~400.

4. If a feature file cannot be read (permissions, encoding, etc.),
   log the error and continue with the remaining files.
   Never let one bad file stop the entire run.
   List all skipped files in the Summary sheet.

5. PAT token must come from config.properties.
   Never hardcode. Never log. Never print.
