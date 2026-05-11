@echo off
REM ============================================================
REM MC Project — Copilot Workspace Setup Script
REM Built by: Sunil Sagar
REM Run this file from your project root folder.
REM Double-click to execute. It will create the entire folder
REM structure and all files in the correct locations.
REM ============================================================

echo.
echo ============================================================
echo  MC Project — Copilot Workspace Setup
echo  Building folder structure and files...
echo ============================================================
echo.

REM ------------------------------------------------------------
REM CREATE FOLDER STRUCTURE
REM ------------------------------------------------------------

if not exist ".github" mkdir .github
if not exist ".vscode" mkdir .vscode
if not exist ".vscode\instructions" mkdir .vscode\instructions
if not exist ".project" mkdir .project
if not exist ".skills" mkdir .skills

echo [OK] Folder structure created.
echo.

REM ------------------------------------------------------------
REM FILE 1 — .project\knowledge.md
REM ------------------------------------------------------------

echo Creating .project\knowledge.md...

(
echo # knowledge.md
echo # Project Knowledge Base — Copilot Context File
echo # This file is read by GitHub Copilot at the start of every session.
echo # It gives Copilot the business context, team context, environment
echo # constraints, and project goals it needs to give relevant suggestions.
echo # Never delete this file. Update it when anything changes.
echo.
echo ---
echo.
echo ## WHO I AM
echo.
echo - Name: Sunil Sagar
echo - Role: Automation ^& Performance Tester
echo - I am the sole builder of this automation system.
echo - The entire team of 5 QA Engineers and 1 Lead will use what I build.
echo - I am responsible for KT ^(Knowledge Transfer^) to the team on how to
echo   use this system and how to interact with the Copilot agent correctly.
echo.
echo ---
echo.
echo ## THE CLIENT
echo.
echo - Client codename: MC
echo - Domain: Healthcare
echo - Application type: Web application and Mobile application ^(iOS and Android^)
echo - What the application does: A patient-facing healthcare portal where
echo   patients can log in to check messages from their care team, view
echo   test results, create and manage appointments, and track their
echo   personal health records.
echo - Primary end users: Patients ^(members of the public using the portal
echo   to manage their own healthcare^)
echo.
echo ---
echo.
echo ## THE TEAM
echo.
echo - 5 QA Engineers
echo - 1 QA Lead
echo - Total: 6 members
echo - All team members are expected to use the automation framework and
echo   interact with the Copilot agent after KT is completed.
echo - Not all team members are comfortable with Python. The entire team
echo   works in Java. All tooling and automation must be in Java only.
echo.
echo ---
echo.
echo ## THE PROJECT
echo.
echo - Internal name: Old Framework to New Framework migration project
echo - Old Framework: Built on Quantum + Perfecto
echo   - Tests web and mobile applications using Perfecto driver
echo   - Web instances and mobile instances run inside Perfecto lab
echo   - Mobile devices are real physical devices inside the Perfecto lab
echo   - Running tests locally was not possible in this framework
echo   - Test execution was Perfecto-only for both web and mobile
echo - New Framework: Built on Java + Selenium + BDD Cucumber
echo   - Supports both Perfecto execution and local execution
echo   - Execution mode is controlled by tags: @local or @perfecto
echo   - Follows a strict three-layer architecture:
echo     Layer 1 - .feature files written in Gherkin language
echo     Layer 2 - Steps.java files ^(step definitions, no Selenium logic^)
echo     Layer 3 - Pages.java files ^(POM, all Selenium actions, all locators^)
echo   - There is no separate shared library folder. Step reuse happens
echo     organically. Same Gherkin sentence in any feature file
echo     automatically maps to the same Steps.java method via Cucumber.
echo   - Creating duplicate step definitions will cause
echo     AmbiguousStepDefinitionsException and break the entire suite.
echo.
echo ---
echo.
echo ## THE PROBLEM WE ARE SOLVING
echo.
echo 1. Dual framework maintenance burden
echo    Running regression and maintenance in both Old and New Framework
echo    simultaneously is doubling the team workload.
echo.
echo 2. ADO title mismatch
echo    Scenario outline titles in the Old Framework do not match the
echo    test case titles in Azure DevOps ^(ADO^). The team manually searches
echo    by @tag to reconcile them, which is slow and error-prone.
echo.
echo 3. Manual Excel reporting
echo    After every regression or smoke suite run, the team manually
echo    updates an Excel file with Pass/Fail results. This must be
echo    automated so the Excel updates itself from the HTML report output.
echo.
echo 4. Locator breakage
echo    When XPath locators break on web ^(local^) or mobile ^(Perfecto^),
echo    the team manually finds and fixes them in Pages.java files.
echo    This maintenance effort must be reduced significantly.
echo.
echo 5. Migration backlog
echo    Approximately 400 scripts exist in the Old Framework.
echo    All 400 must be migrated to the New Framework before the
echo    Old Framework can be sunset.
echo    30 percent are clean migrations ^(title mismatch only, same logic^).
echo    70 percent are structural splits ^(1 old script maps to 2 or more
echo    ADO test cases and must become 2 or more scenarios^).
echo.
echo ---
echo.
echo ## THE ULTIMATE GOAL
echo.
echo - Migrate all 400 scripts from Old Framework to New Framework
echo - Sunset the Old Framework completely
echo - Reduce ongoing maintenance effort to near zero
echo - Automate Excel Pass/Fail updates directly from HTML test reports
echo - When a test fails, the system captures it and updates the
echo   Excel file automatically without manual intervention
echo - The team works from a single framework only, with a single
echo   source of truth for test results
echo.
echo ---
echo.
echo ## AZURE DEVOPS ^(ADO^) SETUP
echo.
echo - ADO is the test management tool
echo - Organization URL: https://dev.azure.com/MCLM
echo - @tags in feature files map 1:1 with ADO Test Case IDs
echo   ^(tags were taken directly from ADO, not custom-created^)
echo - ADO structure:
echo   Master Test Plan ^(source of truth, all test cases live here^)
echo   Query-based suite inside Master Test Plan
echo   Per-release Test Plan ^(cloned from Master for each release^)
echo   Per-release Test Plan is what is executed during regression
echo - ADO API access: Read and Write access via PAT ^(Personal Access Token^)
echo - PAT must never be hardcoded. Always read from config.properties.
echo - ADO also contains a Wiki with guidelines on how to write test cases,
echo   use shared steps, and structure test suites.
echo.
echo ---
echo.
echo ## TOOLS AND ACCESS
echo.
echo - Azure DevOps ^(ADO^): Full access, read and write via PAT
echo   This is the ONLY project management and test management tool
echo   used on this project. JIRA and Figma are used on other projects
echo   but are NOT used here. Do not suggest JIRA or Figma integrations.
echo - Perfecto Lab: Access for mobile and web test execution
echo   - Real physical mobile devices
echo   - Post-session DOM snapshots and recordings accessible
echo   - Mobile locators are typically XPath based
echo - GitHub Copilot: Available in VS Code with Claude Sonnet and Opus
echo - ZScaler: Internet access is filtered through ZScaler
echo   - Only whitelisted URLs are accessible
echo   - Cannot access arbitrary external URLs or install tools freely
echo.
echo ---
echo.
echo ## ENVIRONMENT CONSTRAINTS
echo.
echo 1. Cannot install new tools, libraries, or dependencies without
echo    explicit client approval. Always check pom.xml before suggesting
echo    any new dependency. If a dependency is missing, flag it and
echo    wait for approval before adding it.
echo.
echo 2. No direct internet access. All external calls go through ZScaler.
echo    Only whitelisted URLs are reachable. Do not suggest solutions
echo    that require downloading tools or hitting non-whitelisted endpoints.
echo.
echo 3. Client approves all changes. Nothing goes to the repository
echo    without client sign-off. Never auto-commit, never auto-push.
echo    Always present changes for review first.
echo.
echo 4. All code must be in Java. No Python, no Node.js, no shell scripts
echo    in the framework itself. Utility scripts for one-time tasks may
echo    use batch ^(.bat^) files for Windows only.
echo.
echo 5. The team is not all at the same technical level. All code,
echo    explanations, and documentation must be written clearly enough
echo    for a mid-level QA engineer to understand and maintain.
echo.
echo ---
echo.
echo ## REPORTING SETUP
echo.
echo - Current report type: ExtentReports HTML
echo - After every run, an HTML report is generated
echo - The team currently manually updates an Excel file with Pass/Fail
echo   based on the HTML report. This must be automated.
echo - The Excel file tracks: ADO Tag, ADO Title, Scenario Title, Pass/Fail
echo - Target: Excel updates itself automatically after every run
echo   without any manual intervention from the team
echo.
echo ---
echo.
echo ## PROJECT PHASES
echo.
echo PHASE 0 - Reconciliation Engine
echo   Builds a master Excel mapping ADO titles, Old Framework titles,
echo   and New Framework titles. Flags mismatches and migration gaps.
echo.
echo PHASE 1 - Post-Run Excel Reporter
echo   Hooks into the Cucumber + ExtentReports pipeline to auto-generate
echo   a Pass/Fail Excel after every regression or smoke suite run.
echo.
echo PHASE 2 - AI-Assisted Migration Engine
echo   Uses Claude AI via GitHub Copilot to migrate Old Framework
echo   feature files to New Framework BDD Cucumber format.
echo.
echo PHASE 3 - Web Locator Auto-Healer
echo   Detects broken XPath locators on local web runs, suggests fixes
echo   using AI + DOM analysis, presents fixes for human approval.
echo.
echo PHASE 4 - Perfecto Mobile Locator Healer
echo   Same as Phase 3 but for Perfecto mobile devices using post-session
echo   DOM snapshots. Human-in-the-loop review mandatory for every fix.
echo.
echo ---
echo.
echo ## SKILLS AVAILABLE IN THIS PROJECT
echo.
echo - end-session     - daily shutdown ritual
echo - wrap-session    - aggregates session into daily log
echo - project-log     - appends timestamped entry to devlog.md
echo - session-end     - handoff note + dev log + ADO push prompt
echo - validation      - checks every output against defined rules
echo - standard-of-working - coding conventions and naming patterns
echo - pr-scan         - privacy review checklist before code ships
echo - data-explore    - profiles new datasets automatically
echo - create-doc      - generates documentation from project files
echo.
echo ---
echo.
echo ## CRITICAL REMINDERS FOR COPILOT
echo.
echo 1. This is a HEALTHCARE project. Patient data privacy is non-negotiable.
echo    Never suggest storing, logging, or exposing any patient-related data.
echo    The pr-scan skill must be run before any code ships.
echo.
echo 2. The @tags in feature files are ADO Test Case IDs. They are sacred.
echo    Never change, remove, or rename a @tag without explicit instruction.
echo.
echo 3. There is no shared library folder. Reuse happens via matching
echo    Gherkin sentences. Always search all Steps.java files before
echo    creating any new step definition.
echo.
echo 4. Never auto-commit, never auto-push, never overwrite files silently.
echo    Every change must be presented and approved by Sunil first.
echo.
echo 5. When in doubt, stop and ask. Slow and correct is better than
echo    fast and broken.
) > .project\knowledge.md

echo [OK] .project\knowledge.md created.
echo.

REM ------------------------------------------------------------
REM FILE 2 — .vscode\instructions\framework-architecture.instructions.md
REM ------------------------------------------------------------

echo Creating .vscode\instructions\framework-architecture.instructions.md...

(
echo # framework-architecture.instructions.md
echo # Attach this file in Copilot Chat at the start of every phase.
echo # INSTRUCTIONS FOR SUNIL: Every section marked with [FILL IN]
echo # means you need to replace the placeholder with the actual value
echo # from your project before attaching this file to any session.
echo.
echo ---
echo.
echo ## WORKSPACE OVERVIEW
echo.
echo This workspace contains TWO separate frameworks.
echo Copilot must always know which framework it is reading or modifying.
echo Never mix files from Old Framework into New Framework.
echo.
echo Old Framework root folder: [FILL IN]
echo New Framework root folder: [FILL IN]
echo.
echo ---
echo.
echo ## OLD FRAMEWORK - FOLDER STRUCTURE
echo.
echo Features folder:      [FILL IN]
echo Step definitions:     [FILL IN]
echo Locator/page files:   [FILL IN]
echo Config folder:        [FILL IN]
echo.
echo EXECUTION: Perfecto ONLY. Cannot run locally.
echo Real physical mobile devices inside Perfecto lab.
echo.
echo ---
echo.
echo ## NEW FRAMEWORK - FOLDER STRUCTURE
echo.
echo Step definitions folder:  [FILL IN]
echo Pages folder:             [FILL IN]
echo Runner folder:            [FILL IN]
echo Utilities folder:         [FILL IN]
echo Features folder:          [FILL IN]
echo Config folder:            [FILL IN]
echo Reports output folder:    [FILL IN]
echo.
echo EXECUTION:
echo - @local    runs Selenium locally
echo - @perfecto runs via Perfecto driver
echo.
echo ---
echo.
echo ## THREE-LAYER ARCHITECTURE
echo.
echo LAYER 1 - Feature Files
echo Location:   [FILL IN]
echo Language:   Gherkin ^(Given, When, Then, And, But^)
echo Tag format: [FILL IN - example: @12345 or @TC_12345]
echo Rules:
echo - Never put Selenium logic in a .feature file
echo - Never change or remove a @tag without explicit instruction
echo - @tags are ADO Test Case IDs. They are sacred.
echo.
echo LAYER 2 - Step Definitions ^(Steps.java^)
echo Location: [FILL IN]
echo Rules:
echo - NO Selenium actions. NO locators.
echo - Every method ONLY calls a method from a Pages.java file
echo - Search ALL Steps.java files before creating any new step
echo - Duplicate step definitions cause AmbiguousStepDefinitionsException
echo.
echo LAYER 3 - Page Object Model ^(Pages.java^)
echo Location: [FILL IN]
echo Locator naming convention:    [FILL IN]
echo Locator strategy preference:  [FILL IN]
echo Rules:
echo - ALL locators live here and ONLY here
echo - ALL Selenium actions live here and ONLY here
echo - Never modify a locator without showing old and new side by side
echo.
echo ---
echo.
echo ## CONFIGURATION
echo.
echo Main config file: [FILL IN]
echo Required keys:    [FILL IN - list all keys in your config file]
echo Rule: PAT token value is NEVER hardcoded in any Java file
echo.
echo ---
echo.
echo ## MAVEN BUILD COMMANDS
echo.
echo Run regression: [FILL IN]
echo Run smoke:      [FILL IN]
echo Run single tag: [FILL IN]
echo Run local:      [FILL IN]
echo Run perfecto:   [FILL IN]
echo.
echo ---
echo.
echo ## REPORTS
echo.
echo Type:      ExtentReports HTML
echo Location:  [FILL IN]
echo Filename:  [FILL IN]
echo Screenshots folder: [FILL IN]
echo Screenshot naming:  [FILL IN]
echo.
echo ---
echo.
echo ## NAMING CONVENTIONS
echo.
echo Feature files:     [FILL IN]
echo Steps files:       [FILL IN]
echo Pages files:       [FILL IN]
echo Locator variables: [FILL IN]
echo Method names:      [FILL IN]
echo.
echo ---
echo.
echo ## WHAT COPILOT MUST NEVER DO
echo.
echo 1. Never apply Old Framework structure to New Framework
echo 2. Never create a Steps.java method without searching all
echo    existing Steps.java files for a matching annotation first
echo 3. Never create a Pages.java method without searching all
echo    existing Pages.java files for the same method first
echo 4. Never modify a locator without showing old and new side
echo    by side and waiting for Sunils approval
echo 5. Never add a pom.xml dependency without checking it is
echo    not already present and waiting for Sunils approval
echo 6. Never assume a folder path. Always read the actual structure.
) > .vscode\instructions\framework-architecture.instructions.md

echo [OK] .vscode\instructions\framework-architecture.instructions.md created.
echo.

REM ------------------------------------------------------------
REM MORE FILES WILL BE ADDED HERE AS WE BUILD THEM
REM ------------------------------------------------------------

echo.
echo ============================================================
echo  Setup complete so far.
echo  Files created: 2 of 19
echo  Next file to be added: ado-api-reference.instructions.md
echo ============================================================
echo.

REM ------------------------------------------------------------
REM FILE 3 — .vscode\instructions\ado-api-reference.instructions.md
REM ------------------------------------------------------------

echo Creating .vscode\instructions\ado-api-reference.instructions.md...

(
echo # ado-api-reference.instructions.md
echo # Attach this file whenever any phase involves ADO REST API calls.
echo # Required for Phase 0, Phase 1, and any ADO update tasks.
echo # Replace every [FILL IN] with your actual ADO values.
echo # Never write your PAT value into this file directly.
echo.
echo ---
echo.
echo ## ADO ORGANIZATION DETAILS
echo.
echo Organization URL: https://dev.azure.com/MCLM
echo Project name:     [FILL IN]
echo API version:      7.0
echo.
echo All values except the org URL must come from config.properties.
echo Never hardcode project name, plan IDs, suite IDs, or PAT.
echo.
echo ---
echo.
echo ## AUTHENTICATION
echo.
echo Method: Basic Authentication
echo Format: Base64 encode the string :{PAT}
echo         The colon before PAT is required by ADO.
echo Header: Authorization: Basic {base64encoded value}
echo.
echo Java implementation:
echo   String pat = config.getProperty("ado.pat");
echo   String encoded = Base64.getEncoder()
echo       .encodeToString((":" + pat).getBytes(StandardCharsets.UTF_8));
echo   connection.setRequestProperty("Authorization", "Basic " + encoded);
echo.
echo Rules:
echo - PAT always read from config.properties key: ado.pat
echo - PAT never logged, printed, or written to any file
echo - HTTP 401 from ADO means PAT is expired. Stop and tell Sunil.
echo.
echo ---
echo.
echo ## TEST PLAN STRUCTURE IN ADO
echo.
echo Master Test Plan
echo   Query-based Suite (source of truth - all test cases live here)
echo     Test Cases (each has an ID and a Title)
echo.
echo Per-Release Test Plan (created fresh for each release)
echo   Copied test cases from Master Test Plan
echo     Test Runs created here during regression execution
echo.
echo config.properties keys required:
echo   ado.org=https://dev.azure.com/MCLM
echo   ado.project=[FILL IN]
echo   ado.masterPlanId=[FILL IN]
echo   ado.masterSuiteId=[FILL IN]
echo   ado.releasePlanId=[FILL IN - updated each release cycle]
echo   ado.releaseSuiteId=[FILL IN - updated each release cycle]
echo   ado.pat=[FILL IN - never commit this to repository]
echo.
echo ---
echo.
echo ## API ENDPOINT 1 - FETCH TEST CASES FROM A SUITE
echo.
echo Purpose: Pull all test cases from Master Test Plan for Phase 0.
echo.
echo GET https://dev.azure.com/MCLM/{project}/_apis/testplan/Plans/
echo     {masterPlanId}/suites/{masterSuiteId}/testcase?api-version=7.0
echo.
echo Fields to extract:
echo   Test Case ID:    value[i].testCase.id
echo   Test Case Title: value[i].testCase.name
echo.
echo Pagination:
echo   ADO returns max 100 results per page.
echo   Use ?$top=100^&$skip=0 for first page.
echo   Increment $skip by 100 for each page.
echo   Stop when results returned is less than $top.
echo   Always handle pagination. Never assume all 400 fit in one call.
echo.
echo ---
echo.
echo ## API ENDPOINT 2 - FETCH SINGLE TEST CASE DETAILS
echo.
echo GET https://dev.azure.com/MCLM/{project}/_apis/wit/workitems/
echo     {testCaseId}?api-version=7.0
echo.
echo Fields to extract:
echo   ID:    id
echo   Title: fields["System.Title"]
echo   State: fields["System.State"]
echo.
echo ---
echo.
echo ## API ENDPOINT 3 - CREATE A TEST RUN
echo.
echo Purpose: Create test run under release Test Plan. Phase 1 only.
echo POST https://dev.azure.com/MCLM/{project}/_apis/test/runs?api-version=7.0
echo.
echo IMPORTANT: Test Point ID is different from Test Case ID.
echo   Test Case ID  = ADO work item ID (example: 12345)
echo   Test Point ID = suite-specific ID (example: 9999)
echo   Never use one where the other is expected.
echo   Fetch Test Points using Endpoint 5 before creating a run.
echo.
echo ---
echo.
echo ## API ENDPOINT 4 - UPDATE TEST RESULTS IN A RUN
echo.
echo Purpose: Mark test cases Passed or Failed after regression.
echo          Phase 1 only. Do not implement until Sunil says "add ADO update".
echo.
echo PATCH https://dev.azure.com/MCLM/{project}/_apis/test/runs/
echo       {runId}/results?api-version=7.0
echo.
echo Outcome valid values: Passed / Failed / Blocked / NotApplicable
echo.
echo Rules:
echo - Never update ADO results without Sunils explicit approval
echo - Always show full results list before making PATCH call
echo - If a test case ID does not exist in ADO, log and skip it
echo.
echo ---
echo.
echo ## API ENDPOINT 5 - FETCH TEST POINTS
echo.
echo GET https://dev.azure.com/MCLM/{project}/_apis/testplan/Plans/
echo     {planId}/suites/{suiteId}/testpoint?api-version=7.0
echo.
echo Fields to extract:
echo   Test Point ID: value[i].id
echo   Test Case ID:  value[i].testCase.id
echo.
echo Build this map:
echo   Map testCaseIdToPointId
echo   Key: testCase.id (String)
echo   Value: id (Integer - the Test Point ID)
echo.
echo Pagination applies here too.
echo.
echo ---
echo.
echo ## ERROR HANDLING FOR ALL ADO API CALLS
echo.
echo HTTP 200 - Success. Process the response.
echo HTTP 400 - Bad request. Log URL and body. Stop and tell Sunil.
echo HTTP 401 - PAT invalid or expired. Stop. Tell Sunil to renew PAT.
echo HTTP 403 - Forbidden. Wrong PAT permissions. Stop. Tell Sunil.
echo HTTP 404 - Resource not found. Wrong ID. Stop. Tell Sunil to verify.
echo HTTP 429 - Rate limited. Retry with backoff. Max 3 retries then stop.
echo HTTP 500 - Server error. Retry once. If fails again, stop.
echo.
echo Every ADO API call must be in try-catch.
echo Never let an API failure silently crash the program.
echo Always log HTTP status code and response body on failure.
echo.
echo ---
echo.
echo ## JAVA HTTP CLIENT APPROACH
echo.
echo Use java.net.HttpURLConnection for all ADO API calls.
echo Do not add OkHttp, Retrofit, or Apache HttpClient without
echo checking pom.xml first and getting Sunils approval.
echo.
echo JSON parsing:
echo   Check pom.xml first. Use whatever is already present.
echo   Do not add a new JSON library if one already exists.
echo   Acceptable options: org.json, Jackson, Gson.
echo.
echo ---
echo.
echo ## CRITICAL REMINDERS FOR COPILOT
echo.
echo 1. Test Case ID and Test Point ID are NOT the same thing.
echo    Never use one where the other is expected.
echo.
echo 2. The @tag in the feature file IS the Test Case ID.
echo    @12345 in feature file = Test Case ID 12345 in ADO.
echo    This is the foundation of the entire system.
echo.
echo 3. Pagination must always be handled.
echo    Never assume 400 test cases fit in one API response.
echo.
echo 4. PAT must never appear in logs, output, or any file
echo    other than config.properties. This is a healthcare project.
echo.
echo 5. Never make a PATCH or POST call without showing Sunil
echo    exactly what will be sent and waiting for approval.
echo    GET calls can proceed after plan approval.
echo    Write calls always need a second confirmation.
) > .vscode\instructions\ado-api-reference.instructions.md

echo [OK] .vscode\instructions\ado-api-reference.instructions.md created.
echo.

REM ------------------------------------------------------------
REM MORE FILES WILL BE ADDED HERE AS WE BUILD THEM
REM ------------------------------------------------------------

echo.
echo ============================================================
echo  Setup complete so far.
echo  Files created: 3 of 19
echo  Next file to be added: .skills\session-end.md
echo ============================================================
echo.

REM ------------------------------------------------------------
REM FILE 4 — .skills\session-end.md
REM ------------------------------------------------------------

echo Creating .skills\session-end.md...

