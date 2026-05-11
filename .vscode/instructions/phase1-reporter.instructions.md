# phase1-reporter.instructions.md
# Attach this file in Copilot Chat when you say "start Phase 1"
# This file gives Copilot everything it needs to build the
# Post-Run Excel Reporter without asking unnecessary questions
# or making assumptions about the reporting setup.
#
# ATTACH ALONGSIDE:
#   - framework-architecture.instructions.md
#   - ado-api-reference.instructions.md
#   - excel-output-spec.instructions.md
#   - .skills/xlsx.md
#   - .skills/validation.md
#   - .skills/standard-of-working.md
#
# PREREQUISITE:
#   Phase 0 must be complete before Phase 1 is started.
#   The Reconciliation Excel from Phase 0 is used by Phase 1
#   to look up ADO titles from ADO tags.
#   If Phase 0 is not complete, Phase 1 cannot look up titles.
#   Copilot must check for the Reconciliation Excel at start.
#
# INSTRUCTIONS FOR SUNIL:
#   Before starting Phase 1, answer this question for Copilot:
#   "How is ExtentReports integrated in your framework?"
#   Options:
#     A. Cucumber JSON report → ExtentReports reads the JSON
#     B. ExtentReports EventListener hooked into Cucumber runner
#     C. Custom IReporterPlugin writing directly to ExtentReports
#   Your answer determines which parsing approach Copilot uses.
#   Copilot will ask this question at the start of Phase 1.
# ================================================================

---

## WHAT PHASE 1 BUILDS

Phase 1 builds a Post-Run Excel Reporter that:
  1. Reads test execution results after every regression or smoke run
  2. Looks up ADO titles from the Phase 0 Reconciliation Excel
  3. Generates a Run Report Excel with Pass/Fail/Skip per scenario
  4. Optionally updates ADO Test Run results via REST API
     (only when Sunil explicitly says "add ADO update")

This replaces the manual Excel update the team currently does
after every run. Zero manual effort after Phase 1 is complete.

---

## FIRST QUESTION — EXTENTREPORTS INTEGRATION

Before Copilot plans or writes anything for Phase 1, it must ask:

"Before I plan Phase 1, I need to understand how ExtentReports
is currently integrated in your framework.

Which of these matches your setup?

  A. Cucumber JSON report is generated after each run and
     ExtentReports reads that JSON to produce the HTML report.

  B. An EventListener class (implementing ConcurrentEventListener
     or EventListener) is hooked into the Cucumber runner and
     writes results directly to ExtentReports as tests run.

  C. A custom IReporterPlugin class writes test results directly
     to ExtentReports after the run completes.

  D. Something else — please describe how your HTML report
     is currently generated.

Your answer determines how I read the test results.
Please check your framework and confirm before I proceed."

Copilot waits for Sunil's answer. Does not proceed until answered.

---

## PARSING APPROACH BY INTEGRATION TYPE

### APPROACH A — Cucumber JSON
The Cucumber JSON report (cucumber.json or similar) is the
primary data source. ExtentReports reads this JSON and renders
the HTML. Phase 1 also reads this JSON directly.

JSON location: [FILL IN — confirm with Sunil where cucumber.json lands]
Typical location: target/cucumber-reports/cucumber.json
                  or target/ExtentReports/cucumber.json

JSON structure relevant fields:
{
  "elements": [
    {
      "name": "Scenario title here",
      "tags": [{"name": "@12345"}, {"name": "@regression"}],
      "steps": [
        {
          "result": {
            "status": "passed",  // passed / failed / skipped
            "error_message": "exception here if failed",
            "duration": 1234567890  // nanoseconds
          }
        }
      ]
    }
  ]
}

Status mapping:
  "passed"  → "PASS"
  "failed"  → "FAIL"
  "skipped" → "SKIP"
  "pending" → "SKIP"
  "undefined" → "SKIP" and log warning "step definition missing"

Scenario status = FAIL if ANY step has status "failed"
Scenario status = SKIP if ALL steps are skipped or pending
Scenario status = PASS only if ALL steps passed

Error message: take from the first failed step's error_message field.
Truncate to 500 characters if longer.

Duration: sum all step durations. Convert nanoseconds to seconds.
Formula: totalNanoseconds / 1_000_000_000.0

### APPROACH B — EventListener
Copilot reads the EventListener class first to understand
what data it captures and where it stores results.
Then designs the reporter to read from that data source.
Ask Sunil: "Can you point me to the EventListener class file?"

### APPROACH C — IReporterPlugin
Copilot reads the IReporterPlugin class first.
Ask Sunil: "Can you point me to the IReporterPlugin class file?"

