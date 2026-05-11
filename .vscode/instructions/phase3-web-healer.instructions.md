# phase3-web-healer.instructions.md
# Attach this file in Copilot Chat when you say "start Phase 3"
# This file gives Copilot everything it needs to build the
# Web Locator Auto-Healer for locally run web tests.
#
# ATTACH ALONGSIDE:
#   - framework-architecture.instructions.md
#   - .skills/validation.md
#   - .skills/standard-of-working.md
#
# PREREQUISITES:
#   Phase 2 must be substantially complete before Phase 3.
#   Auto-healing locators in an incomplete framework means
#   healing locators that may change again during migration.
#   Phase 3 is most effective when the framework is stable.
#
# INSTRUCTIONS FOR SUNIL:
#   Before starting Phase 3, answer these questions for Copilot:
#   Q1: How are test failures currently captured in your framework?
#       (try-catch in Pages.java, Cucumber @After hook,
#        TestNG listener, or something else)
#   Q2: At the point of failure, is the browser still open
#       and accessible, or is it already closed?
#   Q3: Do you currently capture the page DOM anywhere on failure?
#       (screenshot only, or also page source)
#   Copilot will ask these questions at the start of Phase 3.
# ================================================================

---

## WHAT PHASE 3 BUILDS

Phase 3 builds a Web Locator Auto-Healer that:
  1. Detects when a test fails due to a locator not found error
  2. Captures the current page DOM at the point of failure
  3. Sends the failed locator + DOM to Claude API
  4. Claude suggests a corrected XPath
  5. Presents the old locator and new locator to Sunil side by side
  6. Writes the fix to Pages.java ONLY after Sunil approves
  7. Never touches Steps.java or .feature files

This reduces manual locator maintenance effort significantly.
The human-in-the-loop approval step ensures no silent false passes.

---

## FIRST QUESTIONS — MUST BE ANSWERED BEFORE PLANNING

Before Copilot plans or writes anything for Phase 3, it asks:

"Before I plan Phase 3, I need to understand how your framework
currently handles test failures.

Q1: When a test fails due to NoSuchElementException or similar,
    how is that currently handled?
    A. try-catch inside the Pages.java method
    B. Cucumber @After hook that checks scenario status
    C. TestNG ITestListener or similar listener
    D. Something else — please describe

Q2: At the point of failure, is the WebDriver instance still
    open and accessible, or has it already been closed?

Q3: Does your framework currently capture the page source
    (driver.getPageSource()) on failure, or only screenshots?

Q4: Where is the WebDriver instance managed?
    (driver factory class, base class, thread-local, other)

Your answers determine the architecture of the healer.
Please check your framework and answer before I proceed."

Copilot waits for all four answers before planning anything.

---

## ARCHITECTURE OVERVIEW

The healer has two operating modes based on Sunil's answers:

### MODE A — Proactive (Cucumber @After hook)
If the framework uses Cucumber hooks, the healer runs after
each failed scenario automatically:
  @After
  public void healLocatorsIfFailed(Scenario scenario) {
      if (scenario.isFailed()) {
          LocatorHealingService.analyzeFailure(scenario, driver);
      }
  }

### MODE B — Reactive (Post-run analysis)
If the framework does not easily support hooks, the healer
runs as a standalone utility after the test run:
  - Reads the ExtentReport HTML or cucumber.json for failures
  - For each failure: loads the DOM snapshot if available
  - Sends to Claude API for analysis
  - Presents fixes for approval

Recommend Mode A if hooks are available.
It captures live DOM which is more accurate than stored snapshots.
Tell Sunil which mode fits and wait for approval before building.

---

## JAVA CLASS PLAN

Present this plan and wait for approval before coding.
Adjust based on answers to the four questions above.