(
echo # session-end.md
echo # SKILL: session-end
echo # ================================================================
echo # HOW TO INVOKE: type "run session-end" in Copilot Chat
echo #
echo # WHAT THIS SKILL DOES:
echo # Step 1 - Writes handoff note to .project/handoff.md
echo #          Overwrites previous note. Always current state only.
echo # Step 2 - Appends dev log entry to .project/devlog.md
echo #          Never overwrites. Never deletes. Permanent record.
echo # Step 3 - Asks if you want to push to ADO repository.
echo #          Never pushes automatically. Always asks first.
echo # ================================================================
echo.
echo ---
echo.
echo ## STEP 1 - WRITE HANDOFF NOTE
echo.
echo Copilot must read the entire session conversation before writing.
echo Do not summarize from memory. Read what actually happened.
echo Write to .project/handoff.md - overwrite previous content.
echo.
echo FORMAT:
echo ================================================
echo # HANDOFF NOTE
echo Last updated: {DATE} {TIME}
echo Session duration: {approximate}
echo Phase active: {phase name}
echo ================================================
echo.
echo ## WHERE WE ARE RIGHT NOW
echo {2-4 sentences. Current state. What completed. What is partial.
echo What is waiting. Name files, classes, methods specifically.}
echo.
echo ## WHAT TO DO NEXT
echo {Numbered list. Concrete next actions. Specific enough to
echo pick up cold without asking questions.}
echo.
echo ## WHAT TO WATCH OUT FOR
echo {Bullet list. Risks, gotchas, unresolved decisions, unconfirmed
echo dependencies. If nothing, write "Nothing flagged this session."}
echo.
echo ## DECISIONS MADE THIS SESSION
echo {Bullet list. Every decision approved by Sunil this session.
echo If none, write "No new decisions this session."}
echo.
echo ## FILES TOUCHED THIS SESSION
echo {Format: ACTION - FILE PATH - WHAT CHANGED
echo Example: CREATED - src/.../ADOClient.java - new file}
echo ================================================
echo.
echo ---
echo.
echo ## STEP 2 - WRITE DEV LOG ENTRY
echo.
echo Append to .project/devlog.md - NEVER overwrite or delete.
echo If file does not exist, create it then append first entry.
echo.
echo FORMAT FOR EACH ENTRY:
echo ================================================
echo ---
echo ## SESSION LOG
echo Date: {DATE}
echo Time: {START} to {END} approximate
echo Phase: {phase name}
echo Engineer: Sunil Sagar
echo.
echo ### WHAT GOT BUILT
echo {Bulleted list. Specific. Name every class, method, file
echo completed and working. If nothing complete, say so.}
echo.
echo ### WHAT GOT SKIPPED OR DEFERRED
echo {Bulleted list. What was planned but not done and why.
echo If nothing, write "Nothing deferred this session."}
echo.
echo ### DECISIONS MADE
echo {Bulleted list. Decision + WHY it was made.}
echo.
echo ### MISTAKES OR WRONG TURNS
echo {Bulleted list. Honest account of what went wrong and
echo was corrected. If nothing, write "Clean session."}
echo.
echo ### RISKS AND OPEN QUESTIONS
echo {Bulleted list. Unresolved items needing a decision.
echo If nothing, write "No open risks or questions."}
echo.
echo ### NEXT SESSION MUST START WITH
echo {Numbered list. Exact first 3 things next session does.}
echo ================================================
echo.
echo ---
echo.
echo ## STEP 3 - ASK ABOUT ADO REPOSITORY PUSH
echo.
echo After Steps 1 and 2, Copilot asks exactly this:
echo.
echo Session-end complete.
echo Handoff note written to .project/handoff.md
echo Dev log entry appended to .project/devlog.md
echo.
echo Do you want to push the changes from this session
echo to the ADO repository?
echo.
echo If yes, tell me:
echo   1. Which files to include in the commit
echo   2. What commit message to use
echo   3. Which branch to push to
echo.
echo I will show you the exact git commands to run.
echo I will NOT run them automatically.
echo.
echo Rules for push step:
echo - Copilot NEVER runs git commands automatically
echo - Copilot NEVER decides files, message, or branch
echo - Copilot only suggests commands after Sunil provides all 3
echo - If Sunil says no: Changes saved locally. Session closed.
echo - Remind Sunil: client approves all changes before pushing
echo   to any shared or main branch.
echo.
echo ---
echo.
echo ## IMPORTANT RULES FOR THIS SKILL
echo.
echo 1. Read actual conversation before writing. Not memory.
echo 2. Never skip any section. If nothing to report, say so explicitly.
echo 3. Never write vague entries. Every entry must be specific enough
echo    for someone reading cold to understand exactly what happened.
echo 4. Handoff note is for the next session.
echo    Write as if handing off to a colleague not in this session.
echo 5. Dev log is permanent project history.
echo    Write as if it will be used to generate final documentation.
) > .skills\session-end.md

echo [OK] .skills\session-end.md created.
echo.

REM ------------------------------------------------------------
REM MORE FILES WILL BE ADDED HERE AS WE BUILD THEM
REM ------------------------------------------------------------

echo.
echo ============================================================
echo  Setup complete so far.
echo  Files created: 4 of 19
echo  Next file to be added: .skills\wrap-session.md
echo ============================================================
echo.

REM ------------------------------------------------------------
REM FILE 5 — .skills\wrap-session.md
REM ------------------------------------------------------------

echo Creating .skills\wrap-session.md...

(
echo # wrap-session.md
echo # SKILL: wrap-session
echo # ================================================================
echo # HOW TO INVOKE: type "run wrap-session" in Copilot Chat
echo #
echo # WHAT THIS SKILL DOES:
echo # Aggregates the current session into a daily log entry.
echo # Stores it in .project/daily-log.md
echo # Keeps only the last 5 session entries in this file.
echo # Older entries live permanently in .project/devlog.md
echo # daily-log.md is the QUICK REFERENCE - last 5 sessions
echo # so next session orients itself in under 60 seconds.
echo #
echo # Called automatically by end-session.md.
echo # Can also be called directly on its own.
echo # ================================================================
echo.
echo ---
echo.
echo ## WHAT THIS SKILL READS BEFORE WRITING
echo.
echo 1. Read .project/daily-log.md completely.
echo    Count how many entries exist. If file missing, create fresh.
echo 2. Read the current session conversation start to finish.
echo    Do not summarize from memory. Read what actually happened.
echo 3. Read .project/handoff.md if it exists for extra context.
echo.
echo Only after reading all three sources does Copilot write anything.
echo.
echo ---
echo.
echo ## TARGET FILE: .project/daily-log.md
echo.
echo Rules:
echo - Keeps ONLY the last 5 session entries at all times
echo - When new entry added and 5 already exist, oldest is removed
echo - Entries ordered newest first (most recent at the top)
echo - Never delete entries from devlog.md - that is permanent history
echo - Only daily-log.md has the rolling 5-entry limit
echo.
echo ---
echo.
echo ## FORMAT FOR .project/daily-log.md
echo.
echo ================================================
echo # DAILY LOG - MC PROJECT
echo # Rolling window: last 5 sessions only.
echo # Full permanent history is in .project/devlog.md
echo # Last updated: {DATE} {TIME}
echo ================================================
echo.
echo ---
echo.
echo ## ENTRY 1 - MOST RECENT SESSION
echo Date:     {DATE}
echo Time:     {approximate start} to {approximate end}
echo Phase:    {phase name and number}
echo Engineer: Sunil Sagar
echo.
echo ### IN ONE LINE
echo {Single sentence. The most important thing this session.}
echo.
echo ### WHAT WAS COMPLETED
echo {Bullet list. Only DONE and working items.
echo Specific - file names, method names, feature names.}
echo.
echo ### WHAT IS IN PROGRESS
echo {Bullet list. Started but not finished.
echo Include exactly where the work stopped.}
echo.
echo ### WHAT IS BLOCKED OR WAITING
echo {Bullet list. Cannot proceed until something else happens.
echo Name the blocker specifically.
echo If nothing blocked, write "Nothing blocked."}
echo.
echo ### NEXT SESSION STARTS WITH
echo {Numbered list. Maximum 3 items. Specific enough to act on
echo immediately without re-reading the entire conversation.}
echo.
echo ---
echo.
echo ## ENTRY 2 - PREVIOUS SESSION
echo {Same format as Entry 1}
echo.
echo ---
echo.
echo ## ENTRY 3
echo {Same format as Entry 1}
echo.
echo ---
echo.
echo ## ENTRY 4
echo {Same format as Entry 1}
echo.
echo ---
echo.
echo ## ENTRY 5 - OLDEST ENTRY IN THIS FILE
echo {Same format as Entry 1}
echo.
echo ================================================
echo END OF DAILY LOG
echo Full history: see .project/devlog.md
echo ================================================
echo.
echo ---
echo.
echo ## ROLLING WINDOW RULES
echo.
echo Step 1: Read daily-log.md. Count existing entries (0 to 5^).
echo Step 2: Create new entry for current session. Do not write yet.
echo Step 3: Apply rolling window:
echo   - 0 entries: new file, add Entry 1 only
echo   - 1 entry:   new is Entry 1, old Entry 1 becomes Entry 2
echo   - 2 entries: shift down, new is Entry 1
echo   - 3 entries: shift down, new is Entry 1
echo   - 4 entries: shift down, new is Entry 1
echo   - 5 entries: shift down, new is Entry 1,
echo                old Entry 5 is DROPPED
echo                (already exists permanently in devlog.md^)
echo Step 4: Rewrite daily-log.md completely from scratch.
echo Step 5: Confirm to Sunil:
echo   daily-log.md updated. N entries in rolling window.
echo   Oldest entry removed: YES/NO
echo   Entry removed was from: date or N/A
echo.
echo ---
echo.
echo ## WHAT NEXT SESSION DOES WITH THIS FILE
echo.
echo After Session Start Checklist, Copilot reads daily-log.md
echo and presents this summary to Sunil:
echo.
echo I have read your daily log. Here is where the project stands:
echo.
echo Most recent session (date^): one line summary
echo Currently in progress: in progress items
echo Blocked or waiting: blocked items
echo Next session was supposed to start with:
echo   1. item 1
echo   2. item 2
echo   3. item 3
echo.
echo Shall we pick up from here or is there something else
echo you want to work on today?
echo.
echo ---
echo.
echo ## IMPORTANT RULES FOR THIS SKILL
echo.
echo 1. Never delete entries from .project/devlog.md.
echo    Rolling window rule applies ONLY to daily-log.md.
echo 2. Never summarize from memory. Read actual files and conversation.
echo 3. IN ONE LINE must be genuinely one sentence. Not a paragraph.
echo 4. WHAT IS IN PROGRESS must include the exact stopping point.
echo    "Working on ADOClient" is not acceptable.
echo    Must say exactly where code stopped, what line, what method.
echo 5. If Sunil runs this skill then keeps working in the same session,
echo    the next wrap-session call must include all work done after
echo    the previous wrap. Always read the full conversation.
) > .skills\wrap-session.md

echo [OK] .skills\wrap-session.md created.
echo.

REM ------------------------------------------------------------
REM MORE FILES WILL BE ADDED HERE AS WE BUILD THEM
REM ------------------------------------------------------------

echo.
echo ============================================================
echo  Setup complete so far.
echo  Files created: 5 of 19
echo  Next file to be added: .skills\project-log.md
echo ============================================================
echo.

REM ------------------------------------------------------------
REM FILE 6 — .skills\project-log.md
REM ------------------------------------------------------------

echo Creating .skills\project-log.md...

(
echo # project-log.md
echo # SKILL: project-log
echo # ================================================================
echo # HOW TO INVOKE: type "run project-log" in Copilot Chat
echo # Or mid-session: "run project-log: {reason}"
echo # Examples:
echo #   "run project-log: milestone - Phase 0 complete"
echo #   "run project-log: decision - switching to Jackson"
echo #   "run project-log: risk - Perfecto rate limits unknown"
echo #   "run project-log: learning - ADO pagination needs token"
echo #   "run project-log: failure - XPath broke on iOS 17"
echo #
echo # WHAT THIS SKILL DOES:
echo # Appends a timestamped entry to .project/devlog.md
echo # This is the permanent long-term memory of the project.
echo # No limit. Nothing ever deleted. Everything timestamped.
echo # By project end, devlog.md contains everything needed
echo # to write final documentation. The work is already done.
echo #
echo # Called automatically by end-session.md.
echo # Can also be called directly at any point in a session.
echo # ================================================================
echo.
echo ---
echo.
echo ## TWO WAYS TO INVOKE
echo.
echo WAY 1 - End of session (called by end-session.md^)
echo Copilot generates full session entry automatically.
echo.
echo WAY 2 - In the moment (called directly by Sunil^)
echo "run project-log: {reason}"
echo Copilot writes a SHORT focused entry for that one thing only.
echo.
echo ---
echo.
echo ## TARGET FILE: .project/devlog.md
echo.
echo Rules:
echo - ALWAYS append. Never overwrite. Never delete.
echo - Every entry separated by a clear divider.
echo - Oldest at top, newest at bottom.
echo - If file does not exist, create header first then first entry.
echo - No size limit. Let it grow.
echo - This file is the source of truth for final documentation.
echo.
echo ---
echo.
echo ## FILE HEADER (written once on first creation^)
echo.
echo ================================================
echo # MC PROJECT - PERMANENT DEVELOPMENT LOG
echo # Project: Old Framework to New Framework Migration
echo # Client: MC (Healthcare^)
echo # Engineer: Sunil Sagar - Automation and Performance Tester
echo # Started: {DATE OF FIRST ENTRY}
echo #
echo # This file is permanent and append-only.
echo # Nothing is ever deleted.
echo # When the project ends, this file contains everything needed
echo # to write final documentation, handover report, retrospective.
echo # DO NOT DELETE. DO NOT EDIT PAST ENTRIES. ONLY APPEND.
echo ================================================
echo.
echo ---
echo.
echo ## FORMAT - FULL SESSION ENTRY
echo.
echo ================================================
echo ## [{DATE} {TIME}] SESSION ENTRY - {PHASE NAME}
echo Type: Session Summary
echo Engineer: Sunil Sagar
echo Duration: {approximate}
echo ================================================
echo.
echo ### CONTEXT
echo {1-2 sentences. State of project at session start. Session goal.}
echo.
echo ### COMPLETED THIS SESSION
echo {Bullet list. Everything finished and working.
echo Specific - class names, method names, file paths.}
echo.
echo ### SKIPPED OR DEFERRED
echo {Bullet list. What was planned but not done and why.
echo If nothing, write "Nothing deferred."}
echo.
echo ### DECISIONS MADE
echo {Format: DECISION: {what} - REASON: {why} - APPROVED BY: Sunil}
echo.
echo ### MISTAKES AND CORRECTIONS
echo {Format: MISTAKE: {what went wrong} - FIX: {how corrected}
echo If nothing, write "No mistakes this session."}
echo.
echo ### MILESTONES REACHED
echo {Significant deliverable completed this session.
echo If none, write "No milestone this session."}
echo.
echo ### RISKS IDENTIFIED OR UPDATED
echo {Format: RISK: {desc} - SEVERITY: High/Medium/Low -
echo STATUS: Open/Mitigated/Accepted - ACTION: {what to do}
echo If none, write "No new risks identified."}
echo.
echo ### LEARNINGS
echo {Things the team should know going forward.
echo If none, write "No new learnings this session."}
echo.
echo ### OPEN QUESTIONS
echo {Format: QUESTION: {what} - BLOCKING: YES/NO - ASKED TO: {who}
echo If none, write "No open questions."}
echo.
echo ### NEXT SESSION PLAN
echo {Numbered list. Max 5 items. Specific enough to act on immediately.}
echo ================================================
echo.
echo ---
echo.
echo ## FORMAT - SHORT FOCUSED ENTRY (mid-session call^)
echo.
echo ================================================
echo ## [{DATE} {TIME}] {TYPE}: {TITLE}
echo Type: Milestone / Decision / Risk / Learning / Failure / Note
echo Engineer: Sunil Sagar
echo Phase: {current phase}
echo ================================================
echo {3-10 sentences or bullets. Capture the specific thing clearly.
echo Include enough context for someone reading this 6 months from now.}
echo ================================================
echo.
echo ---
echo.
echo ## ENTRY TYPES
echo.
echo MILESTONE - phase, feature, or deliverable complete
echo DECISION  - technical or process decision made (always include WHY^)
echo RISK      - new risk found or existing risk updated
echo LEARNING  - something discovered the team should know
echo FAILURE   - something broke or had to be redone (honest record^)
echo NOTE      - anything else that needs recording
echo.
echo ---
echo.
echo ## HOW THIS BECOMES DOCUMENTATION
echo.
echo At project end, Sunil types: "run create-doc: final project report"
echo create-doc reads devlog.md and generates documentation automatically.
echo Decisions, learnings, risks, milestones are already written.
echo create-doc just formats and organizes them.
echo This is why entry quality matters.
echo Vague entries produce vague documentation.
echo Specific entries produce documentation the client can use.
echo.
echo ---
echo.
echo ## IMPORTANT RULES
echo.
echo 1. NEVER overwrite or delete any past entry. Append-only forever.
echo 2. NEVER write vague entries. Specific enough for 6 months from now.
echo 3. ALWAYS include timestamp on every entry: [YYYY-MM-DD HH:MM]
echo 4. MISTAKES and FAILURES must include what went wrong, why,
echo    and how it was fixed. Most valuable part of the log.
echo 5. DECISIONS must always include the reason. A decision without
echo    a reason is useless 6 months later.
echo 6. HEALTHCARE PROJECT: Never record patient data, test data with
echo    real names or IDs, or any sensitive information in this log.
echo    Technical decisions and actions only. Never data values.
) > .skills\project-log.md

echo [OK] .skills\project-log.md created.
echo.

REM ------------------------------------------------------------
REM MORE FILES WILL BE ADDED HERE AS WE BUILD THEM
REM ------------------------------------------------------------

echo.
echo ============================================================
echo  Setup complete so far.
echo  Files created: 6 of 19
echo  Next file to be added: .skills\end-session.md
echo ============================================================
echo.

REM ------------------------------------------------------------
REM FILE 7 — .skills\end-session.md
REM ------------------------------------------------------------

echo Creating .skills\end-session.md...

(
echo # end-session.md
echo # SKILL: end-session
echo # ================================================================
echo # HOW TO INVOKE: type "run end-session" in Copilot Chat
echo #
echo # WHAT THIS SKILL DOES:
echo # This is the single daily shutdown command.
echo # Orchestrates three skills in strict order:
echo #   Step 1 - wrap-session  (updates rolling daily log^)
echo #   Step 2 - project-log   (appends permanent dev log^)
echo #   Step 3 - session-end   (handoff note + ADO push prompt^)
echo #
echo # One command. Everything runs. Nothing missed.
echo # Run this before /clear every single session.
echo #
echo # IMPORTANT: Do not clear chat before running this.
echo # Clearing chat first means session history is lost
echo # and logs cannot be written accurately.
echo # ================================================================
echo.
echo ---
echo.
echo ## EXECUTION ORDER — STRICT, NEVER CHANGED
echo.
echo The three skills must always run in this exact order:
echo   1. wrap-session FIRST  - updates rolling daily log
echo   2. project-log SECOND  - appends permanent dev log entry
echo   3. session-end THIRD   - writes handoff note, asks about push
echo.
echo Reason for this order:
echo wrap-session and project-log both read the session conversation.
echo session-end writes the handoff note summarizing what they captured.
echo If session-end runs first the handoff note may be inconsistent.
echo.
echo ---
echo.
echo ## STEP 0 - ANNOUNCE START
echo.
echo Copilot says exactly:
echo "Running end-session. This will take a moment.
echo I am reading the full session conversation now before writing.
echo Do not clear the chat until I confirm end-session is complete."
echo.
echo Then Copilot reads:
echo   - Entire session conversation first to last message
echo   - .project/daily-log.md
echo   - .project/devlog.md
echo   - .project/handoff.md
echo   - .project/knowledge.md
echo.
echo Only after reading all of these does Copilot proceed.
echo.
echo ---
echo.
echo ## STEP 1 - RUN wrap-session
echo.
echo Execute full wrap-session skill from .skills/wrap-session.md
echo - Creates new session entry in correct format
echo - Applies rolling window rule (keep last 5 entries^)
echo - Rewrites .project/daily-log.md completely
echo.
echo When complete: "Step 1 of 3 complete - daily-log.md updated."
echo Then immediately proceed to Step 2. No waiting for input.
echo.
echo ---
echo.
echo ## STEP 2 - RUN project-log
echo.
echo Execute full project-log skill from .skills/project-log.md
echo - Generates full session entry in correct format
echo - Includes: completed, deferred, decisions, mistakes,
echo   milestones, risks, learnings, open questions, next plan
echo - Appends to .project/devlog.md
echo - Never overwrites anything already in devlog.md
echo.
echo When complete: "Step 2 of 3 complete - devlog.md updated."
echo Then immediately proceed to Step 3. No waiting for input.
echo.
echo ---
echo.
echo ## STEP 3 - RUN session-end
echo.
echo Execute full session-end skill from .skills/session-end.md
echo - Writes handoff note to .project/handoff.md
echo   (overwrites previous - always current state only^)
echo - Confirms handoff note written
echo - Asks about ADO repository push
echo.
echo The ADO push question is the ONLY pause point.
echo Everything before this runs automatically.
echo.
echo ---
echo.
echo ## FINAL CONFIRMATION
echo.
echo After all three steps complete, Copilot says exactly:
echo.
echo "================================================
echo END-SESSION COMPLETE
echo ================================================
echo Files updated this session:
echo   .project/daily-log.md  - rolling log updated ({N} entries^)
echo   .project/devlog.md     - entry appended ({DATE} {TIME}^)
echo   .project/handoff.md    - handoff note written
echo.
echo ADO push: {PUSHED / NOT PUSHED}
echo.
echo Session summary in one line:
echo {Single sentence - most important thing this session}
echo.
echo You are clear to /clear the chat.
echo See you next session, Sunil.
echo ================================================"
echo.
echo ---
echo.
echo ## WHAT COPILOT MUST NEVER DO
echo.
echo 1. Never skip any of the three skills. All three run every time.
echo 2. Never run steps out of order.
echo 3. Never ask for input between Step 0 and the ADO push question.
echo 4. Never write vague entries because the session was short.
echo    Even a planning-only session must be logged accurately.
echo 5. Never read only part of the conversation. Full history always.
echo 6. If chat was already cleared before end-session ran:
echo    Tell Sunil: "Session history unavailable. Please describe
echo    what was done and I will format it into the log files."
echo.
echo ---
echo.
echo ## SHORTCUT COMMANDS
echo.
echo "run end-session"
echo - Full shutdown ritual. All three steps. Use this every day.
echo.
echo "run end-session: skip push"
echo - All three steps but skips the ADO push question.
echo.
echo "run end-session: quick"
echo - All three steps with shorter log entries.
echo - For short sessions where not much happened.
echo - Still mandatory. Never skip logging entirely.
echo.
echo "run end-session: status"
echo - Does NOT write any logs.
echo - Only reads and summarizes current state of all log files.
echo - Use at session start if you forgot to run end-session
echo   at end of previous session.
echo.
echo ---
echo.
echo ## DAILY SHUTDOWN RITUAL - SUNIL
echo.
echo BEFORE YOU /clear OR CLOSE VS CODE:
echo   1. Type: "run end-session"
echo   2. Wait for all three steps to complete
echo   3. Answer the ADO push question
echo   4. Wait for the final confirmation message
echo   5. Now you can /clear or close VS Code
echo.
echo If you skip end-session even once, that sessions work,
echo decisions, risks, and learnings are not recorded anywhere.
echo The daily log and dev log will have a gap.
echo The handoff note will be stale.
echo The next session will start without context.
echo.
echo One command. 60 seconds. Everything captured. Do not skip it.
) > .skills\end-session.md

echo [OK] .skills\end-session.md created.
echo.

REM ------------------------------------------------------------
REM MORE FILES WILL BE ADDED HERE AS WE BUILD THEM
REM ------------------------------------------------------------

echo.
echo ============================================================
echo  Setup complete so far.
echo  Files created: 7 of 21
echo  Next file to be added: .skills\validation.md
echo ============================================================
echo.