### APPROACH D — Something else
Copilot reads whatever files Sunil identifies.
Does not proceed until the data source is confirmed.

---

## JAVA CLASS PLAN

Copilot presents this plan and waits for approval before coding.
Adjust based on the integration approach confirmed above.

CLASS 1 — RunReportMain.java
  Package:      reporter
  Responsibility: Entry point. Reads config. Orchestrates all steps.
  Methods:
    main(String[] args)
      → reads config.properties
      → calls CucumberReportParser (or appropriate parser)
      → calls ReconciliationExcelReader to load ADO title lookup
      → calls RunReportWriter to generate Excel
      → optionally calls ADORunUpdater if enabled in config
      → prints completion message with output file path

CLASS 2 — CucumberReportParser.java
  Package:      reporter
  Responsibility: Reads cucumber.json (or equivalent source)
                  and extracts scenario results.
  Methods:
    parse(String reportFilePath) → returns List<ScenarioResult>
    extractTag(JSONArray tags)   → returns primary ADO tag (String)
    extractStatus(JSONArray steps) → returns PASS/FAIL/SKIP
    extractFailureReason(JSONArray steps) → returns String
    extractDuration(JSONArray steps) → returns double seconds
    findScreenshot(String tag, String screenshotFolder)
                                 → returns String path or empty

CLASS 3 — ScenarioResult.java
  Package:      reporter
  Responsibility: Data model. One executed scenario result.
  Fields:
    String adoTag           → primary ADO tag e.g. @12345
    String scenarioTitle    → exact title from feature file
    String adoTitle         → looked up from reconciliation Excel
    String status           → PASS / FAIL / SKIP
    String failureReason    → exception + message, empty if passed
    String screenshotPath   → path or "No screenshot captured"
    double durationSeconds  → execution time
    String suite            → regression or smoke

CLASS 4 — ReconciliationExcelReader.java
  Package:      reporter
  Responsibility: Reads the Phase 0 Reconciliation Excel.
                  Builds a lookup map of ADO Tag → ADO Title.
                  Used by RunReportWriter to populate ADO Title column.
  Methods:
    load(String reconciliationFilePath)
                             → returns Map<String, String>
                               key: @tag, value: ADO Title
    readRow(Row row)         → extracts tag and title from one row

CLASS 5 — RunReportWriter.java
  Package:      reporter
  Responsibility: Takes List<ScenarioResult> and writes Run Report Excel.
                  Follows all rules from excel-output-spec.instructions.md
  Methods:
    write(List<ScenarioResult> results, String outputPath, String suiteName)
                             → creates workbook, writes both sheets,
                               saves file, returns File object
    createRunReportSheet(XSSFWorkbook wb, List<ScenarioResult> results)
                             → writes Sheet 1
    createSummarySheet(XSSFWorkbook wb, List<ScenarioResult> results,
                       String suiteName)
                             → writes Sheet 2
    createStyles(XSSFWorkbook wb)
                             → creates all styles ONCE
    sortResults(List<ScenarioResult> results)
                             → FAIL first, SKIP second, PASS last

CLASS 6 — ADORunUpdater.java
  Package:      reporter
  Responsibility: Updates ADO Test Run results via REST API.
                  ONLY built when Sunil says "add ADO update".
                  Present this class plan only after that instruction.
  Methods:
    createTestRun(String planId, String suiteId, String runName)
                             → returns runId String
    fetchTestPoints(String planId, String suiteId)
                             → returns Map<String, Integer>
                               key: testCaseId, value: testPointId
    updateResults(String runId, List<ScenarioResult> results,
                  Map<String, Integer> testPointMap)
                             → sends PATCH with all results
    completeRun(String runId)→ marks run as completed in ADO

---

## SCREENSHOT MATCHING LOGIC

When a test fails, screenshots may be captured by the framework.
Copilot must ask Sunil:
  "Where does your framework save screenshots on test failure?
   What is the naming convention for screenshot files?"

Until answered, use this default logic:
  Screenshot folder: config.getProperty("screenshot.outputPath")
  Naming pattern: look for any file containing the tag number
  Example: if tag is @12345, look for files with "12345" in the name
  If found: use relative path
  If not found: write "No screenshot captured"

---

## CUCUMBER RUNNER INTEGRATION

Phase 1 must hook into the existing test run so the reporter
runs automatically after every execution without manual steps.

Ask Sunil: "Where is your Cucumber runner class located?
           What does it currently look like?"

After reading the runner, add a post-run hook using one of:

OPTION A — Maven Surefire plugin post-test execution
  Add RunReportMain execution to Maven lifecycle in pom.xml
  after the test phase. Present the exact pom.xml change to Sunil.
  Wait for approval before modifying pom.xml.

