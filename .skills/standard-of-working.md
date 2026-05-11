# standard-of-working.md
# SKILL: standard-of-working
# ================================================================
# HOW TO INVOKE THIS SKILL:
# This skill is NOT called manually in most cases.
# Copilot reads this file at the start of every session as
# part of the Session Start Checklist and applies these
# standards to every single output it produces.
#
# Sunil can also invoke it manually:
#   "run standard-of-working"
#   → Copilot re-reads and re-confirms these standards
#      before continuing work in the current session.
#
# WHAT THIS SKILL DOES:
# Defines the coding conventions, naming patterns, structural
# rules, communication standards, and working agreements that
# apply to every piece of work done on this project.
# This is the "how we do things here" document.
# Every output must conform to these standards before it
# is presented to Sunil for approval.
#
# This skill works alongside validation.md.
# validation.md checks WHAT was built.
# standard-of-working.md defines HOW it must be built.
# ================================================================

---

## SECTION 1 — JAVA CODING STANDARDS

### 1.1 — Class Structure
Every Java class must follow this structure in this order:
  1. Package declaration
  2. Import statements (organized: Java standard, then third-party)
  3. Class Javadoc comment (what this class does, one paragraph)
  4. Class declaration
  5. Constants (static final fields)
  6. Instance variables (private)
  7. Constructor(s)
  8. Public methods
  9. Private helper methods

No class should exceed 300 lines.
If a class exceeds 300 lines, discuss splitting it with Sunil
before proceeding.

### 1.2 — Method Structure
Every method must follow this structure:
  1. Javadoc comment (what it does, params, return, throws)
  2. Input validation at the top (null checks, empty checks)
  3. Core logic
  4. Return statement or void action
  5. Error handling in the calling method or try-catch inside

No method should exceed 40 lines.
If a method exceeds 40 lines, discuss splitting it with Sunil.

### 1.3 — Naming Conventions

Classes:
  PascalCase. Name describes what the class IS or DOES.
  Examples: ADOClient, FeatureFileParser, ReconciliationReportWriter
  Never abbreviate unless the abbreviation is industry standard
  (ADO, POM, HTML, API, XML are acceptable abbreviations).

Methods:
  camelCase. Name starts with a verb describing what it DOES.
  Examples: fetchTestCases(), parseFeatureFile(), writeMasterExcel()
  Boolean methods start with is, has, can, should.
  Examples: isTagPresent(), hasMatchingStep(), canConnect()

Variables:
  camelCase. Name describes what it HOLDS.
  Examples: testCaseId, scenarioTitle, featureFilePath
  No single-letter variables except loop counters (i, j, k).
  No abbreviations that are not obvious.
  Bad:  tc, sc, fp, adoRes
  Good: testCase, scenario, filePath, adoResponse

Constants:
  UPPER_SNAKE_CASE.
  Examples: MAX_RETRY_COUNT, DEFAULT_PAGE_SIZE, OUTPUT_FOLDER_NAME

Locator variables in Pages.java:
  [FILL IN — match the convention already in your Pages.java files]
  Common patterns: btnLogin, txtUsername, lblError, lnkForgotPassword
  Prefix indicates element type:
    btn = button
    txt = text field or text area
    lbl = label or static text
    lnk = hyperlink
    drp = dropdown
    chk = checkbox
    rad = radio button
    img = image
    tbl = table
    frm = form

### 1.4 — Comments and Documentation

Every class must have a Javadoc comment explaining:
  - What the class does
  - Which layer it belongs to (Feature/Steps/Pages/Utility)
  - Which phase it was built for

Every public method must have a Javadoc comment with:
  - @param for every parameter
  - @return for every non-void return
  - @throws for every checked exception

Inline comments:
  Use only when the code is not self-explanatory.
  Do not comment the obvious.
  Bad:  // increment i by 1
        i++;
  Good: // ADO API returns max 100 results per page.
        // Increment skip by pageSize to fetch next page.
        skip += pageSize;