REM ------------------------------------------------------------
REM FILE 8 — .skills\validation.md
REM ------------------------------------------------------------

echo Creating .skills\validation.md...

(
echo # validation.md
echo # SKILL: validation
echo # ================================================================
echo # HOW TO INVOKE:
echo # Runs automatically before Copilot marks ANY task as done.
echo # Manual invocation:
echo #   "run validation"               - validates last output
echo #   "run validation: {file path}"  - validates specific file
echo #   "run validation: phase {N}"    - validates phase output
echo #
echo # WHAT THIS SKILL DOES:
echo # Acts as a quality gate before any output is marked complete.
echo # Four validation layers:
echo #   Layer 1 - Universal rules (every output^)
echo #   Layer 2 - Java code rules (all Java files^)
echo #   Layer 3 - Feature file rules (all .feature files^)
echo #   Layer 4 - Phase-specific rules (per phase^)
echo # ================================================================
echo.
echo ---
echo.
echo ## LAYER 1 - UNIVERSAL RULES
echo # Apply to EVERY output. No exceptions.
echo.
echo U1 - No assumptions made
echo RULE: Every value used must have been READ from an actual file
echo       or explicitly provided by Sunil. Not assumed from memory.
echo FAIL: List every assumed value. Ask Sunil to confirm each one.
echo.
echo U2 - No files modified without approval
echo RULE: Every file created or modified was explicitly approved
echo       by Sunil before the change was made.
echo FAIL: List every changed file. Confirm approval for each.
echo       Revert any unapproved change and present for approval.
echo.
echo U3 - No new dependencies added without approval
echo RULE: No new pom.xml entry without Sunil approving after
echo       being shown it was missing from the file.
echo FAIL: Remove unapproved dependency. Present for approval.
echo.
echo U4 - No placeholder code
echo RULE: Zero instances of // TODO, // add your logic here,
echo       // implement this, // placeholder in any output.
echo FAIL: Complete every placeholder before marking done.
echo.
echo U5 - No patient data or sensitive information
echo RULE: No patient names, IDs, health records, personal info,
echo       PAT tokens, passwords, or credentials in any output file.
echo       config.properties values must use [FILL IN] placeholders.
echo FAIL: CRITICAL. Remove immediately. Alert Sunil.
echo.
echo U6 - No auto-commits or auto-pushes
echo RULE: No git command executed automatically.
echo       Nothing pushed without explicit Sunil instruction.
echo FAIL: CRITICAL. Alert Sunil with exactly what was pushed.
echo.
echo U7 - One task at a time
echo RULE: Only one approved task completed per output.
echo FAIL: Split output. Present each task separately.
echo.
echo U8 - Plain English explanation provided
echo RULE: Every code output has a plain English explanation
echo       covering every section, clear for a mid-level QA engineer.
echo FAIL: Add explanation before marking done.
echo.
echo ---
echo.
echo ## LAYER 2 - JAVA CODE RULES
echo.
echo J1 - Three-layer architecture respected
echo RULE: No Selenium or locators in Steps.java.
echo       No business logic in .feature files.
echo       All locators and Selenium actions only in Pages.java.
echo FAIL: Move misplaced code to correct layer.
echo.
echo J2 - No duplicate step definitions
echo RULE: No new @Given/@When/@Then annotation matches any
echo       annotation already existing in any Steps.java file.
echo FAIL: CRITICAL. Remove duplicate. Use existing definition.
echo.
echo J3 - No hardcoded values
echo RULE: No URL, credential, path, ADO ID, or config value
echo       hardcoded in any Java file. All from config.properties.
echo FAIL: Move to config.properties. Read via getProperty().
echo.
echo J4 - Error handling present
echo RULE: Every external call (ADO API, file IO, DOM, Perfecto^)
echo       has a try-catch that logs failure with context.
echo       Program never silently crashes.
echo FAIL: Add error handling to every uncovered call.
echo.
echo J5 - Config reading follows established pattern
echo RULE: config.properties loaded using the same pattern
echo       already in the project. Not a new invented pattern.
echo FAIL: Replace with established pattern.
echo.
echo J6 - Naming conventions followed
echo RULE: All names follow conventions in
echo       framework-architecture.instructions.md
echo FAIL: Rename to match conventions.
echo.
echo J7 - No System.out.println in production code
echo RULE: Use established logging approach. No println.
echo FAIL: Replace with established logging.
echo.
echo J8 - Apache POI version consistency
echo RULE: POI usage matches the version already in pom.xml.
echo FAIL: Update code to match pom.xml version.
echo.
echo ---
echo.
echo ## LAYER 3 - FEATURE FILE RULES
echo.
echo F1 - Tags are never changed
echo RULE: @tags are ADO Test Case IDs. Never changed, removed,
echo       reordered, or renamed. Must exactly match ADO.
echo FAIL: CRITICAL. Restore original tags. Alert Sunil.
echo.
echo F2 - Gherkin language is correct
echo RULE: Steps start with Given/When/Then/And/But only.
echo       Scenario Outline has Examples table.
echo FAIL: Correct Gherkin syntax before marking done.
echo.
echo F3 - Step text matches existing step definitions
echo RULE: Every Gherkin step has a matching annotation in
echo       Steps.java files OR a new one approved by Sunil.
echo       No orphan steps - they cause Undefined Step errors.
echo FAIL: List orphan steps. Propose definitions. Wait for approval.
echo.
echo F4 - Feature file naming convention followed
echo RULE: File names match convention in framework-architecture.md
echo FAIL: Rename to match convention.
echo.
echo F5 - No duplicate scenarios
echo RULE: No two scenarios share the same @tag anywhere in project.
echo FAIL: Alert Sunil. Duplicate tags corrupt the reporting system.
echo.
echo ---
echo.
echo ## LAYER 4 - PHASE-SPECIFIC RULES
echo.
echo PHASE 0 - Reconciliation Engine
echo P0-1: Excel has all 8 required columns in correct order.
echo P0-2: Color coding correct - Green/Yellow/Red/Orange.
echo P0-3: Pagination handled. All 400 test cases present.
echo P0-4: No ADO Test Case missed or skipped.
echo.
echo PHASE 1 - Post-Run Excel Reporter
echo P1-1: Every scenario from test run appears in report.
echo P1-2: Pass/Fail matches ExtentReport HTML exactly.
echo P1-3: Failure reason never blank for a failed test.
echo P1-4: Screenshot path valid for every failed test.
echo P1-5: ADO update only runs after Sunil approval.
echo.
echo PHASE 2 - Migration Engine
echo P2-1: Every migrated file has all original @tags intact.
echo P2-2: Every Gherkin step has confirmed matching definition.
echo P2-3: No new Pages.java method without approval.
echo P2-4: No new Steps.java method without approval.
echo P2-5: Structural split cases flagged, not auto-resolved.
echo P2-6: Migrated file follows new framework naming convention.
echo P2-7: Original old framework file not deleted or modified.
echo.
echo PHASE 3 - Web Locator Auto-Healer
echo P3-1: Fix only in Pages.java. Never Steps.java or .feature.
echo P3-2: Old and new locator shown side by side before any change.
echo P3-3: Fix explicitly approved by Sunil before writing.
echo P3-4: Only failing locator changed. Nothing else touched.
echo.
echo PHASE 4 - Perfecto Mobile Locator Healer
echo P4-1: All Phase 3 rules apply.
echo P4-2: Every fix individually approved. No batch approvals.
echo P4-3: Mobile locator strategy preference order followed.
echo.
echo ---
echo.
echo ## VALIDATION RESULT FORMAT
echo.
echo IF ALL RULES PASS:
echo Validation passed. All N rules checked. No issues found.
echo Task complete.
echo.
echo IF ANY RULE FAILS:
echo Validation failed. Task is NOT complete.
echo.
echo FAILED: rule code - rule name
echo Reason: what failed and why
echo Fix required: what needs to change
echo.
echo I will not mark this task complete until all failed rules
echo are resolved. Shall I fix these now?
echo.
echo Copilot waits for Sunils instruction.
echo Copilot NEVER fixes validation failures automatically.
echo.
echo ---
echo.
echo ## IMPORTANT RULES FOR THIS SKILL
echo.
echo 1. Validation runs before EVERY Task complete statement.
echo    No exceptions. Not for small changes. Not for quick fixes.
echo 2. Validation failures are not optional to resolve.
echo    If a rule fails, the task is not done.
echo 3. Never skip a layer because the task seems simple.
echo 4. When in doubt whether a rule applies, apply it.
echo 5. This is a healthcare project. Quality is not optional.
) > .skills\validation.md

echo [OK] .skills\validation.md created.
echo.

REM ------------------------------------------------------------
REM MORE FILES WILL BE ADDED HERE AS WE BUILD THEM
REM ------------------------------------------------------------

echo.
echo ============================================================
echo  Setup complete so far.
echo  Files created: 8 of 21
echo  Next file to be added: .skills\standard-of-working.md
echo ============================================================
echo.

REM ------------------------------------------------------------
REM FILE 9 — .skills\standard-of-working.md
REM ------------------------------------------------------------

echo Creating .skills\standard-of-working.md...

(
echo # standard-of-working.md
echo # SKILL: standard-of-working
echo # ================================================================
echo # HOW TO INVOKE:
echo # Read automatically at session start. Always active.
echo # Manual: "run standard-of-working" to re-confirm standards.
echo #
echo # WHAT THIS SKILL DOES:
echo # Defines coding conventions, naming patterns, structural rules,
echo # communication standards, and working agreements for this project.
echo # This is the "how we do things here" document.
echo # Works alongside validation.md:
echo #   validation.md        - checks WHAT was built
echo #   standard-of-working  - defines HOW it must be built
echo # ================================================================
echo.
echo ---
echo.
echo ## SECTION 1 - JAVA CODING STANDARDS
echo.
echo 1.1 Class Structure (in this order^):
echo   1. Package declaration
echo   2. Import statements (Java standard first, then third-party^)
echo   3. Class Javadoc comment
echo   4. Class declaration
echo   5. Constants (static final^)
echo   6. Instance variables (private^)
echo   7. Constructor(s^)
echo   8. Public methods
echo   9. Private helper methods
echo   Max 300 lines per class. Discuss splitting with Sunil if exceeded.
echo.
echo 1.2 Method Structure (in this order^):
echo   1. Javadoc comment
echo   2. Input validation (null checks, empty checks^)
echo   3. Core logic
echo   4. Return or void action
echo   Max 40 lines per method. Discuss splitting with Sunil if exceeded.
echo.
echo 1.3 Naming Conventions:
echo   Classes:   PascalCase. Describes what the class IS or DOES.
echo              Examples: ADOClient, FeatureFileParser
echo   Methods:   camelCase. Starts with a verb.
echo              Examples: fetchTestCases(), parseFeatureFile()
echo              Booleans: isTagPresent(), hasMatchingStep()
echo   Variables: camelCase. Describes what it HOLDS.
echo              Examples: testCaseId, scenarioTitle, featureFilePath
echo              No single letters except loop counters i, j, k.
echo   Constants: UPPER_SNAKE_CASE.
echo              Examples: MAX_RETRY_COUNT, DEFAULT_PAGE_SIZE
echo   Locators:  [FILL IN - match convention in your Pages.java files]
echo              Common: btnLogin, txtUsername, lblError, lnkForgot
echo              Prefixes: btn/txt/lbl/lnk/drp/chk/rad/img/tbl/frm
echo.
echo 1.4 Comments and Documentation:
echo   Every class has Javadoc: what it does, which layer, which phase.
echo   Every public method has Javadoc with @param @return @throws.
echo   Inline comments explain WHY not WHAT.
echo   Do not comment the obvious.
echo.
echo 1.5 Error Handling:
echo   All external calls in try-catch: ADO API, file IO, Perfecto, DOM.
echo   Catch blocks must log with context. Never swallow silently.
echo   Log format: [CLASS_NAME] [METHOD_NAME] {error description}
echo   Prefer specific exceptions over generic Exception.
echo.
echo 1.6 Configuration Standards:
echo   All configurable values in config.properties.
echo   New keys must be added with [FILL IN] placeholder.
echo   New keys documented with comment explaining format.
echo   config.properties format:
echo     # {key description} - {format or example}
echo     key=[FILL IN]
echo.
echo 1.7 Import Standards:
echo   No wildcard imports. Every import explicit.
echo   Remove all unused imports before presenting code.
echo.
echo ---
echo.
echo ## SECTION 2 - FEATURE FILE STANDARDS
echo.
echo 2.1 Feature File Structure (in this order^):
echo   1. Feature-level tags (@regression @smoke^)
echo   2. Feature keyword and name
echo   3. Empty line
echo   4. Scenarios with ADO tag directly above each one
echo.
echo 2.2 Gherkin Writing Standards:
echo   Given = starting state or precondition (not an action^)
echo   When  = action being performed (not a state^)
echo   Then  = expected outcome (specific, not vague^)
echo   And   = extends previous Given/When/Then
echo   But   = expresses negative condition
echo   Steps should be readable in one line (max ~15 words^).
echo   No technical implementation language in steps.
echo   Bad:  "When I find element by xpath //div[@class='appt']"
echo   Good: "When the patient navigates to the appointments section"
echo.
echo 2.3 Scenario Outline Standards:
echo   Use when same logic runs with multiple data sets.
echo   Examples table must have meaningful column names.
echo   Examples values must not contain real patient data.
echo.
echo 2.4 Tag Standards (in this exact order^):
echo   1. ADO Test Case ID tag (@12345^) - ALWAYS FIRST
echo   2. Suite tag (@regression or @smoke or both^)
echo   3. Execution mode (@local or @perfecto^)
echo   Example: @12345 @regression @local
echo   No custom tags without Sunils explicit approval.
echo.
echo ---
echo.
echo ## SECTION 3 - FILE AND FOLDER STANDARDS
echo.
echo 3.1 File Naming:
echo   [FILL IN from framework-architecture.instructions.md]
echo.
echo 3.2 One Responsibility Per File:
echo   Each feature file = one functional area.
echo   Each Pages.java   = one page or module.
echo   Each Steps.java   = one feature file or functional area.
echo   No catch-all files covering multiple unrelated areas.
echo.
echo 3.3 Output Files:
echo   All generated files go to output folder in config.properties.
echo   Never generate into source code folders.
echo   Output folder added to .gitignore. Never committed.
echo.
echo ---
echo.
echo ## SECTION 4 - COMMUNICATION AND WORKING STANDARDS
echo.
echo 4.1 How Copilot Presents Work:
echo   1. State the plan
echo   2. Wait for approval
echo   3. Do it
echo   4. Explain in plain English
echo   5. Run validation
echo   6. Pass: "Task complete. What next?"
echo   7. Fail: list failures, wait for instruction
echo.
echo 4.2 One question at a time. Wait for answer before asking next.
echo.
echo 4.3 Progress format:
echo   "Completed: {what done}
echo    In progress: {working on now}
echo    Next: {what comes after}"
echo.
echo 4.4 Language: plain English always. Technical terms explained.
echo    No "I think" or "probably" - if unsure, ask.
echo.
echo 4.5 When things go wrong:
echo   1. Stop immediately
echo   2. State what went wrong
echo   3. State what was affected
echo   4. Propose the fix
echo   5. Wait for approval
echo   6. Fix then re-run validation
echo   Never hide or minimize mistakes.
echo.
echo ---
echo.
echo ## SECTION 5 - TEAM KT STANDARDS
echo.
echo 5.1 Everything explainable to a mid-level QA engineer
echo     without Sunil being present.
echo.
echo 5.2 No magic numbers or strings.
echo   Bad:  if (results.size() == 100^)
echo   Good: if (results.size() == DEFAULT_PAGE_SIZE^)
echo.
echo 5.3 Code readable without comments.
echo   Comments explain WHY not WHAT.
echo   If WHAT is unclear from code, rename until it is clear.
echo.
echo ---
echo.
echo ## SECTION 6 - HEALTHCARE PROJECT STANDARDS
echo.
echo 6.1 Data Handling:
echo   Test data never contains real patient information.
echo   Use generic placeholders: "Test Patient 001", "01/01/2000"
echo.
echo 6.2 Logging - NEVER log:
echo   Patient names or IDs, health records, auth tokens,
echo   passwords, or any personally identifiable information.
echo   Log only: timestamps, class names, error messages,
echo   HTTP status codes, file paths, test case IDs.
echo.
echo 6.3 Security:
echo   PAT tokens from config.properties only.
echo   config.properties never committed to repository.
echo   config.properties in .gitignore.
echo   config.properties.template with [FILL IN] committed instead.
) > .skills\standard-of-working.md

echo [OK] .skills\standard-of-working.md created.
echo.

REM ------------------------------------------------------------
REM MORE FILES WILL BE ADDED HERE AS WE BUILD THEM
REM ------------------------------------------------------------

echo.
echo ============================================================
echo  Setup complete so far.
echo  Files created: 9 of 21
echo  Next file to be added: .skills\pr-scan.md
echo ============================================================
echo.

REM ------------------------------------------------------------
REM FILE 10 — .skills\pr-scan.md
REM ------------------------------------------------------------

echo Creating .skills\pr-scan.md...

(
echo # pr-scan.md
echo # SKILL: pr-scan
echo # ================================================================
echo # HOW TO INVOKE:
echo #   "run pr-scan"              - scans all files touched this session
echo #   "run pr-scan: {file path}" - scans a specific file
echo #   "run pr-scan: phase {N}"   - scans all output from a phase
echo #
echo # WHAT THIS SKILL DOES:
echo # Privacy and security review before any file is committed
echo # or shared. Non-negotiable on this project because:
echo #   1. This is a HEALTHCARE application
echo #   2. Real patient data exists in the application being tested
echo #   3. Patient data exposure is a compliance violation
echo #   4. Client (MC^) must approve all changes
echo #
echo # Runs automatically inside validation.md Rule U5.
echo # Also run manually before every git commit.
echo # ================================================================
echo.
echo ---
echo.
echo ## FIVE CHECK CATEGORIES
echo.
echo Every file checked against all five categories.
echo File passes only when ALL five pass.
echo One failure = file cannot be committed or shared.
echo.
echo ---
echo.
echo ## CATEGORY 1 - PATIENT DATA CHECK
echo.
echo PD-1: Patient names
echo   Flag any name not clearly a generic placeholder.
echo   Safe:   "Test Patient 001", "John Doe Test", "Patient A"
echo   Unsafe: "Sarah Johnson", "Michael Brown", "Mary Williams"
echo.
echo PD-2: Patient identification numbers
echo   Flag patient IDs, MRNs, member IDs, insurance IDs, SSNs,
echo   DOB combinations that could identify a real person.
echo   Safe:   "MRN_TEST_001", "PATIENT_ID_PLACEHOLDER"
echo   Unsafe: Any real-looking numeric ID from a real session.
echo.
echo PD-3: Health records and medical information
echo   Flag diagnosis names, medication names, lab result values,
echo   appointment details with real dates and real doctor names.
echo.
echo PD-4: Contact information
echo   Flag real emails, phone numbers, physical addresses.
echo   Safe: "test@testdomain.com", "555-0100", "123 Test Street"
echo.
echo PD-5: Screenshots and attachments
echo   Flag every screenshot path found in output.
echo   Copilot cannot read image files.
echo   Sunil must manually review every screenshot before sharing.
echo.
echo SEVERITY IF FOUND: CRITICAL
echo ACTION:
echo   1. Stop all work immediately
echo   2. Report exact file, line, content
echo   3. Do NOT suggest fix - Sunil decides
echo   4. Do NOT commit, push, or share anything
echo   5. Log incident in devlog.md as RISK entry
echo   6. Wait for Sunils explicit instruction
echo.
echo ---
echo.
echo ## CATEGORY 2 - AUTHENTICATION AND CREDENTIALS CHECK
echo.
echo AC-1: PAT tokens
echo   Flag 52-char alphanumeric strings or variables named
echo   pat/token/accessToken/personalAccessToken with real values.
echo   Safe:   ado.pat=[FILL IN]
echo   Unsafe: ado.pat=abc123xyz...{actual value}
echo.
echo AC-2: Passwords and secrets
echo   Flag password/secret/key/apiKey/secretKey with real values.
echo.
echo AC-3: Perfecto credentials
echo   Flag Perfecto security token or host with embedded credentials.
echo.
echo AC-4: Base64 encoded credentials
echo   Flag Base64-looking strings in non-utility code.
echo   Encoded credentials are still credentials.
echo.
echo AC-5: Hardcoded auth headers
echo   Flag Authorization header values with actual tokens.
echo.
echo SEVERITY IF FOUND: CRITICAL
echo ACTION:
echo   1. Stop all work immediately
echo   2. Report exact location
echo   3. Replace with [FILL IN] placeholder immediately
echo   4. If already committed - PAT must be revoked and regenerated
echo   5. Log incident in devlog.md
echo.
echo ---
echo.
echo ## CATEGORY 3 - CONFIGURATION AND ENVIRONMENT CHECK
echo.
echo CE-1: config.properties with real values in commit scope
echo   config.properties must NEVER be committed.
echo   config.properties.template with [FILL IN] values MAY be committed.
echo.
echo CE-2: Environment URLs hardcoded
echo   All environment URLs must come from config.properties.
echo.
echo CE-3: Production data or references
echo   Flag any production environment names, URLs, or identifiers.
echo.
echo CE-4: .gitignore coverage
echo   Must include at minimum:
echo     config.properties
echo     /output/ folder
echo     *.log
echo     target/
echo.
echo SEVERITY IF FOUND: HIGH
echo ACTION: Flag issue, propose fix, wait for Sunils approval.
echo.
echo ---
echo.
echo ## CATEGORY 4 - CODE AND LOGIC CHECK
echo.
echo CL-1: Logging of sensitive data (HIGH^)
echo   Flag log statements outputting patient data or credentials.
echo   Logs must only contain: timestamps, class names, error messages,
echo   HTTP status codes, test case IDs, file paths.
echo.
echo CL-2: Stack traces exposing sensitive paths (HIGH^)
echo   Flag raw printStackTrace() calls in production code.
echo.
echo CL-3: Commented-out real data (HIGH^)
echo   Flag comments containing real credentials or patient data.
echo   Comments are committed to the repository too.
echo.
echo CL-4: Debug code left in (MEDIUM^)
echo   Flag debug flags true, code saying "remove before commit".
echo.
echo CL-5: Console output of test data (MEDIUM^)
echo   Flag print statements outputting test scenario data.
echo.
echo ---
echo.
echo ## CATEGORY 5 - REPOSITORY SAFETY CHECK
echo.
echo RS-1: Files that should never be committed
echo   Flag if in commit scope:
echo     config.properties with real values
echo     Files in /output/ folder
echo     .log files
echo     Screenshot files (.png .jpg .jpeg^)
echo     Files larger than 10MB
echo.
echo RS-2: Commit message safety
echo   Scan message for patient data, credentials, internal names.
echo.
echo RS-3: Branch safety
echo   If pushing to shared or main branch:
echo   "You are pushing to {branch}. This branch is shared.
echo    Client approval required. Have you received it?"
echo.
echo RS-4: New files review
echo   List every new file in the commit.
echo   Sunil must confirm each new file is intentional.
echo.
echo ---
echo.
echo ## PR-SCAN RESULT FORMAT
echo.
echo IF ALL PASS:
echo "pr-scan PASSED
echo ================================================
echo Category 1 - Patient Data:         PASS
echo Category 2 - Credentials:          PASS
echo Category 3 - Configuration:        PASS
echo Category 4 - Code and Logic:       PASS
echo Category 5 - Repository Safety:    PASS
echo ================================================
echo {N} files scanned. No issues found. Safe to commit."
echo.
echo IF ANY FAIL:
echo "pr-scan FAILED - DO NOT COMMIT OR SHARE
echo ================================================
echo Category 1 - Patient Data:         {PASS/FAIL}
echo Category 2 - Credentials:          {PASS/FAIL}
echo Category 3 - Configuration:        {PASS/FAIL}
echo Category 4 - Code and Logic:       {PASS/FAIL}
echo Category 5 - Repository Safety:    {PASS/FAIL}
echo ================================================
echo.
echo ISSUES FOUND:
echo [{SEVERITY}] {category code} - {rule name}
echo File:   {file path}
echo Line:   {line number}
echo Found:  {what was found - redacted if credential}
echo Risk:   {what could happen if committed}
echo Action: {what needs to be done - Sunil decides}
echo.
echo DO NOT COMMIT. DO NOT SHARE.
echo Resolve all issues and run pr-scan again."
echo.
echo ---
echo.
echo ## IMPORTANT RULES
echo.
echo 1. pr-scan is NEVER optional. No exceptions for quick commits.
echo 2. CRITICAL issues stop everything. No other work proceeds.
echo 3. Copilot NEVER auto-fixes privacy issues. Sunil decides.
echo 4. Screenshots always flagged for manual review by Sunil.
echo 5. If in doubt, flag it. False positive costs 2 minutes.
echo    False negative could cost the project.
echo 6. This skill protects the patient, the client, the team,
echo    and Sunil personally. Run it every time without exception.
) > .skills\pr-scan.md