CLASS 1 — LocatorHealingService.java
  Package:      healer
  Responsibility: Orchestrates the healing workflow for one failure.
                  Entry point called by the hook or standalone runner.
  Methods:
    analyzeFailure(Scenario scenario, WebDriver driver)
                          → captures DOM, finds failed locator,
                            calls ClaudeApiClient, presents fix
    captureDOM(WebDriver driver)
                          → returns String (full page source HTML)
    findFailedLocator(Scenario scenario)
                          → extracts failed locator from error message
                            returns FailedLocator object
    presentFix(FailedLocator old, String suggested, String filePath)
                          → writes comparison to console and log file
                            waits for Sunil approval (interactive mode^)
                            OR writes to pending-fixes.json (batch mode^)

CLASS 2 — FailedLocator.java
  Package:      healer
  Responsibility: Data model. Represents a locator that failed.
  Fields:
    String strategy       → "xpath" / "id" / "css" / "name" etc.
    String value          → the actual locator string that failed
    String variableName   → the variable name in Pages.java
    String className      → the Pages.java class name
    String filePath       → full path to the Pages.java file
    int lineNumber        → line number of the locator in Pages.java
    String errorMessage   → the full exception message

CLASS 3 — ClaudeApiClient.java
  Package:      healer
  Responsibility: Sends failed locator and DOM to Claude API.
                  Returns suggested corrected XPath.
  Methods:
    suggestFix(FailedLocator locator, String domContent)
                          → returns String suggested XPath
    buildPrompt(FailedLocator locator, String domContent)
                          → builds the structured prompt for Claude
    callAPI(String prompt)→ calls Claude API, returns response text
    extractXPath(String response)
                          → parses Claude response, returns clean XPath

CLASS 4 — LocatorFinder.java
  Package:      healer
  Responsibility: Searches Pages.java files to find the exact
                  variable declaration for a failed locator value.
                  Maps from error message to source file location.
  Methods:
    findLocatorInProject(String locatorValue, String pagesFolder)
                          → returns FailedLocator with file and line
    searchFile(File pagesFile, String locatorValue)
                          → searches one file, returns match or null
    extractVariableName(String line)
                          → parses the variable name from a locator line

CLASS 5 — PagesFileUpdater.java
  Package:      healer
  Responsibility: Updates the locator value in a Pages.java file.
                  Only modifies the specific locator variable.
                  Never touches any other line in the file.
  Methods:
    updateLocator(FailedLocator old, String newValue)
                          → reads file, finds exact line,
                            replaces old value with new value,
                            writes file back
    validateUpdate(File file, String variableName, String newValue)
                          → reads file after update,
                            confirms new value is present,
                            confirms no other lines changed

CLASS 6 — HealingReport.java
  Package:      healer
  Responsibility: Tracks all healing suggestions across a run.
                  Writes a healing report showing what was suggested,
                  what was approved, and what was rejected.
  Methods:
    recordSuggestion(FailedLocator old, String suggested, String status)
    writeReport(String outputPath)
                          → writes healing-report.xlsx or .txt

CLASS 7 — HealerMain.java (for Mode B — standalone^)
  Package:      healer
  Responsibility: Entry point for standalone/reactive mode.
                  Reads failure data, runs healing workflow.
  Methods:
    main(String[] args)

---

## CLAUDE API PROMPT TEMPLATE

This is the exact prompt structure Copilot uses when calling
Claude API for XPath suggestions. Never change this structure
without Sunil's approval.

SYSTEM PROMPT:
"You are an expert Selenium test automation engineer specializing
in XPath locator repair. You are given a failed XPath locator
and the current DOM of the page. Your job is to suggest the
most reliable corrected XPath that will locate the same element.

Rules for your suggestion:
1. Prefer ID-based XPath if an id attribute is available
2. Prefer stable attributes (data-testid, aria-label, name, type)
   over positional XPaths