### 1.5 — Error Handling Standards

All external calls must be wrapped in try-catch.
External calls include:
  - ADO REST API calls
  - File read and write operations
  - Perfecto API calls
  - DOM access during test execution
  - Database calls if any

Catch blocks must:
  1. Log the error with enough context to diagnose it
     Log format: [CLASS_NAME] [METHOD_NAME] {error description}
                 e.getMessage()
  2. Not swallow the exception silently
  3. Either rethrow, return a safe default, or alert the caller

Never catch generic Exception as the only catch block
unless it is the outermost safety net.
Prefer specific exceptions: IOException, HttpException, etc.

### 1.6 — Configuration Standards

All configurable values must live in config.properties.
Java files read config values using the established pattern.
New config keys must be:
  1. Added to config.properties with a [FILL IN] placeholder
  2. Added to the config template in ado-api-reference.instructions.md
     or framework-architecture.instructions.md as appropriate
  3. Documented with a comment in config.properties explaining
     what the key does and what format the value should be

config.properties comment format:
  # {key description} — {format or example}
  # Example: ado.masterPlanId=12345
  ado.masterPlanId=[FILL IN]

### 1.7 — Import Standards

No wildcard imports. Every import must be explicit.
Bad:  import java.util.*
Good: import java.util.List;
      import java.util.Map;
      import java.util.HashMap;

Remove all unused imports before presenting code to Sunil.

---

## SECTION 2 — FEATURE FILE STANDARDS

### 2.1 — Feature File Structure
Every feature file must follow this structure:
  1. Feature tag(s) — suite level tags like @regression @smoke
  2. Feature keyword and feature name
  3. Empty line
  4. One or more Scenarios or Scenario Outlines
  5. Each scenario has its own @tag (ADO Test Case ID) directly above it

Example structure:
  @regression @smoke
  Feature: Patient Appointment Management

  @12345 @local
  Scenario: Verify patient can view upcoming appointments
    Given the patient is logged into the portal
    When the patient navigates to the appointments section
    Then the upcoming appointments are displayed

### 2.2 — Gherkin Writing Standards

Given steps: describe the starting state or precondition.
  Good: "Given the patient is logged into the portal"
  Bad:  "Given I click login and enter username and password"
        (this is an action, not a state)

When steps: describe the action being performed.
  Good: "When the patient navigates to the appointments section"
  Bad:  "When appointments section is visible"
        (this is a state, not an action)

Then steps: describe the expected outcome.
  Good: "Then the upcoming appointments are displayed"
  Bad:  "Then I see appointments"
        (too vague — what specifically should be seen?)

And/But steps: extend the previous Given/When/Then.
  Use And to add to the same type.
  Use But to express a negative condition.

Step length: steps should be readable in one line.
  If a step needs more than 15 words, consider rewriting it.

No technical implementation language in Gherkin steps.
  Bad:  "When I find element by xpath //div[@class='appt']"
  Good: "When the patient navigates to the appointments section"

### 2.3 — Scenario Outline Standards

Use Scenario Outline when the same test logic runs with
multiple data sets.
Examples table must have meaningful column names.
Examples table values must not contain sensitive patient data.
Use generic representative values only.

### 2.4 — Tag Standards

Every scenario must have exactly these tags in this order:
  1. ADO Test Case ID tag (example: @12345)
  2. Suite tag (example: @regression or @smoke or both)
  3. Execution mode tag (@local or @perfecto)

Example: @12345 @regression @local

ADO Test Case ID tag is always first. Always.
Suite and execution mode tags follow in any order.
No custom tags without Sunil's explicit approval.

---

## SECTION 3 — FILE AND FOLDER STANDARDS