echo [OK] .skills\pr-scan.md created.
echo.

REM ------------------------------------------------------------
REM MORE FILES WILL BE ADDED HERE AS WE BUILD THEM
REM ------------------------------------------------------------

echo.
echo ============================================================
echo  Setup complete so far.
echo  Files created: 10 of 21
echo  Next file to be added: .skills\xlsx.md
echo ============================================================
echo.

REM ------------------------------------------------------------
REM FILE 11 — .skills\xlsx.md
REM ------------------------------------------------------------

echo Creating .skills\xlsx.md...

(
echo # xlsx.md
echo # SKILL: xlsx
echo # ================================================================
echo # HOW TO INVOKE:
echo # Read automatically when any phase needs Excel work.
echo # Manual:
echo #   "run xlsx: create reconciliation report"
echo #   "run xlsx: create run report"
echo #   "run xlsx: update {file path}"
echo #   "run xlsx: read {file path}"
echo #
echo # THIS PROJECT PRODUCES TWO EXCEL FILES:
echo #   FILE 1 - Master Reconciliation Report  (Phase 0^)
echo #   FILE 2 - Regression Run Report         (Phase 1^)
echo #
echo # LIBRARY: Apache POI XSSF for .xlsx format
echo # ALWAYS check pom.xml for version before writing any code.
echo # ================================================================
echo.
echo ---
echo.
echo ## SECTION 1 - POI DEPENDENCY CHECK
echo.
echo Step 1: Open pom.xml and search for "poi" dependency.
echo Step 2: If found, note exact version. Confirm XSSF support.
echo Step 3: If NOT found, show Sunil these dependencies and wait:
echo   ^<dependency^>
echo     ^<groupId^>org.apache.poi^</groupId^>
echo     ^<artifactId^>poi-ooxml^</artifactId^>
echo     ^<version^>{latest stable}^</version^>
echo   ^</dependency^>
echo Step 4: poi and poi-ooxml must be same version. No mixing.
echo.
echo ---
echo.
echo ## SECTION 2 - STANDARD POI PATTERNS
echo.
echo 2.1 Creating Workbook and Sheet:
echo   XSSFWorkbook workbook = new XSSFWorkbook();
echo   XSSFSheet sheet = workbook.createSheet("Sheet Name");
echo   sheet.createFreezePane(0, 1^); // freeze header row
echo   // Add auto-filter after all data is written
echo   sheet.setAutoFilter(new CellRangeAddress(0, lastRow, 0, lastCol^)^);
echo.
echo 2.2 Header Row:
echo   Row headerRow = sheet.createRow(0^);
echo   headerRow.setHeightInPoints(20^);
echo   // Create styles ONCE at top - never inside loops
echo   XSSFCellStyle headerStyle = createHeaderStyle(workbook^);
echo   for (int i = 0; i ^< headers.length; i++^) {
echo     Cell cell = headerRow.createCell(i^);
echo     cell.setCellValue(headers[i]^);
echo     cell.setCellStyle(headerStyle^); // style AFTER value
echo   }
echo.
echo 2.3 Data Rows:
echo   int rowNum = 1; // row 0 is header
echo   for (DataObject item : dataList^) {
echo     Row row = sheet.createRow(rowNum++^);
echo     Cell cell = row.createCell(0^);
echo     cell.setCellValue(item.getField()^);
echo     cell.setCellStyle(style^); // style AFTER value
echo   }
echo.
echo 2.4 Writing File:
echo   String outputPath = config.getProperty("report.outputPath"^);
echo   File outputFile = new File(outputPath + File.separator + fileName^);
echo   outputFile.getParentFile().mkdirs(); // create dir if missing
echo   try (FileOutputStream fos = new FileOutputStream(outputFile^)^) {
echo     workbook.write(fos^);
echo   } finally {
echo     workbook.close(); // always close
echo   }
echo.
echo 2.5 Safe Cell Value Reader (always use this pattern^):
echo   switch (cell.getCellType()^) {
echo     case STRING:  return cell.getStringCellValue().trim();
echo     case NUMERIC: return String.valueOf((long^) cell.getNumericCellValue()^);
echo     case BOOLEAN: return String.valueOf(cell.getBooleanCellValue()^);
echo     default:      return "";
echo   }
echo.
echo ---
echo.
echo ## SECTION 3 - COLOR CODES
echo.
echo HEADER:          #2F4F6F background, white bold font
echo GREEN  (match^):  #C6EFCE — bytes: 0xC6 0xEF 0xCE
echo YELLOW (mismatch^): #FFEB9C — bytes: 0xFF 0xEB 0x9C
echo RED  (not migrated^): #FFC7CE — bytes: 0xFF 0xC7 0xCE
echo ORANGE (split^):  #FFCC99 — bytes: 0xFF 0xCC 0x99
echo PASS STATUS:     #C6EFCE green, dark green font #006100
echo FAIL STATUS:     #FFC7CE red,   dark red font   #9C0006
echo.
echo Style creation rules:
echo - Create ALL styles ONCE at top. Never inside loops.
echo - Excel limit ~64,000 unique styles. Exceeding corrupts file.
echo - Set style AFTER setCellValue or style may not apply.
echo.
echo ---
echo.
echo ## SECTION 4 - FILE 1: MASTER RECONCILIATION REPORT
echo.
echo File name:   Reconciliation_Report_{timestamp}.xlsx
echo Sheet name:  Reconciliation
echo Phase:       Phase 0 output
echo.
echo COLUMNS (in this exact order^):
echo Col 0 - ADO Tag           width 15  e.g. @12345
echo Col 1 - ADO Title         width 50  exact title from ADO
echo Col 2 - Old Framework Title width 50 title from old .feature
echo Col 3 - New Framework Title width 50 title from new .feature
echo         If not migrated: "NOT MIGRATED"
echo Col 4 - Name Match Status  width 20
echo         Values: EXACT MATCH / NAME MISMATCH / NOT MIGRATED / STRUCTURAL SPLIT
echo Col 5 - Migration Status   width 18
echo         Values: MIGRATED / NOT MIGRATED / PARTIAL
echo Col 6 - Split Case Flag    width 15
echo         Values: YES / NO
echo Col 7 - Action Needed      width 18
echo         Values: NONE / UPDATE TITLE / MIGRATE / REVIEW SPLIT / VERIFY
echo.
echo COLOR LOGIC:
echo   NOT MIGRATED             = RED row
echo   Split YES                = ORANGE row
echo   NAME MISMATCH            = YELLOW row
echo   EXACT MATCH + MIGRATED   = GREEN row
echo   else                     = DEFAULT white
echo.
echo SUMMARY SECTION after last data row:
echo   Total test cases, Exact matches, Name mismatches,
echo   Not migrated, Structural splits, Migration complete %
echo.
echo ---
echo.
echo ## SECTION 5 - FILE 2: REGRESSION RUN REPORT
echo.
echo File name:   RunReport_{suiteName}_{timestamp}.xlsx
echo Sheet name:  Run Report
echo Phase:       Phase 1 output
echo.
echo COLUMNS (in this exact order^):
echo Col 0 - ADO Tag              width 15
echo Col 1 - ADO Title            width 50
echo Col 2 - Scenario Title       width 50  exact title from feature file
echo Col 3 - Status               width 10  PASS / FAIL / SKIP
echo         PASS=green FAIL=red SKIP=yellow background
echo Col 4 - Failure Reason       width 60  never blank for FAIL rows
echo Col 5 - Screenshot           width 40  path or "No screenshot"
echo Col 6 - Duration (sec^)       width 15  or "N/A"
echo Col 7 - Suite                width 15  regression or smoke
echo.
echo SUMMARY SHEET (second sheet named "Summary"^):
echo   Suite run, run date, total, passed, failed, skipped,
echo   pass rate %%, list of all failed test case tags and titles.
echo.
echo ---
echo.
echo ## SECTION 6 - IMPORTANT RULES
echo.
echo 1. Always check pom.xml for POI before writing any code.
echo 2. Create all styles ONCE. Never inside a loop.
echo 3. setCellStyle AFTER setCellValue. Always.
echo 4. Always close workbook in finally or try-with-resources.
echo 5. Never hardcode output path. Use config.getProperty().
echo 6. Always create output directory with mkdirs() before writing.
echo 7. Column order must match definitions above exactly.
echo 8. ADO Tag column always includes the @ symbol. Example: @12345
echo 9. Summary rows and sheets must always be present.
echo 10. Never populate cells with real patient data. Placeholders only.
) > .skills\xlsx.md

echo [OK] .skills\xlsx.md created.
echo.

REM ------------------------------------------------------------
REM MORE FILES WILL BE ADDED HERE AS WE BUILD THEM
REM ------------------------------------------------------------

echo.
echo ============================================================
echo  Setup complete so far.
echo  Files created: 11 of 21
echo  Next file to be added: .skills\docx.md
echo ============================================================
echo.

REM ------------------------------------------------------------
REM FILE 12 — .skills\docx.md
REM ------------------------------------------------------------

echo Creating .skills\docx.md...

(
echo # docx.md
echo # SKILL: docx
echo # ================================================================
echo # HOW TO INVOKE:
echo # Read automatically when any task needs a Word document.
echo # Manual:
echo #   "run docx: create kt-guide"
echo #   "run docx: create handover-report"
echo #   "run docx: create migration-report"
echo #   "run docx: create test-strategy"
echo #   "run docx: create retrospective"
echo #
echo # LIBRARY: Apache POI XWPF for .docx format
echo # Same poi-ooxml dependency as xlsx.md.
echo # If xlsx confirmed poi-ooxml this session, skip check.
echo # ================================================================
echo.
echo ---
echo.
echo ## SECTION 1 - XWPF DEPENDENCY CHECK
echo.
echo poi-ooxml covers both xlsx and docx. Same dependency.
echo If xlsx.md already confirmed it this session, skip to Section 2.
echo Otherwise check pom.xml for poi-ooxml.
echo poi and poi-ooxml must always be the same version.
echo Mismatched versions cause NoClassDefFoundError at runtime.
echo.
echo Key XWPF classes:
echo   XWPFDocument  - the Word document
echo   XWPFParagraph - a paragraph (heading or body text^)
echo   XWPFRun       - styled text run inside a paragraph
echo   XWPFTable     - a table
echo   XWPFTableRow  - a row in a table
echo   XWPFTableCell - a cell in a row
echo.
echo ---
echo.
echo ## SECTION 2 - STANDARD XWPF PATTERNS
echo.
echo 2.1 Creating a Document:
echo   XWPFDocument document = new XWPFDocument();
echo   // Set page margins (twips - 1 inch = 1440 twips^)
echo   CTSectPr sectPr = document.getDocument().getBody().addNewSectPr();
echo   CTPageMar pageMar = sectPr.addNewPgMar();
echo   pageMar.setTop(BigInteger.valueOf(1080^)^);    // 0.75 inch
echo   pageMar.setBottom(BigInteger.valueOf(1080^)^);
echo   pageMar.setLeft(BigInteger.valueOf(1260^)^);   // 0.875 inch
echo   pageMar.setRight(BigInteger.valueOf(1260^)^);
echo.
echo 2.2 Adding Title:
echo   XWPFParagraph title = document.createParagraph();
echo   title.setAlignment(ParagraphAlignment.CENTER^);
echo   XWPFRun run = title.createRun();
echo   run.setText("Title Here"^);
echo   run.setBold(true^); run.setFontSize(20^);
echo   run.setFontFamily("Calibri"^); run.setColor("2F4F6F"^);
echo.
echo 2.3 Adding Headings:
echo   // H1: bold, 14pt, color 2F4F6F
echo   // H2: bold, 12pt, color 4F6F8F
echo   XWPFParagraph h1 = document.createParagraph();
echo   XWPFRun h1run = h1.createRun();
echo   h1run.setText("Section Name"^);
echo   h1run.setBold(true^); h1run.setFontSize(14^);
echo   h1run.setColor("2F4F6F"^); h1run.setFontFamily("Calibri"^);
echo.
echo 2.4 Body Text:
echo   XWPFParagraph para = document.createParagraph();
echo   para.setSpacingAfter(120^); // space after in twips
echo   XWPFRun run = para.createRun();
echo   run.setText("Content here."^);
echo   run.setFontSize(11^); run.setFontFamily("Calibri"^);
echo.
echo 2.5 Bullet Points (simple unicode approach^):
echo   XWPFParagraph bullet = document.createParagraph();
echo   bullet.setIndentationLeft(720^); // 0.5 inch
echo   XWPFRun bRun = bullet.createRun();
echo   bRun.setText("\u2022  " + text^); // unicode bullet
echo   bRun.setFontSize(11^); bRun.setFontFamily("Calibri"^);
echo.
echo 2.6 Page Break:
echo   XWPFParagraph pb = document.createParagraph();
echo   pb.createRun().addBreak(BreakType.PAGE^);
echo.
echo 2.7 Writing File:
echo   String outputPath = config.getProperty("report.outputPath"^);
echo   File outputFile = new File(outputPath + File.separator + fileName^);
echo   outputFile.getParentFile().mkdirs();
echo   try (FileOutputStream fos = new FileOutputStream(outputFile^)^) {
echo     document.write(fos^);
echo   } finally { document.close(); }
echo.
echo ---
echo.
echo ## SECTION 3 - FIXED DOCUMENT TEMPLATE STRUCTURE
echo.
echo Every document follows this exact structure. Always.
echo.
echo PAGE 1 - COVER PAGE
echo   Document title (centered, 20pt, dark blue^)
echo   Project: MC Healthcare Portal - Automation Framework
echo   Document type: {type}
echo   Prepared by: Sunil Sagar
echo   Date: {generation date}
echo   Version: {version}
echo   Client: MC
echo   CONFIDENTIAL - For MC internal use only
echo   Page break after cover.
echo.
echo PAGE 2 - TABLE OF CONTENTS
echo   Plain text list - POI cannot auto-generate live TOC.
echo   Tell Sunil: "Press Ctrl+A then F9 in Word to update
echo   page numbers after opening the document."
echo   Page break after TOC.
echo.
echo SECTION 1 - DOCUMENT OVERVIEW
echo   1.1 Purpose  1.2 Scope  1.3 Audience  1.4 Related Documents
echo.
echo SECTION 2 - PROJECT BACKGROUND
echo   Pulled automatically from .project/knowledge.md
echo   2.1 Client and Application  2.2 Goals  2.3 Team
echo.
echo SECTION 3 - MAIN CONTENT (document-type specific - see Section 4^)
echo.
echo SECTION 4 - DECISIONS AND RATIONALE
echo   Pulled automatically from devlog.md DECISION entries
echo.
echo SECTION 5 - KNOWN ISSUES AND RISKS
echo   Pulled automatically from devlog.md RISK entries
echo.
echo SECTION 6 - LESSONS LEARNED
echo   Pulled automatically from devlog.md LEARNING entries
echo.
echo SECTION 7 - APPENDIX
echo   7.1 Glossary  7.2 Tool versions  7.3 Config reference
echo.
echo ---
echo.
echo ## SECTION 4 - PER-DOCUMENT MAIN CONTENT
echo.
echo kt-guide Section 3:
echo   3.1 Framework Architecture  3.2 How to Run Suite
echo   3.3 How to Add Test Case    3.4 How to Use Copilot Agent
echo   3.5 How to Use Skills       3.6 How to Read Reports
echo   3.7 Common Issues and Solutions
echo.
echo handover-report Section 3:
echo   3.1 Migration Summary       3.2 Framework Status
echo   3.3 Outstanding Items       3.4 Environment Setup
echo   3.5 Support and Escalation
echo.
echo migration-report Section 3:
echo   3.1 Migration Overview      3.2 Statistics (table^)
echo   3.3 Scripts Migrated        3.4 Scripts Remaining
echo   3.5 Structural Splits Resolved
echo.
echo test-strategy Section 3:
echo   3.1 Objectives  3.2 Scope  3.3 Test Types
echo   3.4 Environment 3.5 Test Data  3.6 Entry/Exit Criteria
echo   3.7 Defect Management
echo.
echo retrospective Section 3:
echo   3.1 What Went Well          3.2 What Could Be Better
echo   3.3 What We Would Do Differently
echo   3.4 Key Achievements        3.5 Recommendations
echo.
echo ---
echo.
echo ## SECTION 5 - TYPOGRAPHY STANDARDS
echo.
echo Font:        Calibri throughout
echo Title:       20pt bold #2F4F6F centered
echo H1:          14pt bold #2F4F6F
echo H2:          12pt bold #4F6F8F
echo Body:        11pt regular #000000
echo Table header: 11pt bold white on #2F4F6F
echo Table body:  10pt alternating #FFFFFF and #F2F2F2
echo Margins:     0.75in top/bottom, 0.875in left/right
echo Line spacing: 1.15 body text
echo Para spacing: 6pt after each paragraph
echo.
echo ---
echo.
echo ## SECTION 6 - IMPORTANT RULES
echo.
echo 1. Check pom.xml for poi-ooxml before writing any code.
echo    If xlsx confirmed it this session, skip the check.
echo 2. Always close XWPFDocument in finally or try-with-resources.
echo 3. Never use HWPFDocument. Always XWPFDocument for .docx.
echo 4. Document structure in Section 3 is fixed. Never deviate.
echo 5. Sections 2, 4, 5, 6 populated automatically from
echo    knowledge.md and devlog.md. Never ask Sunil for this content.
echo 6. Always include TOC manual update instruction for Sunil:
echo    "Press Ctrl+A then F9 in Word to update page numbers."
echo 7. Never put patient data or credentials in any document.
echo 8. Output path always from config.getProperty("report.outputPath"^).
echo 9. When create-doc calls this skill, use Section 4 to determine
echo    what goes in Section 3 of the document.
) > .skills\docx.md

echo [OK] .skills\docx.md created.
echo.

REM ------------------------------------------------------------
REM MORE FILES WILL BE ADDED HERE AS WE BUILD THEM
REM ------------------------------------------------------------

echo.
echo ============================================================
echo  Setup complete so far.
echo  Files created: 12 of 21
echo  Next file to be added: .skills\data-explore.md
echo ============================================================
echo.

REM ------------------------------------------------------------
REM FILE 13 — .skills\data-explore.md
REM ------------------------------------------------------------

echo Creating .skills\data-explore.md...

(
echo # data-explore.md
echo # SKILL: data-explore
echo # ================================================================
echo # HOW TO INVOKE:
echo #   "run data-explore: {file path}"
echo #   "run data-explore: {file path} full"
echo #   "run data-explore: compare {file1} {file2}"
echo #   "run data-explore: reconciliation"
echo #   "run data-explore: run-report"
echo #
echo # WHAT THIS SKILL DOES:
echo # Profiles any dataset automatically.
echo # Saves 20 minutes of manual exploratory work.
echo # Covers: file summary, column inventory, null counts,
echo # value distributions, anomalies, readiness assessment.
echo # ================================================================
echo.
echo ---
echo.
echo ## EXECUTION STEPS
echo.
echo Step 1: Identify file type (xlsx/feature/html/json/text^)
echo Step 2: Read the ENTIRE file. Never sample.
echo         400 rows is the max. Always read everything.
echo Step 3: Generate DATA PROFILE REPORT (format below^)
echo Step 4: Present to Sunil. Then ask:
echo         "Would you like me to investigate any column
echo          or anomaly further?"
echo.
echo ---
echo.
echo ## READING APPROACH BY FILE TYPE
echo.
echo Excel (.xlsx^): Apache POI XSSFWorkbook.
echo   Read every sheet. Count rows excluding header.
echo   Use safe cell value reader from xlsx.md.
echo.
echo Feature (.feature^): Java File I/O, line by line.
echo   Identify: @tags, Feature:, Scenario:, Scenario Outline:,
echo   Given/When/Then/And/But steps, Examples tables, comments.
echo.
echo HTML (.html^): Check pom.xml for jsoup first.
echo   If jsoup present: use it for parsing.
echo   If not: flag to Sunil, use regex fallback for simple patterns.
echo.
echo JSON: Use JSON library confirmed in pom.xml.
echo   Check first: org.json / Jackson / Gson. Never assume.
echo.
echo ---
echo.
echo ## DATA PROFILE REPORT FORMAT
echo.
echo ================================================
echo # DATA PROFILE REPORT
echo File:        {file name and path}
echo File type:   {xlsx/feature/html/json/text}
echo File size:   {size in KB or MB}
echo Profiled on: {date and time}
echo ================================================
echo.
echo ## 1. FILE SUMMARY
echo Total rows:    {count excluding header}
echo Total columns: {count}
echo Sheets:        {list sheet names and row counts if Excel}
echo Empty file:    {YES / NO}
echo.
echo ## 2. COLUMN INVENTORY
echo Format per column:
echo Col# ^| Name ^| Data Type ^| Populated ^| Null/Empty ^| Unique ^| Samples
echo.
echo Data Types: String / Numeric / Boolean / Date / Mixed / Empty
echo Population: count non-empty / total rows
echo Flag LOW POPULATION if rate ^< 90%
echo Flag EMPTY COLUMN if rate = 0%
echo.
echo ## 3. NULL AND EMPTY VALUE ANALYSIS
echo Columns with empty values:
echo Column Name ^| Empty Count ^| Empty %% ^| Impact
echo Impact: CRITICAL / HIGH / LOW / NONE
echo CRITICAL = required for phase to work correctly
echo HIGH     = important, gaps will cause issues
echo LOW      = optional or acceptable gaps
echo.
echo ## 4. VALUE DISTRIBUTION (KEY COLUMNS^)
echo For columns with fixed expected values show distribution.
echo.
echo Name Match Status:
echo   EXACT MATCH / NAME MISMATCH / NOT MIGRATED / STRUCTURAL SPLIT
echo   Flag UNEXPECTED VALUE if count ^> 0
echo.
echo Migration Status:
echo   MIGRATED / NOT MIGRATED / PARTIAL
echo.
echo Status (Run Report^):
echo   PASS / FAIL / SKIP - with counts and percentages
echo.
echo ## 5. ANOMALIES AND DATA QUALITY FLAGS
echo.
echo FLAG: {severity} - {column} - {description}
echo.
echo Anomaly types:
echo   DUPLICATE TAGS        - same @tag appears more than once
echo   UNEXPECTED VALUES     - value not in expected set
echo   MISSING REQUIRED DATA - required column has empty values
echo   INCONSISTENT FORMAT   - same column has mixed formats
echo   MISMATCHED COUNTS     - row count differs from expected
echo   ORPHAN RECORDS        - tag in framework not found in ADO
echo.
echo Duplicate tags = always CRITICAL. Never downgrade.
echo.
echo ## 6. FEATURE FILE ANALYSIS (feature files only^)
echo.
echo Total feature files:          {count}
echo Total scenarios:              {count}
echo Total scenario outlines:      {count}
echo Unique tags:                  {count}
echo Duplicate tags:               {count} CRITICAL if ^> 0
echo Scenarios with no tags:       {count} HIGH flag
echo Scenarios with @local:        {count}
echo Scenarios with @perfecto:     {count}
echo Scenarios with neither:       {count} MEDIUM flag
echo Scenarios with @regression:   {count}
echo Scenarios with @smoke:        {count}
echo Steps per scenario avg/max/min: flag max ^> 15
echo Empty feature files:          {count} HIGH flag
echo.
echo ## 7. READINESS ASSESSMENT
echo.
echo FOR PHASE {N} - READY / NOT READY / NEEDS ATTENTION
echo {2-4 sentences. Specific. Name blocking issues.}
echo.
echo Must resolve before proceeding: {numbered list or "None"}
echo Should resolve but not blocking: {numbered list or "None"}
echo.
echo ================================================
echo END OF DATA PROFILE REPORT
echo ================================================
echo.
echo ---
echo.
echo ## COMPARISON MODE
echo.
echo "run data-explore: compare {file1} {file2}"
echo.
echo Side by side comparison:
echo Attribute ^| File 1 ^| File 2 ^| Match?
echo Row count, Column count, Tag coverage, etc.
echo.
echo Missing in File 2: {tags in File 1 not in File 2}
echo Extra in File 2:   {tags in File 2 not in File 1}
echo.
echo Use for:
echo - Old framework vs new framework tag coverage
echo - Reconciliation report vs ADO test case list
echo - Two run reports from different dates
echo.
echo ---
echo.
echo ## SPECIFIC PROFILES
echo.
echo "run data-explore: reconciliation"
echo Additional checks:
echo - Row count matches ADO test case count from last API pull
echo - Every ADO Tag has the @ prefix
echo - No ADO Tag appears more than once
echo - Every row has ADO Title value
echo - Color coding consistent with Name Match Status
echo - Summary section present at bottom
echo - Migration percentage calculated correctly
echo.
echo "run data-explore: run-report"
echo Additional checks:
echo - Every FAIL row has non-empty Failure Reason
echo - Every FAIL row has Screenshot value
echo - Pass rate calculated correctly in Summary sheet
echo - No scenario without ADO Tag
echo - Status values only PASS FAIL SKIP
echo - Suite column populated for every row
echo.
echo ---
echo.
echo ## IMPORTANT RULES
echo.
echo 1. Always read entire file. Never sample.
echo 2. Never modify the file. READ-ONLY operation.
echo    Report anomalies. Sunil decides what to fix.
echo 3. Duplicate @tags = always CRITICAL. Never downgrade.
echo 4. Readiness assessment must be honest.
echo    False READY verdict wastes more time than hard truth.
echo 5. Healthcare project: if any column looks like real patient
echo    data, flag CRITICAL immediately and invoke pr-scan.
echo    Do not continue profile until Sunil addresses it.
echo 6. After report always ask:
echo    "Would you like me to investigate any column or anomaly?"
echo    Wait for answer before doing anything else.
) > .skills\data-explore.md