3. Avoid XPaths that depend on element position (//div[3])
4. Avoid XPaths that depend on dynamic class names
5. Return ONLY the corrected XPath string. Nothing else.
6. Do not include explanation. Do not include code.
   Just the XPath string itself.
Example response: //button[@data-testid='submit-button']"

USER PROMPT:
"Failed locator:
Strategy: {locator.strategy}
Value: {locator.value}
Variable name: {locator.variableName}
Error: {locator.errorMessage}

Current page DOM (relevant section):
{first 50000 characters of DOM around the failed element area}

Suggest a corrected XPath for this element."

DOM TRUNCATION RULE:
Full page DOM can be very large. Send maximum 50000 characters.
If DOM is larger: extract the section most likely to contain
the failed element using the element identifier as a hint.

RESPONSE HANDLING:
If Claude returns a valid XPath starting with //: use it.
If Claude returns multiple options: take the first one.
If Claude returns "Cannot determine": log and skip this locator.
  Do not present a failed suggestion to Sunil.
If API call fails: log the error, skip this locator.
  Never let a failed API call stop the test run.

---

## LOCATOR FINDER LOGIC

When a test fails with NoSuchElementException, the error message
typically contains the locator value like:
  "Unable to locate element: {"method":"xpath","selector":"//button[@id='old-id']"}"
  OR
  "no such element: Unable to locate element: By.xpath: //button[@id='old-id']"

LocatorFinder.java must:

STEP 1: Parse the error message to extract the locator value
  Look for patterns:
    "selector":"(.*?)"
    By.xpath: (.*?)(\n|$)
    By.id: (.*?)(\n|$)
    By.cssSelector: (.*?)(\n|$)
  Extract the value between the quotes or after "By.xxx: "

STEP 2: Search all Pages.java files for this value
  Open each Pages.java file in the pages folder.
  Search for lines containing:
    By.xpath("{value}")
    By.id("{value}")
    By.cssSelector("{value}")
    By.name("{value}")
  Return the first match with file path and line number.

STEP 3: Extract the variable name
  Parse the line to get the variable name:
  Pattern: private By {variableName} = By.{strategy}("{value}");
  Extract: variableName

STEP 4: Confirm with Copilot
  "I found the failed locator:
   Variable: {variableName}
   In file:  {filePath}
   Line:     {lineNumber}
   Value:    {value}
   Is this correct?"
  Wait for Sunil to confirm before proceeding.

---

## PAGES.JAVA UPDATE RULES

These rules protect the integrity of Pages.java files.

RULE 1 — Show side by side before touching any file
  Always present this comparison to Sunil:

  "Proposed locator fix:
   ================================================
   Variable:    {variableName}
   File:        {filePath}
   Line:        {lineNumber}

   OLD VALUE:   {old locator strategy and value}
   NEW VALUE:   {new locator strategy and value}
   ================================================
   Confidence:  {HIGH if stable attribute used, MEDIUM if xpath}
   Reason:      {brief explanation from Claude response}

   Approve this fix? (yes / no / skip)"

RULE 2 — Only change the specific locator line
  The update reads the file line by line.
  Only the line containing the failed locator variable is changed.
  Every other line is written back exactly as read.
  No reformatting. No whitespace changes. No comment changes.

RULE 3 — Validate after update
  After writing the file:
  Read it back and confirm:
    The new value is present on the expected line.
    The old value is no longer present.
    The total line count matches the original.
  If validation fails: restore the original file immediately.
  Alert Sunil: "File update validation failed. Original restored."

RULE 4 — Keep original as backup
  Before modifying any file, create a backup:
  {filePath}.bak
  If Sunil rejects the fix after it was written: restore from backup.
  Delete backup after Sunil confirms fix is correct.

RULE 5 — One locator at a time
  Never update multiple locators in the same file in one operation.
  Update one. Present result. Get confirmation. Then next.

---

## APPROVAL WORKFLOW

Phase 3 has two approval modes:

### INTERACTIVE MODE (recommended for first runs)
After each fix suggestion:
  Copilot presents the side-by-side comparison.
  Sunil types: "yes" (approve), "no" (reject), or "skip" (defer).
  If yes: update is written, backup created, validation run.
  If no: locator is skipped, logged as REJECTED in healing report.
  If skip: added to pending list, reviewed later.

### BATCH REVIEW MODE (after trust is established)
  All suggestions written to pending-fixes.json first.
  Sunil reviews the JSON file.
  Sunil marks each fix: APPROVE / REJECT / SKIP.
  Copilot processes all APPROVE fixes.
  Never process REJECT or SKIP fixes automatically.

Start with Interactive Mode. Only move to Batch Review Mode
after Sunil explicitly says "use batch mode for healer".

---

## BUILD SEQUENCE

STEP 1: Ask all four questions. Read relevant framework files.
        Present understanding of failure handling. Confirm with Sunil.

STEP 2: Determine operating mode (A or B).
        Present recommendation. Wait for approval.

STEP 3: Present full class plan. Wait for approval.

STEP 4: Check pom.xml
        Phase 3 needs:
          - Apache HttpClient OR java.net.HttpURLConnection for Claude API
          - JSON library (already from Phase 0^)
        If new dependency needed, present and wait for approval.

STEP 5: Build classes in this order:
  5a. FailedLocator.java          (no dependencies^)
  5b. LocatorFinder.java          (depends on FailedLocator^)
  5c. ClaudeApiClient.java        (depends on FailedLocator^)
  5d. PagesFileUpdater.java       (depends on FailedLocator^)
  5e. HealingReport.java          (depends on FailedLocator^)
  5f. LocatorHealingService.java  (depends on all above^)
  5g. HealerMain.java             (Mode B only, depends on all^)

STEP 6: Test with one known failure
  Ask Sunil: "Please run one test that you know will fail
             due to a broken locator so I can test the healer."
  Walk through the full healing workflow for that one failure.
  Confirm each step works correctly before proceeding.

STEP 7: Test with a small batch
  Run against 5 known locator failures.
  Review all suggestions with Sunil.
  Confirm accuracy rate before using on full regression.

---

## PHASE 3 COMPLETION CRITERIA

Phase 3 is NOT complete until ALL of these are true:
  1. Healer correctly detects NoSuchElementException failures
  2. DOM capture works and returns useful content
  3. Claude API returns valid XPath suggestions
  4. Side-by-side comparison is clear and readable
  5. Pages.java update changes only the target locator line
  6. Backup and restore mechanism works correctly
  7. Healing report generated after each run
  8. pr-scan passes on all modified Pages.java files
  9. Sunil has approved at least 5 fixes and confirmed
     the updated locators work in subsequent test runs

---

## IMPORTANT REMINDERS FOR PHASE 3

1. Phase 3 ONLY touches Pages.java files. Never Steps.java.
   Never .feature files. Never any other file type.

2. The Claude API key is handled by the environment.
   Never hardcode it. Read from config.properties:
   claude.api.url=https://api.anthropic.com/v1/messages
   claude.model=claude-sonnet-4-20250514
   Never log the API key. Never print it.

3. If Claude cannot suggest a fix for a locator, that is fine.
   Log it and move on. The healer improves the situation
   but does not need to fix every single locator.

4. A fix that passes Copilot's check but fails at runtime
   is worse than no fix. This is why Sunil manually approves
   every fix and verifies the test passes after the update.

5. This is a healthcare project.
   Page DOM content may contain patient data visible on screen.
   DOM sent to Claude API is sent externally.
   Before sending DOM to Claude:
     Strip any content that could contain patient data.
     Specifically remove: text content of input fields,
     displayed values in labels, table cell text.
     Keep only: element tags, attributes, structure.
   This is non-negotiable.

6. Always check if ZScaler allows outbound calls to
   api.anthropic.com before building ClaudeApiClient.
   Ask Sunil: "Is api.anthropic.com whitelisted in ZScaler?"
   If not whitelisted: Phase 3 cannot proceed until it is.
   Do not attempt workarounds for the ZScaler restriction.