### 3.1 — File Naming
Feature files:    [FILL IN from framework-architecture.instructions.md]
Steps files:      [FILL IN from framework-architecture.instructions.md]
Pages files:      [FILL IN from framework-architecture.instructions.md]
Utility classes:  [FILL IN from framework-architecture.instructions.md]

### 3.2 — One Responsibility Per File
Each feature file covers one functional area of the application.
Each Pages.java file covers one page or module.
Each Steps.java file covers one feature file or functional area.
Do not create catch-all files that cover multiple unrelated areas.

### 3.3 — Output Files
All generated files (Excel reports, reconciliation output) go
into the output folder defined in config.properties.
Never generate output files into the source code folders.
Output files are never committed to the repository.
Add the output folder to .gitignore.

---

## SECTION 4 — COMMUNICATION AND WORKING STANDARDS

### 4.1 — How Copilot Presents Work

Every output is presented in this order:
  1. What I am about to do (plan)
  2. Wait for approval
  3. Do it
  4. Explain what was done in plain English
  5. Run validation
  6. If validation passes: "Task complete. What next?"
  7. If validation fails: list failures, wait for instruction

### 4.2 — How Copilot Asks Questions

One question at a time. Never a list of multiple questions.
If multiple things are unclear, ask the most important one first.
Wait for the answer before asking the next question.

### 4.3 — How Copilot Reports Progress

Use this format for progress updates:
  "Completed: {what was done}
   In progress: {what is being worked on now}
   Next: {what comes after this}"

### 4.4 — Language Standards

Plain English always. Technical terms explained in brackets.
Example: "I will use pagination [breaking the API call into
multiple requests of 100 items each] to fetch all 400 test cases."

No jargon without explanation.
No assumptions without stating them explicitly.
No "I think" or "probably" — if unsure, ask.

### 4.5 — When Things Go Wrong

If Copilot makes a mistake:
  1. Stop immediately when the mistake is identified
  2. State clearly what went wrong
  3. State what the impact is (what files were affected)
  4. Propose the fix
  5. Wait for Sunil's approval before fixing
  6. After fixing, re-run validation

Never minimize mistakes. Never hide them.
Never attempt to silently fix a mistake without telling Sunil.

---

## SECTION 5 — TEAM KNOWLEDGE TRANSFER STANDARDS

### 5.1 — Everything Must Be Explainable
Every piece of code, every decision, every configuration
must be explainable to a mid-level QA engineer on the team
without Sunil being present.

If Sunil cannot explain why something was built a certain way,
that is a gap in the documentation that needs to be filled.

### 5.2 — No Magic Numbers or Strings
Every number or string that has meaning must be a named constant
or a config value.
Bad:  if (results.size() == 100)
Good: if (results.size() == DEFAULT_PAGE_SIZE)

Bad:  connection.setRequestProperty("api-version", "7.0")
Good: connection.setRequestProperty("api-version", ADO_API_VERSION)

### 5.3 — Code Must Be Readable Without Comments
The code itself should be so clearly named and structured
that a team member can understand what it does by reading it,
even without comments.
Comments explain WHY, not WHAT.
If the WHAT is not clear from the code, rename the method
or variable until it is.

---

## SECTION 6 — HEALTHCARE PROJECT SPECIFIC STANDARDS

### 6.1 — Data Handling
Test data must never contain real patient information.
Use generic placeholder values in all test data.
Example:
  Bad:  patient name "John Smith", DOB "01/01/1980"
  Good: patient name "Test Patient 001", DOB "01/01/2000"

### 6.2 — Logging Standards
Logs must never contain:
  - Patient names or IDs
  - Health record information
  - Authentication tokens or passwords
  - Any personally identifiable information (PII)

Log only: timestamps, class names, method names, error messages,
HTTP status codes, file paths, test case IDs.

### 6.3 — Security Standards
PAT tokens read from config.properties only.
config.properties never committed to repository.
config.properties added to .gitignore.
A config.properties.template file with [FILL IN] placeholders
is committed instead so the team knows what keys are needed.