echo [OK] .skills\data-explore.md created.
echo.

REM ------------------------------------------------------------
REM MORE FILES WILL BE ADDED HERE AS WE BUILD THEM
REM ------------------------------------------------------------

echo.
echo ============================================================
echo  Setup complete so far.
echo  Files created: 13 of 21
echo  Next file to be added: .skills\create-doc.md
echo ============================================================
echo.

REM ------------------------------------------------------------
REM FILE 14 — .skills\create-doc.md
REM ------------------------------------------------------------

echo Creating .skills\create-doc.md...

(
echo # create-doc.md
echo # SKILL: create-doc
echo # ================================================================
echo # HOW TO INVOKE:
echo #   "run create-doc: kt-guide"
echo #   "run create-doc: handover-report"
echo #   "run create-doc: migration-report"
echo #   "run create-doc: test-strategy"
echo #   "run create-doc: retrospective"
echo #   "run create-doc: final project report"  (all five at once^)
echo #
echo # WHAT THIS SKILL DOES:
echo # Generates professional Word .docx files from project files.
echo # No manual writing required from Sunil.
echo # Source material is already written in the log files.
echo # This skill formats and structures it.
echo #
echo # SOURCE FILES READ:
echo #   .project/knowledge.md    - project context, team, goals
echo #   .project/devlog.md       - decisions, risks, learnings,
echo #                              milestones, mistakes
echo #   .project/handoff.md      - current project state
echo #   Reconciliation Excel     - migration statistics
echo #   Run Report Excel         - test execution statistics
echo #
echo # REQUIRES: docx.md read first this session.
echo # ================================================================
echo.
echo ---
echo.
echo ## BEFORE GENERATING ANY DOCUMENT
echo.
echo Step 1: Confirm docx.md read this session. If not, read it now.
echo Step 2: Read knowledge.md - project, client, team, goals, tools.
echo Step 3: Read devlog.md completely. Build these extraction lists:
echo         DECISIONS / RISKS / LEARNINGS / MILESTONES / MISTAKES
echo         Each with: date, phase, full description.
echo Step 4: Read handoff.md - current phase, state, open questions.
echo Step 5: Check output folder for Reconciliation Excel.
echo         If found: extract migration statistics silently.
echo Step 6: Check output folder for Run Report Excel.
echo         If found: extract pass/fail/skip counts silently.
echo Step 7: Confirm to Sunil what was found. Say:
echo "I have read all source files. Here is what I found:
echo   knowledge.md:  {N} sections
echo   devlog.md:     {N} sessions, {N} decisions, {N} risks,
echo                  {N} learnings, {N} milestones
echo   handoff.md:    current phase {name}
echo   Reconciliation Excel: {available/not available}
echo   Run Report Excel:     {available/not available}
echo Ready to generate {document type}. Shall I proceed?"
echo Step 8: Wait for Sunil to say proceed. Never start writing first.
echo.
echo ---
echo.
echo ## DOCUMENT 1 - KT GUIDE
echo.
echo Title: "Automation Framework - Knowledge Transfer Guide"
echo Audience: QA Engineers and QA Lead
echo Tone: Mid-level engineer. Every technical term explained.
echo.
echo Section 3 Main Content:
echo.
echo 3.1 Framework Architecture
echo     Three-layer table:
echo     LAYER      - FILE TYPE  - RESPONSIBILITY
echo     Feature    - .feature   - WHAT the test does
echo     Step Def   - Steps.java - BRIDGE Gherkin to Java
echo     Page Object- Pages.java - HOW Selenium + locators
echo.
echo 3.2 How to Run the Test Suite
echo     Maven commands from framework-architecture.instructions.md
echo     regression / smoke / single tag / local / Perfecto
echo     Each as a code block.
echo.
echo 3.3 How to Add a New Test Case
echo     Numbered steps 1-10:
echo     1. Create/open feature file
echo     2. Add ADO @tag
echo     3. Add suite tag
echo     4. Add execution tag
echo     5. Write Gherkin steps
echo     6. Check existing step definitions
echo     7. Add Steps.java if needed
echo     8. Add Pages.java method if needed
echo     9. Run locally first
echo     10. Verify pass then add to suite
echo.
echo 3.4 How to Use the Copilot Agent
echo     Pull from team-prompt-playbook if exists.
echo     If not: write from master prompt rules.
echo     Cover: start session, approval commands, skills, recovery.
echo.
echo 3.5 How to Use the Skills
echo     Table: Skill - Invoke Command - What It Does - When To Use
echo.
echo 3.6 How to Read the Reports
echo     Reconciliation Report: column definitions from xlsx.md Section 4
echo     Run Report: column definitions from xlsx.md Section 5
echo     Color coding guide.
echo.
echo 3.7 Common Issues and Solutions
echo     Pull from devlog.md FAILURE and MISTAKE entries.
echo     Format: Problem - Likely Cause - Solution
echo     Minimum 5 entries.
echo.
echo ---
echo.
echo ## DOCUMENT 2 - HANDOVER REPORT
echo.
echo Title: "Automation Framework - Handover Report"
echo Audience: Client MC and receiving team. Professional tone.
echo.
echo Section 3 Main Content:
echo 3.1 Migration Summary (from Reconciliation Excel if available^)
echo 3.2 Framework Status (from handoff.md^)
echo 3.3 Environment Setup Instructions
echo 3.4 Outstanding Items (from handoff.md What to do next^)
echo     Format: Item - Priority - Estimated Effort - Owner
echo 3.5 Support and Escalation
echo.
echo ---
echo.
echo ## DOCUMENT 3 - MIGRATION REPORT
echo.
echo Title: "Script Migration Report - Old Framework to New Framework"
echo Audience: Client MC and QA Lead.
echo.
echo Section 3 Main Content:
echo 3.1 Migration Overview (goal, approach, timeline^)
echo 3.2 Statistics Table (from Reconciliation Excel^):
echo     Total / Migrated / Not Migrated / Clean / Splits / Name-only
echo 3.3 Scripts Migrated Full List (MIGRATED rows from Excel^)
echo 3.4 Scripts Remaining Full List (NOT MIGRATED rows from Excel^)
echo 3.5 Structural Splits Resolved (STRUCTURAL SPLIT rows from Excel^)
echo.
echo ---
echo.
echo ## DOCUMENT 4 - TEST STRATEGY
echo.
echo Title: "Test Automation Strategy - MC Healthcare Portal"
echo Follow docx.md Section 4 test-strategy definition.
echo Pull objectives and scope from knowledge.md.
echo Pull environment from framework-architecture.instructions.md.
echo.
echo ---
echo.
echo ## DOCUMENT 5 - RETROSPECTIVE
echo.
echo Title: "Project Retrospective - MC Automation Framework"
echo Header: INTERNAL USE ONLY - Not for client distribution
echo Remind Sunil after generating: never include in client delivery.
echo.
echo Section 3:
echo 3.1 What Went Well        (from devlog MILESTONE entries^)
echo 3.2 What Could Be Better  (from devlog FAILURE entries^)
echo 3.3 What We Would Do Differently (synthesized from mistakes^)
echo 3.4 Key Achievements      (migration stats + improvements^)
echo 3.5 Recommendations       (synthesized from LEARNING entries^)
echo.
echo ---
echo.
echo ## FINAL PROJECT REPORT (all five documents^)
echo.
echo "run create-doc: final project report"
echo Generates all 5 in order: kt-guide, handover, migration,
echo strategy, retrospective.
echo After each: "{name} complete - saved to {path}"
echo After all five:
echo "All 5 documents generated.
echo  Remember: open in Word and press Ctrl+A then F9 for TOC.
echo  Run pr-scan before sharing with client or team."
echo.
echo ---
echo.
echo ## IMPORTANT RULES
echo.
echo 1. Read ALL source files before generating. Never from memory.
echo 2. Always use docx.md patterns. Never invent structure.
echo 3. Sections 2/4/5/6 come from devlog.md automatically.
echo    Never ask Sunil for decisions, risks, learnings manually.
echo 4. If devlog has no entries for a type, write:
echo    "No {type} were formally recorded during this project."
echo    Never leave a section empty.
echo 5. Never include patient data in any document.
echo    If source file has patient data, invoke pr-scan immediately.
echo 6. Retrospective = INTERNAL ONLY. Never in client delivery.
echo 7. Always run pr-scan silently on every generated document.
echo    Report only if pr-scan finds an issue.
echo 8. After every document always say:
echo    "Before sharing:
echo     1. Open in Word, Ctrl+A then F9 to update TOC
echo     2. Review all [FILL IN] placeholders
echo     3. Run pr-scan if sharing outside team
echo     4. Get client approval before sharing with MC"
) > .skills\create-doc.md

echo [OK] .skills\create-doc.md created.
echo.

REM ------------------------------------------------------------
REM MORE FILES WILL BE ADDED HERE AS WE BUILD THEM
REM ------------------------------------------------------------

echo.
echo ============================================================
echo  Setup complete so far.
echo  Files created: 14 of 21
echo  Next file to be added: .vscode\instructions\excel-output-spec.instructions.md
echo ============================================================
echo.

REM ------------------------------------------------------------
REM FILE 15 — .vscode\instructions\excel-output-spec.instructions.md
REM ------------------------------------------------------------

echo Creating .vscode\instructions\excel-output-spec.instructions.md...

(
echo # excel-output-spec.instructions.md
echo # Attach when working on Phase 0 or Phase 1 Excel output.
echo # Works alongside xlsx.md:
echo #   xlsx.md    = HOW to use Apache POI (patterns, code^)
echo #   this file  = WHAT to build (exact columns, rules, logic^)
echo # No [FILL IN] placeholders. Everything defined and ready.
echo.
echo ---
echo.
echo ## PART 1 - MASTER RECONCILIATION REPORT
echo ## Phase 0 output. Built by ReconciliationReportWriter.java
echo.
echo File name:    Reconciliation_Report_{yyyyMMdd_HHmmss}.xlsx
echo Sheet 1:      Reconciliation
echo Sheet 2:      Summary
echo Freeze pane:  Row 1 (header^)
echo Auto filter:  Applied after data written
echo.
echo COLUMNS (8 total, fixed order^):
echo.
echo COL 0 - ADO Tag          width 15
echo   Format: always @ prefix. Example: @12345
echo   Required: YES. Must be unique. Duplicate = CRITICAL stop.
echo.
echo COL 1 - ADO Title        width 50
echo   Source: ADO API testCase.name
echo   If empty: write "NO TITLE IN ADO" flag MEDIUM
echo.
echo COL 2 - Old Framework Title  width 50
echo   Source: FeatureFileParser old framework scan
echo   If not found: write "NOT IN OLD FRAMEWORK"
echo.
echo COL 3 - New Framework Title  width 50
echo   Source: NewFrameworkParser new framework scan
echo   If not found: write "NOT MIGRATED"
echo.
echo COL 4 - Name Match Status    width 22
echo   Allowed values (exact^):
echo     EXACT MATCH / NAME MISMATCH / NOT MIGRATED /
echo     STRUCTURAL SPLIT / NOT IN OLD FW
echo.
echo COL 5 - Migration Status     width 18
echo   Allowed values (exact^): MIGRATED / NOT MIGRATED / PARTIAL
echo.
echo COL 6 - Split Case Flag      width 16
echo   Allowed values (exact^): YES / NO
echo.
echo COL 7 - Action Needed        width 20
echo   Allowed values (exact^):
echo     NONE / UPDATE TITLE / MIGRATE / REVIEW SPLIT / VERIFY
echo.
echo COLOR CODING LOGIC (priority order - first match wins^):
echo RULE 1: Split Case Flag = YES         ORANGE  #FFCC99
echo RULE 2: Migration Status = NOT MIGRATED  RED  #FFC7CE font dark red #9C0006
echo RULE 3: Name Match = NAME MISMATCH   YELLOW  #FFEB9C font dark yellow #9C6500
echo RULE 4: EXACT MATCH + MIGRATED        GREEN  #C6EFCE font dark green #006100
echo RULE 5: All other cases             DEFAULT  #FFFFFF
echo HEADER: background #2F4F6F white bold 11pt Calibri thin borders
echo.
echo ROW ORDERING:
echo   1. STRUCTURAL SPLIT rows (orange^)
echo   2. NOT MIGRATED rows (red^)
echo   3. NAME MISMATCH rows (yellow^)
echo   4. EXACT MATCH rows (green^)
echo   5. DEFAULT rows
echo   Within each group: ADO Tag numerically ascending
echo.
echo SUMMARY SHEET (Sheet 2^):
echo   Report generated, Total test cases
echo   Migration: Migrated / Not migrated / Partial counts and %
echo   Match: Exact / Mismatch / Not in old FW counts and %
echo   Splits: YES / NO counts and %
echo   Action: counts per action type
echo   Overall: Migration complete %% (green^>=80 yellow^>=50 red^<50^)
echo   Col widths: labels 30, values 15, percent 12
echo.
echo ---
echo.
echo ## PART 2 - REGRESSION RUN REPORT
echo ## Phase 1 output. Built by RunReportWriter.java
echo.
echo File name:    RunReport_{suiteName}_{yyyyMMdd_HHmmss}.xlsx
echo Sheet 1:      Run Report
echo Sheet 2:      Summary
echo.
echo COLUMNS (8 total, fixed order^):
echo.
echo COL 0 - ADO Tag              width 15
echo   Always @ prefix. Required YES.
echo.
echo COL 1 - ADO Title            width 50
echo   Looked up from Reconciliation Excel using tag as key.
echo   If not found: "TITLE NOT FOUND"
echo.
echo COL 2 - Scenario Title       width 50
echo   Exact title from executed .feature file. Required YES.
echo.
echo COL 3 - Status               width 10
echo   Allowed values (exact^): PASS / FAIL / SKIP
echo   No lowercase. No other values. Required YES.
echo.
echo COL 4 - Failure Reason       width 60
echo   FAIL rows: ExceptionClass + first line of message. NEVER EMPTY.
echo   PASS rows: empty cell.
echo   Max 500 chars, truncate with ...
echo.
echo COL 5 - Screenshot           width 40
echo   FAIL rows: relative path or "No screenshot captured"
echo   PASS/SKIP: empty cell.
echo   Path format: relative, forward slashes.
echo.
echo COL 6 - Duration (sec^)       width 15
echo   Decimal seconds e.g. "12.45" or "N/A"
echo.
echo COL 7 - Suite                width 15
echo   Allowed values (exact^): regression / smoke. Required YES.
echo.
echo COLOR CODING:
echo PASS: #C6EFCE bg, #006100 font
echo FAIL: #FFC7CE bg, #9C0006 font
echo SKIP: #FFEB9C bg, #9C6500 font
echo HEADER: #2F4F6F bg, white bold 11pt Calibri
echo.
echo ROW ORDERING:
echo   1. FAIL rows first
echo   2. SKIP rows second
echo   3. PASS rows last
echo   Within each group: ADO Tag numerically ascending
echo.
echo SUMMARY SHEET (Sheet 2^):
echo   Suite, run date, report generated timestamp
echo   Results: Total / Passed %% / Failed %% / Skipped %%
echo   Pass rate: green^>=90 yellow^>=70 red^<70
echo   Failed test cases list: ADO Tag + ADO Title per fail
echo   Col widths: labels 25, values 15, percent 12
echo.
echo ---
echo.
echo ## PART 3 - SHARED RULES FOR BOTH FILES
echo.
echo 1. Output path always from config.getProperty("report.outputPath"^)
echo 2. Timestamp in every file name: yyyyMMdd_HHmmss
echo 3. Create output directory automatically: mkdirs()
echo 4. Close workbook in finally or try-with-resources
echo 5. Create ALL styles ONCE before data loop. Never inside loop.
echo    Excel limit ~64000 unique styles. Exceeding corrupts file.
echo 6. Column order fixed. Never change it.
echo 7. ADO Tag always includes @ symbol. @12345 not 12345.
echo 8. Run data-explore silently after generation. Report anomalies only.
echo 9. Run pr-scan before sharing. No patient data. No credentials.
echo 10. If both generated same session: Reconciliation first.
echo     Run Report looks up ADO Titles from Reconciliation output.
) > .vscode\instructions\excel-output-spec.instructions.md

echo [OK] .vscode\instructions\excel-output-spec.instructions.md created.
echo.

REM ------------------------------------------------------------
REM MORE FILES WILL BE ADDED HERE AS WE BUILD THEM
REM ------------------------------------------------------------

echo.
echo ============================================================
echo  Setup complete so far.
echo  Files created: 15 of 21
echo  Next file to be added: phase0-reconciliation.instructions.md
echo ============================================================
echo.

REM ------------------------------------------------------------
REM FILE 16 — .vscode\instructions\phase0-reconciliation.instructions.md
REM ------------------------------------------------------------

echo Creating .vscode\instructions\phase0-reconciliation.instructions.md...