OPTION B — Cucumber AfterAll hook in a Hooks.java class
  @AfterAll
  public static void generateRunReport() {
      RunReportMain.generate();
  }
  Check if a Hooks.java already exists before creating a new one.
  If it exists, add the method to the existing class.
  Present the change to Sunil. Wait for approval.

OPTION C — Manual trigger (simplest, safest for first version)
  RunReportMain runs as a standalone Java main method.
  Sunil runs it manually after each test execution.
  Recommended for the first iteration — validate accuracy first,
  then automate the trigger in a follow-up iteration.

Recommend Option C first. Tell Sunil:
"For the first version I recommend running the reporter manually
after each test execution so we can validate accuracy before
automating the trigger. Once you confirm the report is accurate
we can add the automatic hook. Shall we proceed with Option C first?"

---

## BUILD SEQUENCE

STEP 1 — Ask integration type question
  Wait for answer. Read relevant framework files.
  Present understanding of how results are captured. Wait for confirmation.

STEP 2 — Check Phase 0 output
  Confirm Reconciliation Excel exists in output folder.
  If missing: "Phase 0 output not found. Please run Phase 0 first
              or provide the Reconciliation Excel path."
  Wait for resolution before proceeding.

STEP 3 — Ask screenshot folder and naming convention
  Wait for answer before designing screenshot matching logic.

STEP 4 — Ask Cucumber runner location
  Read the runner file. Present current structure to Sunil.
  Recommend Option C trigger for first version.
  Wait for Sunil decision.

STEP 5 — Present full class plan
  Present all 5 classes (6 if ADO update approved).
  Wait for plan approval.

STEP 6 — Check pom.xml
  Confirm Apache POI present (should be from Phase 0).
  Confirm JSON library present (same as Phase 0).
  If any changes needed, present and wait for approval.

STEP 7 — Build classes in this order
  7a. ScenarioResult.java             (no dependencies)
  7b. ReconciliationExcelReader.java  (depends on xlsx.md patterns)
  7c. CucumberReportParser.java       (depends on ScenarioResult)
  7d. RunReportWriter.java            (depends on ScenarioResult)
  7e. RunReportMain.java              (depends on all above)
  7f. ADORunUpdater.java              (only if approved by Sunil)

  For each class: present, approve, write, explain, validate, confirm.

STEP 8 — Test with one known run
  Ask Sunil: "Please provide a recent cucumber.json output
             from a completed test run so I can test the parser."
  Parse the provided file. Show Sunil the extracted results.
  Compare against what Sunil knows the actual results were.
  Confirm accuracy before generating Excel.

STEP 9 — Generate first run report
  Run against the provided test output.
  Run data-explore on the output Excel.
  Present profile and report to Sunil.
  Wait for sign-off.

STEP 10 — Set up trigger (based on Sunil's Option choice)
  Only after accuracy is confirmed in Step 9.

---

## PHASE 1 COMPLETION CRITERIA

Phase 1 is NOT complete until ALL of these are true:
  1. Run Report Excel generated successfully with no errors
  2. Every scenario from the test run appears in the report
  3. Pass/Fail/Skip status matches the actual run exactly
  4. No FAIL row has an empty Failure Reason column
  5. ADO Title lookup works for all known tags
  6. Summary sheet present with correct statistics
  7. FAIL rows appear at the top of the report
  8. data-explore passes with no CRITICAL anomalies
  9. pr-scan passes
  10. Sunil has compared report against actual run results
      and confirmed accuracy before Phase 1 is marked complete

---

## IMPORTANT REMINDERS FOR PHASE 1

1. Do not build ADORunUpdater.java until Sunil explicitly says
   "add ADO update". This is an optional feature.
   The core reporter works without it.

2. The failure reason must never be blank for a FAIL row.
   If the JSON has no error message for a failed step,
   write "No error message captured" not an empty cell.

3. The Reconciliation Excel from Phase 0 is READ-ONLY here.
   ReconciliationExcelReader only reads it.
   Never modify the Phase 0 output from Phase 1 code.

4. Duration in cucumber.json is in nanoseconds.
   Always divide by 1,000,000,000 to get seconds.
   Always format to 2 decimal places: "12.45" not "12.456789"

5. If a scenario has no ADO tag (no @ tag found):
   Log a warning and write "NO TAG" in the ADO Tag column.
   Never skip the row. It must appear in the report.

6. This is a healthcare project.
   The failure reason column may contain error messages
   that include element text or page content.
   If that content could contain patient data,
   pr-scan will flag it. Address immediately.