(
echo # phase0-reconciliation.instructions.md
echo # Attach when Sunil says "start Phase 0"
echo # Attach alongside:
echo #   framework-architecture.instructions.md
echo #   ado-api-reference.instructions.md
echo #   excel-output-spec.instructions.md
echo #   .skills/xlsx.md
echo #   .skills/validation.md
echo #   .skills/standard-of-working.md
echo.
echo ---
echo.
echo ## WHAT PHASE 0 BUILDS
echo.
echo Standalone Java utility (not a test^) that:
echo   1. Scans old framework .feature files
echo   2. Scans new framework .feature files
echo   3. Calls ADO REST API for Master Test Plan test cases
echo   4. Merges all three - writes Reconciliation Excel
echo.
echo ---
echo.
echo ## 9-CLASS PLAN
echo.
echo CLASS 1 - Main.java
echo   Entry point. Reads config. Orchestrates all steps in sequence.
echo.
echo CLASS 2 - ConfigReader.java
echo   Singleton. Loads config.properties. Single access point.
echo   Methods: getInstance(), get(key), getOrDefault(key, default)
echo.
echo CLASS 3 - FeatureFileParser.java
echo   Scans folder recursively for .feature files.
echo   Extracts @tags and scenario titles. Handles all edge cases.
echo   Methods: parse(folderPath), scanFolder(folder),
echo            parseFile(file), extractTags(line), extractTitle(line)
echo.
echo CLASS 4 - FeatureScenario.java (data model^)
echo   Fields: tag, allTags, title, featureFilePath,
echo           lineNumber, isOutline, framework (OLD/NEW^)
echo.
echo CLASS 5 - ADOClient.java
echo   Calls ADO API. Handles auth, pagination, errors.
echo   Methods: fetchAllTestCases(), fetchPage(skip,top^),
echo            buildAuthHeader(), parseResponse(json^), handleError(...)
echo.
echo CLASS 6 - ADOTestCase.java (data model^)
echo   Fields: id (no @^), tag (with @^), title, url
echo.
echo CLASS 7 - ReconciliationEngine.java
echo   Merges old FW + new FW + ADO into reconciliation rows.
echo   Applies all matching and classification logic.
echo   Methods: reconcile(...^), determineNameMatchStatus(...^),
echo            determineMigrationStatus(...^), determineSplitCaseFlag(...^),
echo            determineActionNeeded(...^), detectStructuralSplits(...)
echo.
echo CLASS 8 - ReconciliationRow.java (data model^)
echo   Fields: adoTag, adoTitle, oldFrameworkTitle, newFrameworkTitle,
echo           nameMatchStatus, migrationStatus, splitCaseFlag, actionNeeded
echo.
echo CLASS 9 - ReconciliationReportWriter.java
echo   Writes Reconciliation Excel. Both sheets. All styling.
echo   Follows excel-output-spec.instructions.md exactly.
echo   Methods: write(rows, outputPath^), createReconciliationSheet(...^),
echo            createSummarySheet(...^), createStyles(wb^),
echo            getRowColor(row^), sortRows(rows^)
echo.
echo ---
echo.
echo ## RECONCILIATION LOGIC RULES
echo.
echo Rule 1 - Tag Normalization
echo   Strip @ for comparison. Store with @ in output.
echo   @12345 and 12345 are the same tag.
echo.
echo Rule 2 - Title Comparison
echo   Case-insensitive. Trim whitespace. Trailing spaces ignored.
echo.
echo Rule 3 - Name Match Status Logic
echo   Tag in OLD + NEW + ADO, all titles match: "EXACT MATCH"
echo   Tag in OLD + NEW + ADO, titles differ:    "NAME MISMATCH"
echo   Tag in OLD + ADO, not in NEW:             "NOT MIGRATED"
echo   Tag appears on 2+ scenarios in OLD:       "STRUCTURAL SPLIT"
echo   Tag in ADO but not in OLD:                "NOT IN OLD FW"
echo   STRUCTURAL SPLIT overrides all other statuses.
echo.
echo Rule 4 - Migration Status
echo   Tag found in new FW: "MIGRATED"
echo   Tag not in new FW:   "NOT MIGRATED"
echo   PARTIAL set manually by Sunil only.
echo.
echo Rule 5 - Split Case Detection
echo   Same @tag on 2+ scenarios in old FW: "YES" else "NO"
echo   Split row uses one row per tag.
echo   oldFrameworkTitle: all titles joined with " - "
echo.
echo Rule 6 - Action Needed
echo   MIGRATED + EXACT MATCH:    "NONE"
echo   MIGRATED + NAME MISMATCH:  "UPDATE TITLE"
echo   NOT MIGRATED + no split:   "MIGRATE"
echo   Split YES:                 "REVIEW SPLIT"
echo   NOT IN OLD FW:             "VERIFY"
echo.
echo ---
echo.
echo ## FEATURE FILE PARSING EDGE CASES
echo.
echo EC1: Multiple tags on one line - @12345 @regression @local
echo      Primary tag = first numeric-looking tag.
echo EC2: Tags split across multiple lines above Scenario.
echo      Collect all tag lines immediately preceding Scenario.
echo EC3: Scenario Outline - valid scenario, isOutline=true.
echo EC4: Background blocks - skip entirely. No tags.
echo EC5: Comment lines (#) - skip entirely.
echo EC6: Empty feature files - log warning, title="EMPTY FEATURE FILE"
echo EC7: Scenario with no @tag - log warning, skip scenario.
echo EC8: Same tag in multiple files - STRUCTURAL SPLIT in old FW.
echo EC9: Feature-level tags - suite tags only, not ADO IDs.
echo      ADO ID tags appear directly above Scenario lines only.
echo EC10: Examples table rows - treat entire Outline as one scenario.
echo.
echo ---
echo.
echo ## BUILD SEQUENCE
echo.
echo STEP 1: Read and confirm project structure. Wait for approval.
echo STEP 2: Present 9-class plan. Wait for approval of full plan.
echo STEP 3: Show config.properties template. Wait for values.
echo   Keys needed:
echo     reconciliation.oldFrameworkPath=[FILL IN]
echo     reconciliation.newFrameworkPath=[FILL IN]
echo     ado.org=https://dev.azure.com/MCLM
echo     ado.project=[FILL IN]
echo     ado.masterPlanId=[FILL IN]
echo     ado.masterSuiteId=[FILL IN]
echo     ado.pat=[FILL IN]
echo     report.outputPath=[FILL IN]
echo STEP 4: Check pom.xml for poi-ooxml and JSON library.
echo         Present missing deps, wait for approval before adding.
echo STEP 5: Build classes in this order:
echo   5a. FeatureScenario.java      (no dependencies^)
echo   5b. ADOTestCase.java          (no dependencies^)
echo   5c. ReconciliationRow.java    (no dependencies^)
echo   5d. ConfigReader.java         (no project dependencies^)
echo   5e. FeatureFileParser.java    (depends on FeatureScenario^)
echo   5f. ADOClient.java            (depends on ADOTestCase, ConfigReader^)
echo   5g. ReconciliationEngine.java (depends on all data models^)
echo   5h. ReconciliationReportWriter.java (depends on ReconciliationRow^)
echo   5i. Main.java                 (depends on all classes^)
echo   For each class: present plan, wait, write, explain, validate, confirm.
echo STEP 6: Test with limit=10 first. Review output. Confirm accuracy.
echo STEP 7: Full run all 400. Run data-explore. Wait for sign-off.
echo.
echo ---
echo.
echo ## PHASE 0 COMPLETION CRITERIA
echo.
echo Not complete until ALL true:
echo   1. Excel generated with no errors
echo   2. Row count matches ADO test case count
echo   3. No duplicate ADO tags
echo   4. All 8 columns present and correct
echo   5. Color coding correct per rules
echo   6. Both sheets present
echo   7. Summary statistics correct
echo   8. data-explore passes no CRITICAL anomalies
echo   9. pr-scan passes
echo   10. Sunil reviewed and confirmed output looks correct
echo.
echo ---
echo.
echo ## IMPORTANT REMINDERS
echo.
echo 1. READ-ONLY phase. Parsers never modify framework files.
echo 2. Remove test limit before full run. Never in production code.
echo 3. If ADO returns fewer than ~400 test cases, stop and alert Sunil.
echo 4. If a file cannot be read, log and continue. List skipped files.
echo 5. PAT never hardcoded, logged, or printed. config.properties only.
) > .vscode\instructions\phase0-reconciliation.instructions.md

echo [OK] .vscode\instructions\phase0-reconciliation.instructions.md created.
echo.

REM ------------------------------------------------------------
REM MORE FILES WILL BE ADDED HERE AS WE BUILD THEM
REM ------------------------------------------------------------

echo.
echo ============================================================
echo  Setup complete so far.
echo  Files created: 16 of 21
echo  Next file to be added: phase1-reporter.instructions.md
echo ============================================================
echo.

REM ------------------------------------------------------------
REM FILE 17 — .vscode\instructions\phase1-reporter.instructions.md
REM ------------------------------------------------------------

echo Creating .vscode\instructions\phase1-reporter.instructions.md...

(
echo # phase1-reporter.instructions.md
echo # Attach when Sunil says "start Phase 1"
echo # PREREQUISITE: Phase 0 must be complete.
echo # Run Report looks up ADO titles from Reconciliation Excel.
echo # Attach alongside:
echo #   framework-architecture.instructions.md
echo #   ado-api-reference.instructions.md
echo #   excel-output-spec.instructions.md
echo #   .skills/xlsx.md
echo.
echo ---
echo.
echo ## WHAT PHASE 1 BUILDS
echo.
echo Post-Run Excel Reporter that:
echo   1. Reads test results after every regression or smoke run
echo   2. Looks up ADO titles from Phase 0 Reconciliation Excel
echo   3. Generates Run Report Excel (Pass/Fail/Skip per scenario^)
echo   4. Optionally updates ADO Test Run results via API
echo      (only when Sunil says "add ADO update"^)
echo.
echo Replaces manual Excel update the team currently does after every run.
echo.
echo ---
echo.
echo ## FIRST QUESTION - EXTENTREPORTS INTEGRATION
echo.
echo Before planning anything Copilot must ask Sunil:
echo "How is ExtentReports integrated in your framework?
echo.
echo   A. Cucumber JSON generated after run, ExtentReports reads it
echo   B. EventListener class hooked into Cucumber runner
echo   C. Custom IReporterPlugin writes to ExtentReports
echo   D. Something else - please describe
echo.
echo Your answer determines how I read test results.
echo Please check your framework and confirm."
echo.
echo Wait for answer. Do not proceed until answered.
echo.
echo ---
echo.
echo ## PARSING APPROACH BY INTEGRATION TYPE
echo.
echo APPROACH A - Cucumber JSON (most common^):
echo   Source: cucumber.json (confirm exact path with Sunil^)
echo   Typical: target/cucumber-reports/cucumber.json
echo.
echo   JSON fields to extract:
echo     elements[i].name              = scenario title
echo     elements[i].tags[j].name      = tags including @12345
echo     elements[i].steps[k].result.status
echo       = passed / failed / skipped / pending / undefined
echo     elements[i].steps[k].result.error_message
echo       = failure reason (first failed step only^)
echo     elements[i].steps[k].result.duration
echo       = nanoseconds. Divide by 1_000_000_000 for seconds.
echo.
echo   Status mapping:
echo     passed    = PASS
echo     failed    = FAIL
echo     skipped   = SKIP
echo     pending   = SKIP
echo     undefined = SKIP + log warning "step definition missing"
echo.
echo   Scenario status rules:
echo     FAIL if ANY step has status failed
echo     SKIP if ALL steps are skipped or pending
echo     PASS only if ALL steps passed
echo.
echo APPROACH B/C: Copilot reads the listener/plugin class first.
echo   Ask Sunil for the file path before planning further.
echo.
echo ---
echo.
echo ## 6-CLASS PLAN
echo.
echo CLASS 1 - RunReportMain.java
echo   Entry point. Reads config. Orchestrates all steps.
echo.
echo CLASS 2 - CucumberReportParser.java
echo   Reads cucumber.json. Extracts scenario results.
echo   Methods: parse(filePath^), extractTag(tags^), extractStatus(steps^),
echo            extractFailureReason(steps^), extractDuration(steps^),
echo            findScreenshot(tag, screenshotFolder^)
echo.
echo CLASS 3 - ScenarioResult.java (data model^)
echo   Fields: adoTag, scenarioTitle, adoTitle, status,
echo           failureReason, screenshotPath, durationSeconds, suite
echo.
echo CLASS 4 - ReconciliationExcelReader.java
echo   Reads Phase 0 Excel. Builds Map^<tag, adoTitle^>.
echo   READ-ONLY. Never modifies Phase 0 output.
echo   Methods: load(filePath^), readRow(row^)
echo.
echo CLASS 5 - RunReportWriter.java
echo   Writes Run Report Excel. Both sheets. All styling.
echo   Follows excel-output-spec.instructions.md exactly.
echo   Methods: write(results, outputPath, suiteName^),
echo            createRunReportSheet(...^), createSummarySheet(...^),
echo            createStyles(wb^), sortResults(results^)
echo.
echo CLASS 6 - ADORunUpdater.java
echo   ONLY built when Sunil says "add ADO update".
echo   Do not build or plan until that instruction is given.
echo   Methods: createTestRun(...^), fetchTestPoints(...^),
echo            updateResults(...^), completeRun(runId^)
echo.
echo ---
echo.
echo ## SCREENSHOT MATCHING LOGIC
echo.
echo Ask Sunil before designing:
echo "Where does your framework save screenshots on failure?
echo  What is the naming convention?"
echo.
echo Default until answered:
echo   Folder: config.getProperty("screenshot.outputPath"^)
echo   Pattern: look for files containing the tag number
echo   Example: tag @12345 - look for file with "12345" in name
echo   If found: relative path
echo   If not found: "No screenshot captured"
echo.
echo ---
echo.
echo ## CUCUMBER RUNNER INTEGRATION OPTIONS
echo.
echo Ask Sunil where the runner class is. Read it first.
echo.
echo OPTION A: Maven Surefire post-test execution in pom.xml
echo OPTION B: @AfterAll hook in existing Hooks.java
echo OPTION C: Manual trigger - run RunReportMain standalone
echo.
echo RECOMMEND Option C first. Tell Sunil:
echo "For the first version I recommend running manually after
echo  each execution to validate accuracy first. Once confirmed
echo  accurate we add the automatic hook. Proceed with Option C?"
echo.
echo ---
echo.
echo ## BUILD SEQUENCE
echo.
echo STEP 1: Ask integration type. Read relevant files. Confirm understanding.
echo STEP 2: Check Phase 0 Reconciliation Excel exists.
echo         If missing: "Run Phase 0 first or provide Excel path."
echo STEP 3: Ask screenshot folder and naming convention.
echo STEP 4: Ask Cucumber runner location. Read it. Recommend Option C.
echo STEP 5: Present full class plan. Wait for approval.
echo STEP 6: Check pom.xml for POI and JSON library.
echo STEP 7: Build in this order:
echo   7a. ScenarioResult.java
echo   7b. ReconciliationExcelReader.java
echo   7c. CucumberReportParser.java
echo   7d. RunReportWriter.java
echo   7e. RunReportMain.java
echo   7f. ADORunUpdater.java (only if approved^)
echo   Each: present, approve, write, explain, validate, confirm.
echo STEP 8: Test with one known cucumber.json from Sunil.
echo         Show extracted results. Compare against actual run.
echo         Confirm accuracy before generating Excel.
echo STEP 9: Generate first report. data-explore. Present to Sunil.
echo STEP 10: Set up trigger after accuracy confirmed.
echo.
echo ---
echo.
echo ## PHASE 1 COMPLETION CRITERIA
echo.
echo Not complete until ALL true:
echo   1. Run Report Excel generated with no errors
echo   2. Every scenario from run appears in report
echo   3. Pass/Fail/Skip matches actual run exactly
echo   4. No FAIL row has empty Failure Reason
echo   5. ADO Title lookup works for all known tags
echo   6. Summary sheet present with correct statistics
echo   7. FAIL rows appear at top of report
echo   8. data-explore passes no CRITICAL anomalies
echo   9. pr-scan passes
echo   10. Sunil compared report against actual run and confirmed accuracy
echo.
echo ---
echo.
echo ## IMPORTANT REMINDERS
echo.
echo 1. Do not build ADORunUpdater until Sunil says "add ADO update".
echo 2. Failure reason must never be blank for FAIL rows.
echo    If no message in JSON: write "No error message captured"
echo 3. Phase 0 Reconciliation Excel is READ-ONLY from Phase 1.
echo 4. Duration in JSON is nanoseconds. Divide by 1_000_000_000.
echo    Format to 2 decimal places: "12.45" not "12.456789"
echo 5. Scenario with no @tag: write "NO TAG", never skip the row.
echo 6. Healthcare project: failure reason may contain page content.
echo    pr-scan will flag if patient data found. Address immediately.
) > .vscode\instructions\phase1-reporter.instructions.md

echo [OK] .vscode\instructions\phase1-reporter.instructions.md created.
echo.

REM ------------------------------------------------------------
REM MORE FILES WILL BE ADDED HERE AS WE BUILD THEM
REM ------------------------------------------------------------

echo.
echo ============================================================
echo  Setup complete so far.
echo  Files created: 17 of 21
echo  Next file to be added: phase2-migration.instructions.md
echo ============================================================
echo.

REM ------------------------------------------------------------
REM FILE 18 — .vscode\instructions\phase2-migration.instructions.md
REM ------------------------------------------------------------

echo Creating .vscode\instructions\phase2-migration.instructions.md...

(
echo # phase2-migration.instructions.md
echo # Attach when Sunil says "start Phase 2"
echo # PREREQUISITE: Phase 0 complete. Reconciliation Excel is work queue.
echo # Attach alongside:
echo #   framework-architecture.instructions.md
echo #   .skills/validation.md
echo #   .skills/standard-of-working.md
echo.
echo ---
echo.
echo ## WHAT PHASE 2 BUILDS
echo.
echo AI-assisted migration workflow (not a Java utility^):
echo   - Reads old framework .feature files
echo   - Generates migrated .feature files for new framework
echo   - Checks existing step definitions before proposing new ones
echo   - Sunil approves every migration before it is written
echo   - Structural splits flagged and handled with Sunil input
echo.
echo Output: new .feature files, new Steps.java/Pages.java methods
echo         (only when no existing match^), updated Reconciliation Excel
echo.
echo ---
echo.
echo ## LEARNING PHASE - MANDATORY BEFORE ANY MIGRATION
echo.
echo LEARNING STEP 1 - Read 15+ new framework feature files minimum
echo   Extract: tag format, feature naming, scenario naming,
echo   Gherkin step style, data parameters, Examples tables,
echo   file naming conventions, average steps per scenario.
echo   Present findings. Wait for Sunils confirmation.
echo.
echo LEARNING STEP 2 - Read 15+ old framework feature files minimum
echo   Extract: Quantum DSL keywords, tag structure, step text style,
echo   data handling, naming conventions.
echo   Present findings. Wait for Sunils confirmation.
echo.
echo LEARNING STEP 3 - Build Migration Mapping Table
echo   From ACTUAL examples read in Steps 1 and 2. Not invented.
echo   Format: Quantum Pattern - Gherkin Equivalent - Notes
echo   Present table. Wait for Sunils approval of the mapping.
echo   Only after this approval proceed to migration.
echo.
echo ---
echo.
echo ## MIGRATION WORKFLOW - SINGLE SCRIPT
echo.
echo PRE-MIGRATION CHECKS:
echo   CHECK 1: Read Reconciliation Excel row for this script.
echo            Note: ADO Tag, ADO Title, Split Case Flag, Action Needed.
echo   CHECK 2: Locate and read old .feature file completely.
echo   CHECK 3: Search new framework for same @tag. Build on existing.
echo.
echo CLEAN MIGRATION (Split Case Flag = NO^):
echo.
echo   STEP 1: Read old scenario - all tags, title, all steps, examples.
echo   STEP 2: Map each step using migration mapping table.
echo           Flag unmappable steps for Sunil review. Never guess.
echo   STEP 3: Check existing step definitions.
echo     Search ALL Steps.java files for EXACT annotation match.
echo     Report: "Step found in {file} line {N}" OR "NO MATCH FOUND"
echo     If no match: propose new step definition. Wait for approval.
echo   STEP 4: Check existing Pages.java methods.
echo     Search ALL Pages.java files for existing method.
echo     If no match: propose new method. Wait for approval.
echo   STEP 5: Generate migrated .feature file draft.
echo     Line 1: Feature-level tags
echo     Line 2: Feature: {ADO Title}
echo     Line 3: Empty
echo     Line 4: @{ADO Tag} @{suite tags} @{execution tag}
echo     Line 5: Scenario: {ADO Title exactly}
echo     Line 6+: Given/When/Then steps
echo     Present COMPLETE draft to Sunil with:
echo       - Changes from old framework listed
echo       - New step definitions needed (or None^)
echo       - New Pages.java methods needed (or None^)
echo     "Shall I write this to disk?" Wait for explicit approval.
echo   STEP 6: Write files after approval.
echo     Write .feature file. Write new Steps/Pages methods if approved.
echo     Update Reconciliation Excel: Migration Status = MIGRATED.
echo.
echo STRUCTURAL SPLIT WORKFLOW (Split Case Flag = YES^):
echo.
echo   STEP 1: Find ALL scenarios sharing this @tag in old framework.
echo     Present them all to Sunil with file paths and line numbers.
echo     Offer three options:
echo       Option A: Keep as one scenario - combine steps
echo       Option B: Split into N separate scenarios with same @tag
echo       Option C: Create N new ADO Test Cases (client approval needed^)
echo     Wait for Sunils decision. NEVER auto-resolve a split.
echo   STEP 2: Execute based on Sunils decision.
echo   STEP 3: Log the decision:
echo     "run project-log: decision - @{tag} split resolved Option {A/B/C}"
echo.
echo ---
echo.
echo ## BATCH PROCESSING RULES
echo.
echo FIRST 10 SCRIPTS - Individual Review Mode
echo   One at a time. Full workflow. Full approval for each.
echo   After script 10 assess accuracy with Sunil.
echo   Report: clean migrations, corrections needed, step gaps, splits.
echo   Ask: "Satisfied with accuracy? What batch size to proceed?"
echo   Wait for Sunils decision.
echo.
echo AFTER ACCURACY CONFIRMED - Batch Mode
echo   Approved batch size. Present all proposed migrations per batch.
echo   Sunil reviews batch. Approves or flags individual scripts.
echo   Batch mode STILL requires:
echo     - Step definition check for every Gherkin step
echo     - Pages.java method check for every action
echo     - pr-scan on every generated file
echo     - Reconciliation Excel update after each batch
echo.
echo ---
echo.
echo ## MIGRATION PRIORITY ORDER
echo.
echo PRIORITY 1: Action = UPDATE TITLE (already migrated, fix title only^)
echo PRIORITY 2: Action = MIGRATE, Split = NO (clean migrations^)
echo PRIORITY 3: Action = MIGRATE, Split = YES (structural splits^)
echo PRIORITY 4: Action = VERIFY (investigate before migrating^)
echo PRIORITY 5: Action = REVIEW SPLIT (flagged splits, handle last^)
echo.
echo ---
echo.
echo ## STEP DEFINITION MANAGEMENT RULES
echo.
echo RULE 1: Search ALL Steps.java files before creating any new definition.
echo         If exact annotation match found anywhere: REUSE. Never duplicate.
echo RULE 2: Annotation text must EXACTLY match Gherkin step text.
echo RULE 3: Parameters use Cucumber expression format:
echo         {string} {int} {word} - not regex unless necessary.
echo RULE 4: One method per annotation. Never two annotations on one method.
echo RULE 5: Steps.java contains ONE line only: call to Pages.java.
echo         No if/else, loops, assertions in Steps.java. Ever.
echo.
echo ---
echo.
echo ## PAGES.JAVA MANAGEMENT RULES
echo.
echo RULE 1: Search ALL Pages.java files before creating any new method.
echo RULE 2: One method per action. Never combine actions.
echo RULE 3: Locator naming follows convention in framework-architecture.md
echo RULE 4: Never use Thread.sleep(). Use WebDriverWait + ExpectedConditions.
echo RULE 5: @local vs @perfecto: if locator differs between modes,
echo         use config flag to branch inside Pages.java method.
echo.
echo ---
echo.
echo ## RECONCILIATION EXCEL UPDATE RULES
echo.
echo After every successful migration update:
echo   New Framework Title = exact Scenario title written in new FW
echo   Migration Status    = MIGRATED
echo   Name Match Status   = EXACT MATCH or NAME MISMATCH
echo   Action Needed       = NONE or UPDATE TITLE
echo.
echo Never update Excel speculatively.
echo Only after migration written to disk and confirmed by Sunil.
echo.
echo ---
echo.
echo ## PHASE 2 COMPLETION CRITERIA
echo.
echo Not complete until ALL true:
echo   1. All 400 scripts MIGRATED or deferred with documented reason
echo   2. No duplicate @tags in new framework
echo   3. No orphan Gherkin steps
echo   4. No duplicate step definitions anywhere
echo   5. Reconciliation Excel updated with final status
echo   6. pr-scan passed on all migrated feature files
echo   7. At least one full regression run completed successfully
echo   8. Sunil signed off Phase 2 complete
echo.
echo ---
echo.
echo ## IMPORTANT REMINDERS
echo.
echo 1. Never skip the learning phase. Not optional.
echo 2. ADO Title becomes the Scenario title. Source of truth for naming.
echo 3. Never delete old framework files. Only CREATE in new framework.
echo 4. Structural splits CANNOT be auto-resolved. Sunil decides always.
echo 5. Batch mode does not reduce quality. Every file validated and scanned.
echo 6. Cannot map a Quantum step: stop and ask Sunil. Never invent.
echo 7. Healthcare: Examples tables must not contain real patient data.
echo    If found: replace with placeholders and flag immediately.
) > .vscode\instructions\phase2-migration.instructions.md

echo [OK] .vscode\instructions\phase2-migration.instructions.md created.
echo.

REM ------------------------------------------------------------
REM MORE FILES WILL BE ADDED HERE AS WE BUILD THEM
REM ------------------------------------------------------------

echo.
echo ============================================================
echo  Setup complete so far.
echo  Files created: 18 of 21
echo  Next file to be added: phase3-web-healer.instructions.md
echo ============================================================
echo.

REM ------------------------------------------------------------
REM FILE 19 — .vscode\instructions\phase3-web-healer.instructions.md
REM ------------------------------------------------------------

echo Creating .vscode\instructions\phase3-web-healer.instructions.md...

(
echo # phase3-web-healer.instructions.md
echo # Attach when Sunil says "start Phase 3"
echo # PREREQUISITE: Phase 2 substantially complete.
echo # Attach alongside:
echo #   framework-architecture.instructions.md
echo #   .skills/validation.md
echo #   .skills/standard-of-working.md
echo.
echo ---
echo.
echo ## WHAT PHASE 3 BUILDS
echo.
echo Web Locator Auto-Healer for locally run web tests:
echo   1. Detects test failure due to locator not found
echo   2. Captures page DOM at point of failure
echo   3. Sends failed locator + DOM to Claude API
echo   4. Claude suggests corrected XPath
echo   5. Presents old and new locator side by side to Sunil
echo   6. Writes fix to Pages.java ONLY after Sunil approves
echo   7. Never touches Steps.java or .feature files
echo.
echo ---
echo.
echo ## FOUR MANDATORY QUESTIONS BEFORE PLANNING
echo.
echo Ask Sunil before planning anything:
echo.
echo "Q1: When a test fails due to NoSuchElementException,
echo     how is it currently handled?
echo     A. try-catch inside Pages.java method
echo     B. Cucumber @After hook checking scenario status
echo     C. TestNG ITestListener or similar
echo     D. Something else - describe
echo.
echo  Q2: At point of failure, is WebDriver still open
echo      and accessible or already closed?
echo.
echo  Q3: Does framework capture page source on failure,
echo      or only screenshots?
echo.
echo  Q4: Where is the WebDriver instance managed?
echo      (driver factory, base class, thread-local, other^)"
echo.
echo Wait for all four answers before planning anything.
echo.
echo ---
echo.
echo ## OPERATING MODES
echo.
echo MODE A - Proactive (Cucumber @After hook^):
echo   Healer runs automatically after each failed scenario.
echo   @After
echo   public void healIfFailed(Scenario scenario^) {
echo     if (scenario.isFailed()^) {
echo       LocatorHealingService.analyzeFailure(scenario, driver^);
echo     }
echo   }
echo   Captures LIVE DOM - most accurate.
echo.
echo MODE B - Reactive (standalone post-run utility^):
echo   Reads ExtentReport/cucumber.json for failures.
echo   Uses stored DOM snapshots if available.
echo.
echo Recommend Mode A if hooks available. Tell Sunil which fits.
echo Wait for approval before building.
echo.
echo ---
echo.
echo ## 7-CLASS PLAN
echo.
echo CLASS 1 - LocatorHealingService.java
echo   Orchestrates healing workflow for one failure.
echo   Methods: analyzeFailure(scenario, driver^),
echo            captureDOM(driver^), findFailedLocator(scenario^),
echo            presentFix(old, suggested, filePath^)
echo.
echo CLASS 2 - FailedLocator.java (data model^)
echo   Fields: strategy, value, variableName, className,
echo           filePath, lineNumber, errorMessage
echo.
echo CLASS 3 - ClaudeApiClient.java
echo   Sends locator + DOM to Claude API. Returns suggested XPath.
echo   Methods: suggestFix(locator, domContent^),
echo            buildPrompt(locator, domContent^),
echo            callAPI(prompt^), extractXPath(response^)
echo.
echo CLASS 4 - LocatorFinder.java
echo   Searches Pages.java files to find failed locator location.
echo   Methods: findLocatorInProject(value, pagesFolder^),
echo            searchFile(file, value^), extractVariableName(line^)
echo.
echo CLASS 5 - PagesFileUpdater.java
echo   Updates ONE locator in Pages.java. Only that line.
echo   Methods: updateLocator(old, newValue^),
echo            validateUpdate(file, varName, newValue^)
echo.
echo CLASS 6 - HealingReport.java
echo   Tracks all suggestions. Writes healing report after run.
echo   Methods: recordSuggestion(old, suggested, status^),
echo            writeReport(outputPath^)
echo.
echo CLASS 7 - HealerMain.java (Mode B only^)
echo   Standalone entry point for reactive mode.
echo.
echo ---
echo.
echo ## CLAUDE API PROMPT TEMPLATE
echo.
echo SYSTEM:
echo "You are an expert Selenium automation engineer.
echo  You are given a failed XPath and the current page DOM.
echo  Suggest the most reliable corrected XPath.
echo  Rules:
echo  1. Prefer ID-based XPath if id attribute available
echo  2. Prefer stable attributes: data-testid, aria-label, name
echo  3. Avoid positional XPaths: //div[3]
echo  4. Avoid dynamic class names
echo  5. Return ONLY the XPath string. Nothing else.
echo  Example: //button[@data-testid='submit-button']"
echo.
echo USER:
echo "Failed locator:
echo  Strategy: {strategy}
echo  Value: {value}
echo  Variable: {variableName}
echo  Error: {errorMessage}
echo.
echo  Current page DOM (relevant section^):
echo  {first 50000 chars of DOM}"
echo.
echo DOM TRUNCATION: Max 50000 characters.
echo BEFORE SENDING DOM TO CLAUDE:
echo   Strip text content of input fields and displayed values.
echo   Keep only element tags, attributes, structure.
echo   THIS IS NON-NEGOTIABLE - healthcare project.
echo   Patient data may be visible on screen in the DOM.
echo.
echo RESPONSE HANDLING:
echo   Valid XPath starting with //: use it.
echo   Multiple options: take the first.
echo   "Cannot determine": log and skip. Do not present to Sunil.
echo   API failure: log error, skip locator. Never stop test run.
echo.
echo ---
echo.
echo ## LOCATOR FINDER LOGIC
echo.
echo Parse error message for locator value:
echo   Pattern: "selector":"(.*?)"
echo   Pattern: By.xpath: (.*?)(\n or end^)
echo   Pattern: By.id: (.*?)(\n or end^)
echo.
echo Search all Pages.java files for this value.
echo   Look for: By.xpath("{value}") / By.id("{value}") etc.
echo   Return: file path, line number, variable name.
echo.
echo Confirm with Sunil:
echo "Found: Variable={name} File={path} Line={N} Value={value}
echo  Is this correct?"
echo Wait for confirmation before proceeding.
echo.
echo ---
echo.
echo ## PAGES.JAVA UPDATE RULES
echo.
echo RULE 1: Show side by side BEFORE touching any file:
echo   "Variable: {name}   File: {path}   Line: {N}
echo    OLD: {old strategy and value}
echo    NEW: {new strategy and value}
echo    Confidence: HIGH/MEDIUM   Approve? (yes/no/skip^)"
echo.
echo RULE 2: Only change the specific locator line.
echo         Every other line written back exactly as read.
echo         No reformatting. No whitespace changes.
echo.
echo RULE 3: Validate after update.
echo         New value present on expected line.
echo         Old value no longer present.
echo         Total line count matches original.
echo         If fails: restore original immediately. Alert Sunil.
echo.
echo RULE 4: Create backup before modifying: {filePath}.bak
echo         Restore from backup if Sunil rejects after write.
echo         Delete backup after Sunil confirms fix is correct.
echo.
echo RULE 5: One locator at a time. Never batch update one file.
echo.
echo ---
echo.
echo ## APPROVAL WORKFLOW
echo.
echo INTERACTIVE MODE (start here^):
echo   Present fix. Sunil types yes/no/skip.
echo   yes  = write, backup, validate
echo   no   = skip, log as REJECTED
echo   skip = add to pending list
echo.
echo BATCH REVIEW MODE (only after Sunil says "use batch mode"^):
echo   Write all suggestions to pending-fixes.json first.
echo   Sunil marks: APPROVE / REJECT / SKIP.
echo   Process APPROVE only. Never auto-process REJECT or SKIP.
echo.
echo Start with Interactive Mode always.
echo.
echo ---
echo.
echo ## BUILD SEQUENCE
echo.
echo STEP 1: Ask 4 questions. Read framework files. Confirm understanding.
echo STEP 2: Determine Mode A or B. Present recommendation. Get approval.
echo STEP 3: Present class plan. Wait for approval.
echo STEP 4: Check pom.xml for HTTP client and JSON library.
echo STEP 5: Build in order:
echo   5a. FailedLocator.java
echo   5b. LocatorFinder.java
echo   5c. ClaudeApiClient.java
echo   5d. PagesFileUpdater.java
echo   5e. HealingReport.java
echo   5f. LocatorHealingService.java
echo   5g. HealerMain.java (Mode B only^)
echo STEP 6: Test with one known failure. Walk through full workflow.
echo STEP 7: Test with 5 known failures. Review accuracy with Sunil.
echo.
echo ---
echo.
echo ## PHASE 3 COMPLETION CRITERIA
echo.
echo Not complete until ALL true:
echo   1. Detects NoSuchElementException correctly
echo   2. DOM capture returns useful content
echo   3. Claude API returns valid XPath suggestions
echo   4. Side-by-side comparison clear and readable
echo   5. Pages.java update only changes target line
echo   6. Backup and restore works correctly
echo   7. Healing report generated after each run
echo   8. pr-scan passes on all modified Pages.java files
echo   9. Sunil approved 5+ fixes and confirmed they work at runtime
echo.
echo ---
echo.
echo ## CRITICAL REMINDERS
echo.
echo 1. Phase 3 ONLY touches Pages.java. Never Steps.java or .feature.
echo 2. Claude API config in config.properties:
echo    claude.api.url=https://api.anthropic.com/v1/messages
echo    claude.model=claude-sonnet-4-20250514
echo    Never hardcode. Never log the API key.
echo 3. DOM stripped of patient data BEFORE sending to Claude.
echo    Remove: input field values, displayed labels, table text.
echo    Keep: element tags, attributes, structure only.
echo 4. Check ZScaler whitelist FIRST:
echo    "Is api.anthropic.com whitelisted in ZScaler?"
echo    If not: Phase 3 cannot proceed. No workarounds.
) > .vscode\instructions\phase3-web-healer.instructions.md

echo [OK] .vscode\instructions\phase3-web-healer.instructions.md created.
echo.

REM ------------------------------------------------------------
REM MORE FILES WILL BE ADDED HERE AS WE BUILD THEM
REM ------------------------------------------------------------

echo.
echo ============================================================
echo  Setup complete so far.
echo  Files created: 19 of 21
echo  Next file to be added: phase4-perfecto-healer.instructions.md
echo ============================================================
echo.

REM ------------------------------------------------------------
REM FILE 20 — .vscode\instructions\phase4-perfecto-healer.instructions.md
REM ------------------------------------------------------------

echo Creating .vscode\instructions\phase4-perfecto-healer.instructions.md...

(
echo # phase4-perfecto-healer.instructions.md
echo # Attach when Sunil says "start Phase 4"
echo # PREREQUISITE: Phase 3 complete and stable.
echo # Phase 4 reuses classes from Phase 3.
echo #
echo # CRITICAL: Phase 4 is ALWAYS reactive - no live DOM.
echo # DOM snapshots retrieved AFTER Perfecto session ends.
echo # HUMAN-IN-THE-LOOP MANDATORY FOR EVERY SINGLE FIX.
echo # No exceptions. No batch auto-apply. Ever.
echo.
echo ---
echo.
echo ## WHAT PHASE 4 BUILDS
echo.
echo Perfecto Mobile Locator Healer:
echo   1. Reads Perfecto session IDs from failed runs
echo   2. Retrieves post-session DOM snapshots from Perfecto
echo   3. Sends failed mobile locator + DOM to Claude API
echo   4. Claude suggests corrected mobile locator
echo   5. Presents old and new locator side by side to Sunil
echo   6. Writes fix to Pages.java ONLY after explicit approval
echo   7. Every fix individually approved - no exceptions
echo.
echo REUSED FROM PHASE 3:
echo   PagesFileUpdater.java (unchanged^)
echo   HealingReport.java (extended^)
echo   FailedLocator.java (extended with mobile fields^)
echo   ClaudeApiClient.java (extended with mobile prompt^)
echo.
echo NEW FOR PHASE 4:
echo   PerfectoSessionClient.java
echo   PerfectoSession.java
echo   PerfectoDOMExtractor.java
echo   MobileLocatorHealingService.java
echo   MobileHealerMain.java
echo.
echo ---
echo.
echo ## FIVE MANDATORY QUESTIONS BEFORE PLANNING
echo.
echo "Q1: How do you access post-session DOM snapshots from Perfecto?
echo     A. Perfecto REST API - programmatic download
echo     B. Manual download from dashboard as XML/HTML
echo     C. Both - prefer programmatic
echo     D. Not sure - need to check with admin
echo.
echo  Q2: What locator strategies are used for mobile?
echo     A. XPath
echo     B. resource-id
echo     C. accessibility-id
echo     D. name
echo     E. class name
echo.
echo  Q3: Mobile and web locators in same Pages.java class or separate?
echo     A. Same class - branching for web vs mobile
echo     B. Separate classes - MobilePage.java vs WebPage.java
echo     C. Mixed
echo.
echo  Q4: What is your Perfecto host URL?
echo     Format: {yourcloud}.perfectomobile.com
echo.
echo  Q5: Is perfecto.securityToken already in config.properties?"
echo.
echo Wait for all five answers before planning anything.
echo.
echo ---
echo.
echo ## PERFECTO API REFERENCE
echo.
echo Authentication:
echo   perfecto.host=[FILL IN]
echo   perfecto.securityToken=[FILL IN - never hardcode]
echo   Header: PERFECTO-AUTHORIZATION: {token}
echo.
echo Endpoints:
echo   List failed executions:
echo   GET https://{host}/services/executions
echo   Params: securityToken, startTime, endTime, status=FAILED
echo.
echo   Get execution report:
echo   GET https://{host}/services/reports/{executionId}
echo   Params: securityToken, format=xml
echo.
echo   Download DOM artifacts:
echo   GET https://{host}/services/executions/{executionId}/artifacts
echo   Params: securityToken, type=DOM
echo.
echo IMPORTANT: Perfecto API varies by cloud version.
echo Before writing PerfectoSessionClient:
echo   Ask Sunil for sample API response from their instance.
echo   Do not assume endpoint format. Read actual docs first.
echo.
echo ---
echo.
echo ## MOBILE LOCATOR STRATEGIES
echo.
echo ANDROID preference order:
echo   1. resource-id (most stable^)
echo      //*[@resource-id='com.example.app:id/element']
echo   2. content-desc (accessibility-id^)
echo      //*[@content-desc='login_button']
echo   3. text (fallback^)
echo      //*[@text='Login']
echo   4. class + index (last resort^)
echo      Never use - fragile
echo.
echo IOS preference order:
echo   1. accessibility-id //*[@name='login_button']
echo   2. label //XCUIElementTypeButton[@label='Login']
echo   3. type + index - never use
echo.
echo ---
echo.
echo ## CLAUDE MOBILE PROMPT TEMPLATE
echo.
echo SYSTEM:
echo "You are an expert Appium mobile test automation engineer.
echo  You are given a failed mobile locator and app DOM (XML hierarchy^).
echo  Suggest the most reliable corrected locator.
echo.
echo  Android rules:
echo  1. Prefer resource-id: //*[@resource-id='...']
echo  2. Prefer content-desc: //*[@content-desc='...']
echo  3. Use text as fallback: //*[@text='...']
echo  4. Never use position-based XPath
echo.
echo  iOS rules:
echo  1. Prefer accessibility id: //*[@name='...']
echo  2. Use label as fallback: //XCUIElementTypeButton[@label='...']
echo  3. Never use index-based XPath
echo.
echo  Return ONLY the corrected XPath. Nothing else."
echo.
echo USER:
echo "Platform: {ANDROID or IOS}
echo  Strategy: {strategy}
echo  Value: {value}
echo  Variable: {variableName}
echo  Error: {errorMessage}
echo  App: {appPackage}
echo  Device: {deviceModel}
echo  OS: {osVersion}
echo.
echo  App DOM (relevant section, sensitive data stripped^):
echo  {max 50000 chars}"
echo.
echo ---
echo.
echo ## DOM SENSITIVITY RULES FOR MOBILE
echo.
echo BEFORE sending DOM to Claude - strip these attributes:
echo   text="[^"]*"   → replace with text=""
echo   value="[^"]*"  → replace with value=""
echo   label="[^"]*"  → replace with label=""
echo.
echo KEEP: resource-id, content-desc, class, bounds, enabled, clickable
echo.
echo Runs in PerfectoDOMExtractor.stripSensitiveContent()
echo If stripping fails for any reason: SKIP that DOM.
echo Log: "DOM stripping failed for session {id} - skipped."
echo NEVER send unstripped DOM to Claude.
echo.
echo ---
echo.
echo ## MANDATORY INDIVIDUAL APPROVAL - NO EXCEPTIONS
echo.
echo RULE 1: No batch mode for Phase 4. Ever.
echo         Every fix presented individually. Every fix approved individually.
echo.
echo RULE 2: Side by side format:
echo "================================================
echo  MOBILE LOCATOR FIX - {ANDROID or IOS}
echo  ================================================
echo  Test:     {test name}
echo  Device:   {device model}
echo  OS:       {OS version}
echo  Session:  {executionId}
echo.
echo  Variable: {variableName}
echo  File:     {filePath}
echo  Line:     {lineNumber}
echo.
echo  OLD: {old strategy} - {old value}
echo  NEW: {new strategy} - {new value}
echo.
echo  Confidence: HIGH / MEDIUM / LOW
echo  Reason: {why suggested}
echo.
echo  WARNING: Verify on Perfecto device after applying.
echo  Approve? (yes / no / skip^)"
echo.
echo RULE 3: LOW confidence - extra confirmation required:
echo   "LOW confidence fix. Strongly recommend manual verification
echo    on Perfecto device before approving. Sure? (yes/no^)"
echo.
echo RULE 4: After every approval:
echo   "Fix written. IMPORTANT: Not verified at runtime yet.
echo    Run on Perfecto and confirm it passes before marking healed."
echo.
echo RULE 5: Never auto-approve even if same fix approved before.
echo         Each fix presented individually. Always.
echo.
echo ---
echo.
echo ## BUILD SEQUENCE
echo.
echo STEP 1: Ask 5 questions. Read Pages.java mobile structure.
echo         Confirm mobile/web separation approach.
echo STEP 2: Ask Sunil for sample Perfecto API response.
echo         Do not write PerfectoSessionClient until confirmed.
echo STEP 3: Check ZScaler whitelist:
echo   "{host}.perfectomobile.com whitelisted for outbound calls?"
echo   If not: fall back to manual DOM folder approach.
echo   Build config option: perfecto.domSource=API or MANUAL_FOLDER
echo STEP 4: Present full class plan. Wait for approval.
echo STEP 5: Check pom.xml. No new dependencies expected.
echo STEP 6: Build in order:
echo   6a. Extend FailedLocator.java with mobile fields
echo   6b. PerfectoSession.java
echo   6c. PerfectoDOMExtractor.java
echo   6d. PerfectoSessionClient.java
echo   6e. Extend ClaudeApiClient.java
echo   6f. MobileLocatorHealingService.java
echo   6g. MobileHealerMain.java
echo STEP 7: Test with one known Perfecto session ID.
echo         Walk through retrieval, stripping, Claude suggestion.
echo         DO NOT write any fix to disk in test run. Observe only.
echo STEP 8: Full healing run. Present every fix individually.
echo.
echo ---
echo.
echo ## PHASE 4 COMPLETION CRITERIA
echo.
echo Not complete until ALL true:
echo   1. Perfecto session retrieval works
echo   2. DOM download and parsing works
echo   3. Sensitive data stripping verified before Claude call
echo   4. Claude returns valid mobile XPath suggestions
echo   5. Side-by-side clear with platform context
echo   6. Pages.java update works (from Phase 3^)
echo   7. Every fix individually presented - no auto-apply
echo   8. Healing report includes all mobile attempts
echo   9. pr-scan passes on all modified Pages.java files
echo   10. Sunil approved 3+ fixes confirmed passing on Perfecto
echo.
echo ---
echo.
echo ## CRITICAL REMINDERS
echo.
echo 1. ALWAYS reactive. No live DOM for Perfecto. Ever.
echo 2. Human approval MANDATORY. Mobile healing is higher risk.
echo    Wrong locator passes one device, fails another.
echo 3. stripSensitiveContent() runs EVERY time before Claude call.
echo    If it fails: skip, log, never send unstripped DOM.
echo 4. perfecto.securityToken in config.properties only.
echo    Never hardcode. Never log. Never print.
echo 5. Runtime verification on Perfecto required after every fix.
echo 6. iOS and Android DOM structure are different.
echo    PerfectoDOMExtractor detects platform from DOM content.
echo    Passes platform flag to ClaudeApiClient for correct prompt.
echo    Never send Android DOM with iOS instructions or vice versa.
echo 7. ZScaler fallback must be built as config option:
echo    perfecto.domSource=API or MANUAL_FOLDER
echo    perfecto.manualDomFolder=[FILL IN if manual mode]
) > .vscode\instructions\phase4-perfecto-healer.instructions.md

echo [OK] .vscode\instructions\phase4-perfecto-healer.instructions.md created.
echo.

REM ------------------------------------------------------------
REM MORE FILES WILL BE ADDED HERE AS WE BUILD THEM
REM ------------------------------------------------------------

echo.
echo ============================================================
echo  Setup complete so far.
echo  Files created: 20 of 21
echo  Next file to be added: team-prompt-playbook.instructions.md
echo ============================================================
echo.

REM ------------------------------------------------------------
REM FILE 21 — .vscode\instructions\team-prompt-playbook.instructions.md
REM ------------------------------------------------------------

echo Creating .vscode\instructions\team-prompt-playbook.instructions.md...

(
echo # team-prompt-playbook.instructions.md
echo # ================================================================
echo # THIS FILE IS FOR THE TEAM - NOT FOR COPILOT
echo # Knowledge Transfer guide for QA Engineers and QA Lead.
echo # Read this before your first Copilot session.
echo # Keep it open while you work.
echo # Written by: Sunil Sagar
echo # ================================================================
echo.
echo ---
echo.
echo ## SECTION 1 - BEFORE YOU START
echo.
echo Copilot on this project is set up with special instructions.
echo It knows our framework, rules, and goals.
echo Think of it as a capable junior engineer who:
echo   - Knows the entire codebase
echo   - Never forgets the rules
echo   - Always asks before doing anything
echo   - Needs YOUR approval before touching any file
echo   - Will not make decisions on your behalf
echo You are always in charge. Copilot assists. You decide.
echo.
echo Copilot will NOT:
echo   - Write code without your approval
echo   - Modify files without showing you first
echo   - Push anything to the repository
echo   - Assume things it has not read from your files
echo If it ever tries: type "stop" immediately.
echo.
echo ---
echo.
echo ## SECTION 2 - HOW TO START A SESSION
echo.
echo Step 1: Open VS Code with BOTH frameworks visible in workspace.
echo Step 2: Open Copilot Chat (Ctrl+Shift+I^)
echo Step 3: Copilot reads .github/copilot-instructions.md automatically.
echo         If context seems missing: copy and paste that file manually.
echo Step 4: Attach relevant instruction file using paperclip icon:
echo   Phase 0: phase0-reconciliation.instructions.md
echo   Phase 1: phase1-reporter.instructions.md
echo   Phase 2: phase2-migration.instructions.md
echo   Phase 3: phase3-web-healer.instructions.md
echo   Phase 4: phase4-perfecto-healer.instructions.md
echo Step 5: Type: "Read .project/handoff.md and .project/daily-log.md
echo          and tell me where we left off."
echo Step 6: Tell Copilot what to do today.
echo.
echo ---
echo.
echo ## SECTION 3 - APPROVAL COMMANDS
echo.
echo proceed          - approve a plan
echo build this       - approve code to be written
echo stop             - pause everything immediately
echo stop, change X to Y - reject and change something
echo resume           - continue after a stop
echo skip this        - defer current item, move to next
echo question: {X}   - ask without triggering any action
echo show me the plan - see what Copilot plans without doing it
echo show me what was changed this session - list all file changes
echo.
echo ---
echo.
echo ## SECTION 4 - HOW TO USE THE SKILLS
echo.
echo DAILY (use every session^):
echo   "run end-session"
echo     BEFORE every /clear or close. Non-negotiable.
echo     Updates daily log, appends devlog, writes handoff note.
echo.
echo   "run end-session: status"
echo     At session START if you forgot end-session last time.
echo     Reads and summarizes logs without writing anything.
echo.
echo QUALITY (run when needed^):
echo   "run validation"          - checks last output against all rules
echo   "run pr-scan"             - privacy check BEFORE every git push
echo   "run data-explore: {file}" - profiles Excel or feature files
echo.
echo LOGGING (use mid-session^):
echo   "run project-log: milestone - {achievement}"
echo   "run project-log: decision - {what and why}"
echo   "run project-log: risk - {risk description}"
echo.
echo DOCUMENTATION (end of project^):
echo   "run create-doc: kt-guide"
echo   "run create-doc: handover-report"
echo   "run create-doc: migration-report"
echo   "run create-doc: final project report"  (all five at once^)
echo.
echo ---
echo.
echo ## SECTION 5 - WHEN SOMETHING GOES WRONG
echo.
echo Copilot going off track:
echo   Type "stop" then "what did you just do and why"
echo   Revert unapproved changes manually using git.
echo.
echo Placeholder code found (// TODO^):
echo   stop - you have placeholder code in the file.
echo   Complete every placeholder before we continue.
echo.
echo Duplicate step definition:
echo   Causes: AmbiguousStepDefinitionsException on run.
echo   "stop - duplicate step definition found.
echo    Search all Steps.java files for matching annotations.
echo    Show me every match."
echo   Remove the new duplicate. Keep the original.
echo.
echo Copilot assuming instead of reading:
echo   "do not assume. read the actual file at {path}
echo    and tell me exactly what you found."
echo.
echo Copilot forgot project context:
echo   "re-read .project/knowledge.md and
echo    .github/copilot-instructions.md and confirm
echo    you understand the project context."
echo.
echo Accidentally cleared chat:
echo   Start new session. Paste master prompt.
echo   "run end-session: status" to see log state.
echo   "run project-log: note - session cleared accidentally.
echo    Last state: {describe what you were doing}"
echo.
echo ---
echo.
echo ## SECTION 6 - COMMON MISTAKES TO AVOID
echo.
echo MISTAKE 1: Clearing chat without running end-session.
echo   Fix: run end-session BEFORE every /clear. No exceptions.
echo.
echo MISTAKE 2: Approving code without reading it.
echo   Fix: Read every section. Ask "question: explain {section}"
echo        if unclear. Never proceed on code you have not read.
echo.
echo MISTAKE 3: Skipping learning phase in Phase 2.
echo   Fix: "do not skip learning phase. read 15 files from each
echo         framework first then present findings."
echo.
echo MISTAKE 4: Pushing without pr-scan.
echo   Fix: Always run pr-scan before every git push.
echo        Never commit without client approval.
echo.
echo MISTAKE 5: Accepting Phase 4 mobile fix without Perfecto run.
echo   Fix: After every fix, run test on Perfecto. Confirm it passes.
echo.
echo MISTAKE 6: Editing devlog.md manually.
echo   Fix: Never edit devlog.md directly.
echo        Use: "run project-log: note - {your note}"
echo.
echo MISTAKE 7: Asking multiple questions at once.
echo   Fix: One question at a time. Wait for answer before next.
echo.
echo ---
echo.
echo ## SECTION 7 - FAQ
echo.
echo Q: How do I know which phase to work on?
echo A: "run end-session: status" at session start.
echo.
echo Q: Can I work on multiple phases in one session?
echo A: Yes but only move to next phase when current meets completion criteria.
echo.
echo Q: AmbiguousStepDefinitionsException - what does this mean?
echo A: Duplicate step definition created during migration.
echo    See Section 5. Must be fixed before any tests can run.
echo.
echo Q: The reconciliation Excel shows NOT MIGRATED but I already migrated.
echo A: "update reconciliation Excel for tag @{tag}.
echo     Migration status should be MIGRATED.
echo     New framework title is: {exact title}"
echo.
echo Q: Can I ask Copilot general coding questions?
echo A: Yes. For general tasks no instruction files needed.
echo.
echo Q: ADO title is very long. Can I shorten the Scenario title?
echo A: No. Scenario title must match ADO title exactly.
echo    Raise title changes with QA Lead. Change in ADO first.
echo.
echo Q: What is the difference between daily-log and devlog?
echo A: daily-log = last 5 sessions. Quick reference.
echo    devlog = permanent full history. Never deleted.
echo.
echo ---
echo.
echo ## QUICK REFERENCE CARD
echo.
echo START OF SESSION:
echo   1. Open VS Code - both frameworks visible
echo   2. Attach instruction file for today phase
echo   3. "read .project/handoff.md and tell me where we left off"
echo.
echo APPROVAL COMMANDS:
echo   proceed / build this / stop / stop change X to Y / resume
echo.
echo SKILLS:
echo   run end-session          use BEFORE /clear every time
echo   run end-session: status  check state at session start
echo   run pr-scan              before every git push
echo   run validation           quality check on last output
echo   run data-explore: {file} profile a dataset
echo.
echo END OF SESSION:
echo   1. "run end-session"
echo   2. Wait for all three steps
echo   3. Answer ADO push question
echo   4. Wait for final confirmation
echo   5. NOW you can /clear or close VS Code
echo.
echo EMERGENCY: Something wrong? Type "stop" immediately.
echo.
echo ---
echo.
echo ## CONTACTS
echo.
echo Project lead:  Sunil Sagar - Automation and Performance Tester
echo                Escalate all framework questions to Sunil first.
echo Client:        MC team - all changes need client approval
echo                before pushing to shared repository.
echo ADO questions: Check ADO Wiki first.
echo Perfecto:      Check with your Perfecto admin.
) > .vscode\instructions\team-prompt-playbook.instructions.md

echo [OK] .vscode\instructions\team-prompt-playbook.instructions.md created.
echo.

REM ============================================================
REM ALL 21 FILES COMPLETE
REM ============================================================

echo.
echo ============================================================
echo  MC PROJECT COPILOT WORKSPACE SETUP COMPLETE
echo ============================================================
echo.
echo  All 21 files created successfully:
echo.
echo  .project\
echo    knowledge.md
echo    handoff.md          (empty - filled by end-session^)
echo    devlog.md           (empty - filled by project-log^)
echo    daily-log.md        (empty - filled by wrap-session^)
echo.
echo  .skills\
echo    session-end.md
echo    wrap-session.md
echo    project-log.md
echo    end-session.md
echo    validation.md
echo    standard-of-working.md
echo    pr-scan.md
echo    xlsx.md
echo    docx.md
echo    data-explore.md
echo    create-doc.md
echo.
echo  .vscode\instructions\
echo    framework-architecture.instructions.md
echo    ado-api-reference.instructions.md
echo    excel-output-spec.instructions.md
echo    phase0-reconciliation.instructions.md
echo    phase1-reporter.instructions.md
echo    phase2-migration.instructions.md
echo    phase3-web-healer.instructions.md
echo    phase4-perfecto-healer.instructions.md
echo    team-prompt-playbook.instructions.md
echo.
echo  .github\
echo    copilot-instructions.md  (paste your master prompt here^)
echo.
echo ============================================================
echo  NEXT STEPS:
echo  1. Open .vscode\instructions\framework-architecture.instructions.md
echo     and fill in all [FILL IN] placeholders with your actual paths
echo  2. Open .vscode\instructions\ado-api-reference.instructions.md
echo     and fill in your ADO project name and plan IDs
echo  3. Paste your master prompt into .github\copilot-instructions.md
echo  4. Open VS Code and start your first session
echo  5. Give the team-prompt-playbook to your team before KT
echo ============================================================
echo.

REM Create empty placeholder files for log files
echo. > .project\handoff.md
echo. > .project\devlog.md
echo. > .project\daily-log.md

echo  Empty log files created. They will be populated by Copilot.
echo.

REM ============================================================
REM BONUS — .github\copilot-instructions.md
REM The master prompt. Copilot reads this automatically.
REM ============================================================

echo Creating .github\copilot-instructions.md...

(
echo You are a senior Java automation engineer assistant working inside
echo my test automation project in VS Code.
echo.
echo STRICT OPERATING RULES - READ THESE FIRST BEFORE DOING ANYTHING:
echo.
echo 1. NEVER write, generate, modify, delete, or suggest any code unless
echo    I explicitly say "proceed" or "build this".
echo 2. NEVER assume anything about my project structure, file names, class
echo    names, method names, folder paths, or configurations.
echo    Always read the actual files first.
echo 3. NEVER skip any file or folder. Read every single file line by line.
echo 4. NEVER make a decision on my behalf. Present every step first.
echo    Wait for my approval before doing anything.
echo 5. NEVER hallucinate dependencies, libraries, or methods.
echo    If unsure whether something exists, go read the file first.
echo 6. NEVER use placeholder code like // TODO or // add logic here.
echo    Every piece of code must be complete and functional.
echo 7. NEVER combine multiple steps. One step at a time. Always.
echo 8. If unsure about anything - STOP and ask. Do not guess.
echo 9. Think out loud. Tell me what you are about to do and why.
echo    Then wait for me to say proceed.
echo 10. If I say "stop" - stop immediately, summarize, wait.
echo.
echo ---
echo.
echo YOUR ROLE:
echo.
echo NEW FRAMEWORK: Java Selenium BDD Cucumber (currently active^)
echo OLD FRAMEWORK: Quantum + Perfecto (being sunset^)
echo Both frameworks are in this VS Code workspace.
echo.
echo Full project context: .project/knowledge.md
echo Read this at every session start before anything else.
echo.
echo PHASES (start only when I say "start Phase X"^):
echo PHASE 0 - Reconciliation Engine
echo PHASE 1 - Post-Run Excel Reporter
echo PHASE 2 - AI-Assisted Migration Engine
echo PHASE 3 - Web Locator Auto-Healer
echo PHASE 4 - Perfecto Mobile Locator Healer
echo.
echo ---
echo.
echo THREE-LAYER ARCHITECTURE:
echo.
echo LAYER 1 - Feature Files (.feature^) - WHAT the test does
echo LAYER 2 - Steps.java - BRIDGE between Gherkin and Java
echo LAYER 3 - Pages.java - HOW - all Selenium and all locators
echo.
echo NO SHARED LIBRARY FOLDER. Step reuse is automatic via matching
echo Gherkin text. Always search ALL Steps.java files before creating
echo any new step definition. Duplicate = AmbiguousStepDefinitionsException.
echo.
echo Rules:
echo - Locators: Pages.java ONLY. Never Steps.java or .feature files.
echo - Never modify Steps.java without checking Pages.java it calls.
echo - Never modify Pages.java without checking Steps.java that calls it.
echo - Never create a duplicate step definition. Ever.
echo.
echo ---
echo.
echo SKILLS:
echo.
echo AUTOMATIC (no invocation needed^):
echo   .skills/validation.md      - run before EVERY "task complete"
echo   .skills/pr-scan.md         - run before ANY commit suggestion
echo   .skills/standard-of-working.md - apply to ALL Java code
echo.
echo ON-DEMAND (run when I type the command^):
echo   "run end-session"        - .skills/end-session.md
echo   "run wrap-session"       - .skills/wrap-session.md
echo   "run project-log: {x}"   - .skills/project-log.md
echo   "run session-end"        - .skills/session-end.md
echo   "run data-explore: {x}"  - .skills/data-explore.md
echo   "run create-doc: {x}"    - .skills/create-doc.md
echo.
echo READ-BEFORE-USE:
echo   .skills/xlsx.md  - read before any Excel work
echo   .skills/docx.md  - read before any Word document work
echo.
echo ---
echo.
echo SESSION START CHECKLIST:
echo.
echo 1. Say: "Starting session. Reading project context now."
echo 2. Read FIRST:
echo    .project/knowledge.md   (project context^)
echo    .project/handoff.md     (where we left off^)
echo    .project/daily-log.md   (last 5 sessions^)
echo    .skills/standard-of-working.md (keep active^)
echo 3. Present one paragraph summary of current project state.
echo 4. Ask: "Which phase are we working on today?"
echo 5. Wait for my answer.
echo 6. Then run mandatory project reading Steps 1-7 including Step 5B.
echo 7. Present complete summary. Wait for my confirmation.
echo.
echo MANDATORY PROJECT READING STEPS:
echo Step 1: Full folder structure - list everything, confirm with me.
echo Step 2: Every .feature file in OLD FRAMEWORK - path, tags, titles.
echo Step 3: Every .feature file in NEW FRAMEWORK - same as Step 2.
echo Step 4: Every Pages.java - class name, path, every locator.
echo Step 5: Every Steps.java - all method signatures and annotations.
echo Step 5B: Trace every Steps method to Pages method. Build full map:
echo          Gherkin Step - Steps.java method - Pages.java method - Locators
echo Step 6: All config files - every key-value pair.
echo Step 7: pom.xml - every dependency and version.
echo.
echo ---
echo.
echo COMMUNICATION RULES:
echo - Plain English always. Explain technical terms immediately.
echo - Plans in numbered lists. One atomic step per number.
echo - Code always followed by plain English explanation.
echo - Unsure: "I am not sure about X, can you clarify?"
echo - Done: "Task complete. Here is what was done: [summary]."
echo - Never "I assumed". Always "I read file X and found Y".
echo - Never more than one class or decision at a time.
echo - Slow and correct beats fast and broken.
echo.
echo ---
echo.
echo I am ready to start. Please begin the Session Start Checklist now.
) > .github\copilot-instructions.md

echo [OK] .github\copilot-instructions.md created.
echo.
echo ============================================================
echo  COMPLETE SETUP DONE - ALL 22 FILES CREATED
echo ============================================================
echo.

REM ============================================================
REM ADDITIONAL FILES — GAP FILL (4 new files)
REM ============================================================

REM FILE 22 — .skills\pr-workflow.md
echo Creating .skills\pr-workflow.md...
(
echo # pr-workflow.md
echo # SKILL: pr-workflow
echo # Invoke: "run pr-workflow" / "run pr-workflow: create-branch"
echo # "run pr-workflow: raise-pr" / "run pr-workflow: check-pr"
echo # "run pr-workflow: merge-confirm"
echo #
echo # Guides complete git + ADO PR workflow.
echo # Replaces manual PR process currently done by the team.
echo # Copilot NEVER runs git commands automatically.
echo # Copilot NEVER raises PR without explicit approval.
echo # Copilot NEVER merges without client sign-off confirmed.
echo.
echo ## STAGE 1 - CREATE BRANCH
echo Ask: type of work (feature/fix/maintenance/regression^)
echo Ask: ADO Work Item or Test Case ID
echo Present branch name following convention:
echo   feature/TC-{id}-{short-description}
echo   fix/TC-{id}-{short-description}
echo   maintenance/TC-{id}-{short-description}
echo   regression/{date}-{suite-name}
echo Present git commands. Wait for Sunil to confirm branch created.
echo   git checkout main
echo   git pull origin main
echo   git checkout -b {branch name}
echo.
echo ## STAGE 2 - COMMIT
echo Commit message format:
echo   {type}: {description} [TC-{id}]
echo   - {what changed}
echo   - {why changed}
echo   - {what else affected}
echo Types: feat / fix / maint / test / docs / config
echo Run pr-scan before every commit. Never commit if pr-scan fails.
echo.
echo ## STAGE 3 - PUSH BRANCH
echo Present: git push origin {branch name}
echo Confirm this does NOT merge to main.
echo Wait for Sunil confirmation.
echo.
echo ## STAGE 4 - RAISE PR IN ADO
echo Check: pr-scan passed and branch pushed.
echo Call ADO API:
echo POST https://dev.azure.com/{org}/{project}/_apis/git/repositories/
echo      {repositoryId}/pullrequests?api-version=7.0
echo Body: title, description, sourceRefName, targetRefName, reviewers
echo Present full PR details. Wait for explicit "yes" before API call.
echo Config keys needed:
echo   ado.repositoryId=[FILL IN]
echo   ado.reviewerIds=[FILL IN - comma separated]
echo   ado.defaultBranch=main
echo.
echo ## STAGE 5 - REVIEW AND MERGE
echo "run pr-workflow: check-pr" calls ADO API for PR status.
echo "run pr-workflow: merge-confirm" checks all criteria:
echo   All reviewers approved / No conflicts / Policies met
echo   pr-scan passed / Client approval confirmed
echo Present git merge commands. Never run automatically.
echo ALWAYS remind: client approval required before merge to main.
echo.
echo ## RULES
echo 1. Copilot NEVER runs git commands automatically.
echo 2. pr-scan MUST pass before any commit or PR.
echo 3. Client approval required before merging to main. Always.
echo 4. PR description must include ADO Test Case ID.
echo 5. Never push directly to main. Branch and PR always.
echo 6. Reviewer IDs in config.properties once, reused every time.
) > .skills\pr-workflow.md
echo [OK] .skills\pr-workflow.md created.
echo.

REM FILE 23 — .skills\locator-change-log.md
echo Creating .skills\locator-change-log.md...
(
echo # locator-change-log.md
echo # SKILL: locator-change-log
echo # Invoke: "run locator-log" / "run locator-log: manual"
echo # "run locator-log: view {module}" / "run locator-log: report"
echo #
echo # Maintains Locator_Change_Log.xlsx automatically.
echo # Replaces the manual Excel the team currently maintains.
echo # Runs automatically after every Phase 3 and Phase 4 fix.
echo # APPEND ONLY. Never overwrite. Never delete past entries.
echo.
echo ## TARGET FILE
echo File: Locator_Change_Log.xlsx
echo Path: config.getProperty("report.outputPath"^)
echo Sheet 1: Change Log
echo Sheet 2: Summary by Module (regenerated on each append^)
echo.
echo ## COLUMNS (12 total, fixed order^)
echo COL 0  - ID              (auto-increment^)        width 8
echo COL 1  - Date            (DD-MMM-YYYY^)           width 14
echo COL 2  - Module          (from Pages.java class^) width 25
echo COL 3  - Pages.java File (filename only^)         width 35
echo COL 4  - Locator Variable (exact var name^)       width 30
echo COL 5  - Old Locator     (strategy: value^)       width 60
echo COL 6  - New Locator     (strategy: value^)       width 60
echo COL 7  - Reason for Change                        width 45
echo   Allowed: "UI CHANGE" / "AUTO-HEALED Phase 3" /
echo            "AUTO-HEALED Phase 4" / "MANUAL FIX" /
echo            "MIGRATION" / "REFACTOR"
echo COL 8  - Platform  (WEB/MOBILE-ANDROID/MOBILE-IOS/BOTH^) width 18
echo COL 9  - ADO Tag   (@12345^)                      width 12
echo COL 10 - Approved By (default: Sunil Sagar^)      width 20
echo COL 11 - Notes                                    width 50
echo.
echo ## AUTOMATIC RUN (Phase 3 and Phase 4^)
echo After every approved locator fix, append automatically:
echo   Phase 3: Reason = "AUTO-HEALED - Phase 3 web locator healing"
echo            Platform = "WEB"
echo   Phase 4: Reason = "AUTO-HEALED - Phase 4 Perfecto mobile healing"
echo            Platform = "MOBILE-ANDROID" or "MOBILE-IOS"
echo Copilot says after appending:
echo "Locator change logged. Entry ID: {N}. Excel updated."
echo.
echo ## MANUAL ENTRY
echo "run locator-log: manual" - asks 8 questions one at a time:
echo   1. Pages.java file  2. Variable name  3. Old locator
echo   4. New locator      5. Reason         6. Platform
echo   7. ADO tag          8. Notes
echo Present entry. Wait for approval. Then append.
echo.
echo ## VIEW COMMAND
echo "run locator-log: view {module}" - shows all changes for module
echo Most recent first. Readable format in chat.
echo.
echo ## RULES
echo 1. APPEND ONLY. Past entries are permanent audit trail.
echo 2. Module name from Pages.java class - strip Page suffix, add spaces.
echo 3. Never log patient data in any column. Technical info only.
echo 4. Summary sheet regenerated fresh on every append.
echo 5. If file missing: create with headers first, then append.
) > .skills\locator-change-log.md
echo [OK] .skills\locator-change-log.md created.
echo.

REM FILE 24 — .skills\module-change-log.md
echo Creating .skills\module-change-log.md...
(
echo # module-change-log.md
echo # SKILL: module-change-log
echo # Invoke: "run module-log: {module name}"
echo # "run module-log: update {module name}"
echo # "run module-log: all"
echo # "run module-log: new-tester {module name}"
echo #
echo # Per-module change history for team reference.
echo # A new tester reads this FIRST before working on a module.
echo # Target file: .project/module-change-log.md
echo # NEW ENTRIES PREPENDED (newest first^) within each module.
echo.
echo ## CHANGE TYPES (use exactly one^)
echo MIGRATION     - script migrated from old to new framework
echo LOCATOR-FIX   - locator updated due to UI change or healing
echo METHOD-CHANGE - Pages.java method logic modified
echo STEP-CHANGE   - Steps.java method modified
echo FEATURE-EDIT  - .feature file steps added/removed/modified
echo TITLE-UPDATE  - scenario title updated to match ADO
echo TEST-ADDED    - new test case added to module
echo TEST-REMOVED  - test case removed or deprecated
echo KNOWN-ISSUE   - flaky test or known failure documented
echo REFACTOR      - code improved without behaviour change
echo CONFIG-CHANGE - module-specific config changed
echo.
echo ## ENTRY FORMAT
echo ### [{date}] {type} - {short description}
echo Phase:      {phase or MANUAL}
echo Changed by: Sunil Sagar
echo Files:      {files touched}
echo What:       {what changed}
echo Why:        {why it changed}
echo Impact:     {what else may be affected}
echo Watch out:  {what next person should know - NEVER leave blank}
echo.
echo ## AUTOMATIC TRIGGERS
echo After Phase 2 migration: append MIGRATION entry
echo After Phase 3 fix: append LOCATOR-FIX entry
echo After Phase 4 fix: append LOCATOR-FIX entry (mobile^)
echo After reconciliation title update: append TITLE-UPDATE entry
echo.
echo ## NEW TESTER BRIEFING
echo "run module-log: new-tester {module}" generates:
echo   Current state / Files to work with / Recent changes (last 3^)
echo   Known issues / Locator changes this month / Before you start steps
echo   Combines: module-change-log + Locator_Change_Log + knowledge.md
echo.
echo ## RULES
echo 1. Lives in .project/ - it is a living project document.
echo 2. Newest entries PREPENDED within each module section.
echo 3. Module name consistent always - human readable, no Page suffix.
echo 4. Watch out field is most important - never blank.
echo 5. Safe to share with new team members - technical only.
echo 6. New tester briefing reads THREE sources:
echo    module-change-log.md + Locator_Change_Log.xlsx + knowledge.md
) > .skills\module-change-log.md
echo [OK] .skills\module-change-log.md created.
echo.

REM FILE 25 — .vscode\instructions\git-ado-workflow.instructions.md
echo Creating .vscode\instructions\git-ado-workflow.instructions.md...
(
echo # git-ado-workflow.instructions.md
echo # Attach when doing any git work, PRs, or ADO repo activity.
echo # Attach alongside: pr-workflow.md, pr-scan.md, ado-api-reference.md
echo # Fill in all [FILL IN] before using.
echo.
echo ## REPOSITORY DETAILS
echo ADO Organization:  https://dev.azure.com/MCLM
echo ADO Project:       [FILL IN]
echo Repository name:   [FILL IN]
echo Repository ID:     [FILL IN]
echo Default branch:    main
echo Remote URL:        [FILL IN]
echo.
echo ## BRANCH STRATEGY
echo main - protected. No direct push. Ever.
echo All changes via branch and PR.
echo.
echo Branch types:
echo   feature/TC-{id}-{description}     migration work
echo   fix/TC-{id}-{description}         locator/bug fixes
echo   maintenance/TC-{id}-{description} refactoring
echo   regression/{date}-{suite}         regression related
echo.
echo Branch naming rules:
echo   Lowercase always. Hyphens not underscores.
echo   Max 60 characters. Always include TC reference.
echo   Good: fix/TC-12345-login-button-xpath-update
echo   Bad:  Fix_LoginButton / sunil-working-branch
echo.
echo ## COMMIT MESSAGE FORMAT
echo {type}: {description in present tense} [TC-{id}]
echo.
echo - {what changed}
echo - {why changed}
echo - {what affected}
echo.
echo Types: feat / fix / maint / test / docs / config
echo First line max 72 chars. Present tense. No period at end.
echo.
echo ## PR TEMPLATE
echo Every PR must include:
echo   Summary (2-3 sentences^)
echo   Checklist of what was changed (feature/steps/pages/config/logs^)
echo   Test cases covered (tag, title, status after change^)
echo   Type of change (migration/locator fix/new test/maintenance^)
echo   Checklist: pr-scan passed, tests pass locally, no duplicates,
echo              reconciliation updated, client approval received
echo   Reviewer notes
echo.
echo ## REVIEWER ASSIGNMENT
echo Primary:   [FILL IN - QA Lead ADO user ID]
echo Secondary: [FILL IN - second QA engineer ADO user ID]
echo Locator-only changes: one reviewer sufficient
echo Migration changes: both reviewers required
echo Config changes: Sunil reviews first, QA Lead mandatory
echo.
echo ## FULL WORKFLOW
echo START:
echo   git checkout main / git pull origin main
echo   git checkout -b {branch name}
echo   git branch --show-current (confirm^)
echo.
echo DURING:
echo   git status / git add {specific files} / git status again
echo   run pr-scan - must pass before commit
echo   git commit -m "{type}: {desc} [TC-{id}]" -m "- {detail}"
echo.
echo PUSH AND PR:
echo   git push origin {branch name}
echo   run pr-workflow: raise-pr
echo   run locator-log (if locators changed^)
echo   run module-log: update {module}
echo   Notify reviewers with PR URL
echo.
echo REVIEW AND MERGE:
echo   Respond to comments on same branch
echo   run pr-workflow: check-pr
echo   Get client approval - document with project-log
echo   Merge via ADO dashboard (preferred^)
echo   Delete branch after confirmed merge
echo   Update Reconciliation Excel if migration PR
echo.
echo ## HOTFIX PROCESS
echo Branch: fix/TC-{id}-hotfix-{description}
echo Minimal change only. pr-scan must pass. One reviewer minimum.
echo Notify QA Lead immediately. Document in project-log.
echo.
echo ## WHAT COPILOT WILL AND WILL NOT DO
echo WILL: show git commands / build PR description / call ADO API /
echo       check PR status / run pr-scan / update change logs
echo WILL NOT: run git commands / push to main / merge without approval /
echo           skip pr-scan / create PR without description review
echo.
echo ## COMMON MISTAKES
echo 1. Never git add . blindly - always add specific files
echo 2. Never push directly to main - branch and PR always
echo 3. Never commit without pr-scan - 30 seconds, no excuses
echo 4. Never merge without client approval - contractual requirement
echo 5. Never delete branch before confirming merge succeeded
echo 6. Never use generic commit messages - always include TC reference
) > .vscode\instructions\git-ado-workflow.instructions.md
echo [OK] .vscode\instructions\git-ado-workflow.instructions.md created.
echo.

REM Create empty module change log placeholder
echo. > .project\module-change-log.md

echo.
echo ============================================================
echo  ALL 25 FILES CREATED SUCCESSFULLY
echo ============================================================
echo.

pause
