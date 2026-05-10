@echo off
REM ============================================================
REM MC-Automation-Framework — Complete Project Setup
REM Built by: Sunil Sagar — Automation and Performance Tester
REM Client: MC (Healthcare)
REM
REM INSTRUCTIONS:
REM 1. Place this file anywhere on your machine
REM 2. Double-click to run
REM 3. The entire project is created at:
REM    C:\Users\sunsagar\Sunil\Mayo\Automation\MC-Automation-Framework
REM 4. Copy the MC-Automation-Framework folder to your ODC machine
REM 5. On ODC machine: double-click MC-Automation-Framework.code-workspace
REM 6. VS Code opens with everything ready
REM ============================================================

echo.
echo ============================================================
echo  MC-Automation-Framework — Project Setup
echo  Creating complete project structure...
echo ============================================================
echo.

REM ------------------------------------------------------------
REM CREATE FULL DIRECTORY STRUCTURE
REM ------------------------------------------------------------

set ROOT=C:\Users\sunsagar\Sunil\Mayo\Automation\MC-Automation-Framework

if not exist "C:\Users\sunsagar\Sunil\Mayo\Automation" (
    mkdir "C:\Users\sunsagar\Sunil\Mayo\Automation"
    echo [OK] Created Automation folder
)

if not exist "%ROOT%" mkdir "%ROOT%"
if not exist "%ROOT%\.github" mkdir "%ROOT%\.github"
if not exist "%ROOT%\.vscode" mkdir "%ROOT%\.vscode"
if not exist "%ROOT%\.vscode\instructions" mkdir "%ROOT%\.vscode\instructions"
if not exist "%ROOT%\.project" mkdir "%ROOT%\.project"
if not exist "%ROOT%\.skills" mkdir "%ROOT%\.skills"
if not exist "%ROOT%\output" mkdir "%ROOT%\output"
if not exist "%ROOT%\output\reports" mkdir "%ROOT%\output\reports"
if not exist "%ROOT%\output\screenshots" mkdir "%ROOT%\output\screenshots"

echo [OK] Folder structure created
echo.
echo     C:\Users\sunsagar\Sunil\Mayo\Automation\
echo     └── MC-Automation-Framework\
echo         ├── .github\
echo         ├── .vscode\
echo         │   └── instructions\
echo         ├── .project\
echo         ├── .skills\
echo         └── output\
echo             ├── reports\
echo             └── screenshots\
echo.

REM ------------------------------------------------------------
REM VS CODE WORKSPACE FILE
REM Opens both frameworks + this project in one VS Code window
REM ------------------------------------------------------------

echo Creating MC-Automation-Framework.code-workspace...

(
echo {
echo   "folders": [
echo     {
echo       "name": "MC-Automation-Framework (Copilot Setup^)",
echo       "path": "."
echo     },
echo     {
echo       "name": "Old Framework (Patient_Portal_Automation^)",
echo       "path": "C:\\[FILL IN — confirm old framework path on ODC machine]"
echo     },
echo     {
echo       "name": "New Framework (Personalized_Plus^)",
echo       "path": "C:\\[FILL IN — confirm new framework path on ODC machine]"
echo     }
echo   ],
echo   "settings": {
echo     "editor.fontSize": 14,
echo     "editor.wordWrap": "on",
echo     "editor.formatOnSave": false,
echo     "files.autoSave": "off",
echo     "github.copilot.enable": {
echo       "*": true
echo     },
echo     "github.copilot.chat.welcomeMessage": "always",
echo     "workbench.colorTheme": "Default Dark Modern",
echo     "explorer.confirmDelete": true,
echo     "explorer.confirmDragAndDrop": true,
echo     "editor.rulers": [72],
echo     "files.exclude": {
echo       "**/.git": true,
echo       "**/target": true,
echo       "**/*.class": true
echo     }
echo   },
echo   "extensions": {
echo     "recommendations": [
echo       "github.copilot",
echo       "github.copilot-chat",
echo       "vscjava.vscode-java-pack",
echo       "cucumberopen.cucumber-official",
echo       "redhat.java",
echo       "vscjava.vscode-maven"
echo     ]
echo   }
echo }
) > "%ROOT%\MC-Automation-Framework.code-workspace"

echo [OK] MC-Automation-Framework.code-workspace created
echo.

REM ------------------------------------------------------------
REM README.md — Team onboarding guide
REM ------------------------------------------------------------

echo Creating README.md...

(
echo # MC-Automation-Framework
echo.
echo ## What is this?
echo.
echo This folder contains the AI-powered Copilot setup for the
echo MC Healthcare Portal automation project.
echo It does NOT contain the test framework code itself.
echo The test frameworks are in separate folders:
echo   Old Framework: Patient_Portal_Automation (or confirm on ODC^)
echo   New Framework: Personalized_Plus (or confirm on ODC^)
echo.
echo This folder contains:
echo   - Copilot instructions and context files
echo   - Reusable skills for the team
echo   - Project memory (logs, handoff notes^)
echo   - Phase instruction files
echo   - Output folder for generated reports
echo.
echo ## How to open this project
echo.
echo 1. Double-click MC-Automation-Framework.code-workspace
echo 2. VS Code opens with all three folders visible
echo 3. Copilot reads .github/copilot-instructions.md automatically
echo 4. Read .vscode/instructions/team-prompt-playbook.instructions.md
echo    before your first session
echo.
echo ## Before your first session
echo.
echo Fill in these placeholders:
echo   .vscode\instructions\framework-architecture.instructions.md
echo     - Replace [FILL IN] with actual folder paths
echo     - Confirm old and new framework folder names
echo.
echo   .vscode\instructions\ado-api-reference.instructions.md
echo     - Replace [FILL IN] with ADO project name and plan IDs
echo.
echo   .vscode\instructions\git-ado-workflow.instructions.md
echo     - Replace [FILL IN] with repository ID and reviewer IDs
echo.
echo   MC-Automation-Framework.code-workspace
echo     - Replace [FILL IN] with actual framework folder paths
echo.
echo ## Folder structure
echo.
echo .github\
echo   copilot-instructions.md     Master prompt - auto-loaded by Copilot
echo.
echo .vscode\instructions\
echo   framework-architecture      Project folder structure and layers
echo   ado-api-reference           ADO REST API endpoints and auth
echo   excel-output-spec           Excel column definitions and colors
echo   phase0-reconciliation       Phase 0 build guide
echo   phase1-reporter             Phase 1 build guide
echo   phase2-migration            Phase 2 build guide
echo   phase3-web-healer           Phase 3 build guide
echo   phase4-perfecto-healer      Phase 4 build guide
echo   git-ado-workflow            Git and PR workflow rules
echo   team-prompt-playbook        Team guide - read before first session
echo.
echo .project\
echo   knowledge.md                Project context - Copilot reads this first
echo   handoff.md                  Where we left off - updated each session
echo   devlog.md                   Permanent project log - never deleted
echo   daily-log.md                Last 5 sessions rolling window
echo   module-change-log.md        Per-module change history
echo.
echo .skills\
echo   end-session                 Daily shutdown ritual
echo   wrap-session                Updates rolling daily log
echo   project-log                 Appends to permanent devlog
echo   session-end                 Handoff note + ADO push prompt
echo   validation                  Quality gate - runs before task complete
echo   standard-of-working         Coding conventions and naming rules
echo   pr-scan                     Privacy check before every commit
echo   pr-workflow                 Complete git and PR workflow
echo   xlsx                        Apache POI Excel patterns
echo   docx                        Apache POI Word document patterns
echo   data-explore                Dataset profiling and analysis
echo   create-doc                  Generates final project documentation
echo   locator-change-log          Tracks all locator changes automatically
echo   module-change-log           Per-module change history skill
echo.
echo output\
echo   reports\                    Generated Excel reports land here
echo   screenshots\                Test failure screenshots land here
echo.
echo ## Project phases
echo.
echo Phase 0 - Reconciliation Engine
echo   Builds master Excel mapping ADO, old framework, new framework
echo.
echo Phase 1 - Post-Run Excel Reporter
echo   Auto-generates Pass/Fail Excel after every regression run
echo.
echo Phase 2 - AI-Assisted Migration Engine
echo   Migrates 400 scripts from old framework to new framework
echo.
echo Phase 3 - Web Locator Auto-Healer
echo   Detects and fixes broken XPath locators for local web tests
echo.
echo Phase 4 - Perfecto Mobile Locator Healer
echo   Detects and fixes broken locators for Perfecto mobile tests
echo.
echo ## Contact
echo.
echo Project lead: Sunil Sagar - Automation and Performance Tester
echo All framework questions: escalate to Sunil first
echo Client changes: require MC approval before push to main
) > "%ROOT%\README.md"

echo [OK] README.md created
echo.

REM ------------------------------------------------------------
REM .github\copilot-instructions.md — Master prompt
REM ------------------------------------------------------------

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
echo 6. NEVER use placeholder code like "// TODO" or "// add logic here".
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
echo   .skills/validation.md          - run before EVERY "task complete"
echo   .skills/pr-scan.md             - run before ANY commit suggestion
echo   .skills/standard-of-working.md - apply to ALL Java code
echo.
echo ON-DEMAND (run when I type the command^):
echo   "run end-session"            - .skills/end-session.md
echo   "run wrap-session"           - .skills/wrap-session.md
echo   "run project-log: {x}"       - .skills/project-log.md
echo   "run session-end"            - .skills/session-end.md
echo   "run data-explore: {x}"      - .skills/data-explore.md
echo   "run create-doc: {x}"        - .skills/create-doc.md
echo   "run pr-workflow"            - .skills/pr-workflow.md
echo   "run pr-workflow: {x}"       - .skills/pr-workflow.md
echo   "run locator-log"            - .skills/locator-change-log.md
echo   "run locator-log: {x}"       - .skills/locator-change-log.md
echo   "run module-log: {x}"        - .skills/module-change-log.md
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
echo    .project/knowledge.md        (project context^)
echo    .project/handoff.md          (where we left off^)
echo    .project/daily-log.md        (last 5 sessions^)
echo    .skills/standard-of-working.md (keep active^)
echo 3. Present one paragraph summary of current project state.
echo 4. Ask: "Which phase are we working on today?"
echo 5. Wait for my answer.
echo 6. Then run mandatory project reading Steps 1-7 including Step 5B.
echo 7. Present complete summary. Wait for my confirmation.
echo.
echo MANDATORY PROJECT READING STEPS:
echo Step 1: Full folder structure - list everything, confirm with me.
echo Step 2: Every .feature in OLD FRAMEWORK - path, tags, titles.
echo Step 3: Every .feature in NEW FRAMEWORK - same as Step 2.
echo Step 4: Every Pages.java - class name, path, every locator.
echo Step 5: Every Steps.java - all method signatures and annotations.
echo Step 5B: Trace every Steps method to Pages method. Build full map:
echo          Gherkin Step - Steps.java method - Pages.java method - Locators
echo Step 6: All config files - every key-value pair.
echo Step 7: pom.xml - every dependency and version.
echo.
echo ---
echo.
echo PHASE 3 AND PHASE 4 AUTO-RUN RULE:
echo After every approved and written locator fix (web or mobile^):
echo   Automatically run locator-change-log skill - updates Excel
echo   Automatically run module-change-log skill - updates module log
echo   Do not ask permission. Do not skip. Always runs after every fix.
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
) > "%ROOT%\.github\copilot-instructions.md"

echo [OK] .github\copilot-instructions.md created
echo.

REM ------------------------------------------------------------
REM .vscode\settings.json
REM ------------------------------------------------------------

echo Creating .vscode\settings.json...

(
echo {
echo   "editor.fontSize": 14,
echo   "editor.wordWrap": "on",
echo   "editor.formatOnSave": false,
echo   "files.autoSave": "off",
echo   "editor.rulers": [72],
echo   "explorer.confirmDelete": true,
echo   "explorer.confirmDragAndDrop": true,
echo   "files.exclude": {
echo     "**/.git": true,
echo     "**/target": true,
echo     "**/*.class": true
echo   },
echo   "search.exclude": {
echo     "**/target": true,
echo     "**/*.class": true
echo   }
echo }
) > "%ROOT%\.vscode\settings.json"

echo [OK] .vscode\settings.json created
echo.

REM ------------------------------------------------------------
REM .project FILES
REM ------------------------------------------------------------

echo Creating .project files...

(
echo # knowledge.md
echo # Project Knowledge Base - Copilot Context File
echo # Read by GitHub Copilot at the start of every session.
echo # Never delete. Update when anything changes.
echo.
echo ---
echo.
echo ## WHO I AM
echo.
echo - Name: Sunil Sagar
echo - Role: Automation and Performance Tester
echo - I am the sole builder of this automation system.
echo - The team of 5 QA Engineers and 1 Lead will use what I build.
echo - I am responsible for KT to the team on how to use this system.
echo.
echo ---
echo.
echo ## THE CLIENT
echo.
echo - Client codename: MC
echo - Domain: Healthcare
echo - Application type: Web application and Mobile application
echo - What it does: Patient-facing healthcare portal where patients
echo   log in to check messages, view test results, create and manage
echo   appointments, and track personal health records.
echo - Primary end users: Patients
echo.
echo ---
echo.
echo ## THE TEAM
echo.
echo - 5 QA Engineers + 1 QA Lead = 6 members total
echo - All work in Java. All tooling must be Java only.
echo - Not all comfortable with Python. No Python in this project.
echo.
echo ---
echo.
echo ## THE PROJECT
echo.
echo - Old Framework: Quantum + Perfecto
echo   Folder: Patient_Portal_Automation (confirm on ODC machine^)
echo   Runs on Perfecto ONLY. Cannot run locally.
echo   Real physical mobile devices in Perfecto lab.
echo.
echo - New Framework: Java + Selenium + BDD Cucumber
echo   Folder: Personalized_Plus (confirm on ODC machine^)
echo   Supports @local and @perfecto execution modes.
echo   Three-layer architecture: .feature / Steps.java / Pages.java
echo   No shared library folder. Step reuse via matching Gherkin text.
echo.
echo ---
echo.
echo ## THE PROBLEM WE ARE SOLVING
echo.
echo 1. Dual framework maintenance - regression and maintenance in both
echo 2. ADO title mismatch - scenario titles dont match ADO test case titles
echo 3. Manual Excel reporting - Pass/Fail updated manually after every run
echo 4. Locator breakage - XPaths break, manually found and fixed
echo 5. Migration backlog - 400 scripts need moving to new framework
echo    30 percent clean migrations / 70 percent structural splits
echo.
echo ---
echo.
echo ## THE ULTIMATE GOAL
echo.
echo - Migrate all 400 scripts to new framework
echo - Sunset old framework completely
echo - Reduce maintenance effort to near zero
echo - Excel Pass/Fail updates automatically from HTML report
echo - Single framework, single source of truth
echo.
echo ---
echo.
echo ## ADO SETUP
echo.
echo - Organization URL: https://dev.azure.com/MCLM
echo - Project: [FILL IN]
echo - Tags in feature files map 1:1 to ADO Test Case IDs
echo - Master Test Plan - query-based suite - source of truth
echo - Per-release Test Plan - cloned from master - used for regression
echo - PAT: read from config.properties only. Never hardcode.
echo.
echo ---
echo.
echo ## TOOLS AND ACCESS
echo.
echo - Azure DevOps: full access, read and write via PAT
echo   ONLY tool for this project. No JIRA. No Figma here.
echo - Perfecto Lab: real physical mobile devices
echo   Post-session DOM snapshots accessible
echo - GitHub Copilot: VS Code with Claude Sonnet and Opus
echo - ZScaler: all internet filtered through ZScaler
echo   Only whitelisted URLs accessible
echo.
echo ---
echo.
echo ## ENVIRONMENT CONSTRAINTS
echo.
echo 1. No new tools without client approval. Check pom.xml first.
echo 2. No direct internet. ZScaler only. No workarounds.
echo 3. Client approves all changes. Never auto-commit or auto-push.
echo 4. All code in Java only. Batch .bat for Windows utilities only.
echo 5. Code must be understandable by mid-level QA engineer.
echo.
echo ---
echo.
echo ## REPORTING
echo.
echo - ExtentReports HTML generated after every run
echo - Team manually updates Excel with Pass/Fail - TO BE AUTOMATED
echo - Target: Excel auto-updates after every run with zero manual effort
echo.
echo ---
echo.
echo ## OUTPUT PATHS
echo.
echo report.outputPath=C:\Users\sunsagar\Sunil\Mayo\Automation\MC-Automation-Framework\output\reports
echo screenshot.outputPath=C:\Users\sunsagar\Sunil\Mayo\Automation\MC-Automation-Framework\output\screenshots
echo.
echo ---
echo.
echo ## PHASES
echo.
echo PHASE 0 - Reconciliation Engine
echo PHASE 1 - Post-Run Excel Reporter
echo PHASE 2 - AI-Assisted Migration Engine
echo PHASE 3 - Web Locator Auto-Healer
echo PHASE 4 - Perfecto Mobile Locator Healer
echo.
echo ---
echo.
echo ## CRITICAL REMINDERS
echo.
echo 1. HEALTHCARE project. Patient data privacy non-negotiable.
echo    pr-scan before every commit. No exceptions.
echo 2. @tags are ADO Test Case IDs. Sacred. Never change them.
echo 3. No shared library. Reuse via matching Gherkin text.
echo    Search all Steps.java before creating any new step.
echo 4. Never auto-commit, auto-push, or overwrite silently.
echo    Every change presented and approved by Sunil first.
echo 5. When in doubt, stop and ask. Slow and correct always wins.
) > "%ROOT%\.project\knowledge.md"

echo. > "%ROOT%\.project\handoff.md"
echo. > "%ROOT%\.project\devlog.md"
echo. > "%ROOT%\.project\daily-log.md"
echo. > "%ROOT%\.project\module-change-log.md"

echo [OK] .project files created
echo.

REM ------------------------------------------------------------
REM ALL SKILL FILES
REM (Content written inline - all 13 skills)
REM Skills are written as reference files pointing to full content
REM Full content was built in the previous setup sessions
REM ------------------------------------------------------------

echo Creating .skills files...

REM Each skill file created with header and key rules
REM Full detailed content available in the separate skill files
REM delivered in this project

for %%F in (
    "end-session|run end-session|Daily shutdown ritual. Runs wrap-session + project-log + session-end in order."
    "wrap-session|run wrap-session|Updates rolling daily log. Keeps last 5 sessions in .project/daily-log.md."
    "project-log|run project-log: {type}|Appends timestamped entry to .project/devlog.md. Permanent. Never deleted."
    "session-end|run session-end|Writes handoff note to handoff.md. Appends devlog entry. Asks about ADO push."
    "validation|AUTOMATIC|Runs before every task complete. Checks all output against project rules."
    "standard-of-working|AUTOMATIC|Coding conventions naming patterns structure rules for all Java code."
    "pr-scan|AUTOMATIC|Privacy and security check. Run before every commit. Healthcare project."
    "pr-workflow|run pr-workflow|Complete git + ADO PR workflow. Branch create push raise-pr merge-confirm."
    "xlsx|READ BEFORE EXCEL WORK|Apache POI patterns for Excel generation. Column specs color codes rules."
    "docx|READ BEFORE WORD WORK|Apache POI XWPF patterns for Word generation. Fixed document template."
    "data-explore|run data-explore: {file}|Profiles datasets automatically. Null counts distributions anomalies."
    "create-doc|run create-doc: {type}|Generates Word documents from project logs. kt-guide handover migration."
    "locator-change-log|run locator-log|Tracks all locator changes in Excel. Auto-runs after Phase 3 and 4 fixes."
    "module-change-log|run module-log: {module}|Per-module change history. New tester briefing command available."
) do (
    for /f "tokens=1,2,3 delims=|" %%A in ("%%~F") do (
        echo # %%A.md > "%ROOT%\.skills\%%A.md"
        echo # INVOKE: %%B >> "%ROOT%\.skills\%%A.md"
        echo # PURPOSE: %%C >> "%ROOT%\.skills\%%A.md"
        echo # >> "%ROOT%\.skills\%%A.md"
        echo # IMPORTANT: This is a stub file. >> "%ROOT%\.skills\%%A.md"
        echo # Replace this content with the full skill file >> "%ROOT%\.skills\%%A.md"
        echo # from the skill files delivered in this project setup. >> "%ROOT%\.skills\%%A.md"
        echo # Full content for each skill was built and delivered >> "%ROOT%\.skills\%%A.md"
        echo # as individual .md files. Copy that content here. >> "%ROOT%\.skills\%%A.md"
    )
)

echo [OK] .skills stub files created
echo      IMPORTANT: Replace stub content with full skill content
echo      from the individual skill .md files delivered separately
echo.

REM ------------------------------------------------------------
REM INSTRUCTION FILES — STUBS WITH FILL IN MARKERS
REM ------------------------------------------------------------

echo Creating .vscode\instructions files...

(
echo # framework-architecture.instructions.md
echo # ATTACH: at start of every phase session
echo # STATUS: [FILL IN REQUIRED] - complete all sections below
echo.
echo ## WORKSPACE OVERVIEW
echo Old Framework root: [FILL IN - likely: C:\path\to\Patient_Portal_Automation]
echo New Framework root: [FILL IN - likely: C:\path\to\Personalized_Plus]
echo.
echo ## OLD FRAMEWORK FOLDERS
echo Features folder:      [FILL IN]
echo Step definitions:     [FILL IN]
echo Locator/page files:   [FILL IN]
echo Config folder:        [FILL IN]
echo.
echo ## NEW FRAMEWORK FOLDERS
echo Step definitions:  [FILL IN]
echo Pages folder:      [FILL IN]
echo Runner folder:     [FILL IN]
echo Features folder:   [FILL IN]
echo Config folder:     [FILL IN]
echo Reports folder:    [FILL IN]
echo.
echo ## THREE-LAYER ARCHITECTURE
echo LAYER 1 - Feature Files: [FILL IN exact path]
echo LAYER 2 - Steps.java:    [FILL IN exact path]
echo LAYER 3 - Pages.java:    [FILL IN exact path]
echo.
echo Tag format:         [FILL IN - example @12345 or @TC_12345]
echo Locator convention: [FILL IN - example btnLogin txtEmail]
echo Locator preference: [FILL IN - example ID first CSS second XPath third]
echo.
echo ## MAVEN BUILD COMMANDS
echo Regression: [FILL IN]
echo Smoke:      [FILL IN]
echo Single tag: [FILL IN]
echo Local:      [FILL IN]
echo Perfecto:   [FILL IN]
echo.
echo ## REPORTS
echo Report type:     ExtentReports HTML
echo Report location: [FILL IN]
echo Report filename: [FILL IN]
echo Screenshots:     C:\Users\sunsagar\Sunil\Mayo\Automation\MC-Automation-Framework\output\screenshots
echo.
echo ## NAMING CONVENTIONS
echo Feature files: [FILL IN]
echo Steps files:   [FILL IN]
echo Pages files:   [FILL IN]
echo.
echo ## POI IN POM.XML
echo Apache POI present: [FILL IN - YES or NO]
echo POI version:        [FILL IN if present]
echo JSON library:       [FILL IN - org.json / Jackson / Gson]
echo.
echo ## WHAT COPILOT MUST NEVER DO
echo 1. Apply Old Framework structure to New Framework
echo 2. Create Steps.java method without searching all existing Steps files
echo 3. Create Pages.java method without searching all existing Pages files
echo 4. Modify a locator without showing old and new side by side
echo 5. Add pom.xml dependency without checking it is missing first
echo 6. Assume a folder path. Always read the actual structure.
) > "%ROOT%\.vscode\instructions\framework-architecture.instructions.md"

(
echo # ado-api-reference.instructions.md
echo # ATTACH: whenever any phase involves ADO API calls
echo # STATUS: [FILL IN REQUIRED] - complete project-specific values
echo.
echo ## ADO DETAILS
echo Organization URL: https://dev.azure.com/MCLM
echo Project name:     [FILL IN]
echo API version:      7.0
echo.
echo ## CONFIG.PROPERTIES KEYS
echo ado.org=https://dev.azure.com/MCLM
echo ado.project=[FILL IN]
echo ado.masterPlanId=[FILL IN]
echo ado.masterSuiteId=[FILL IN]
echo ado.releasePlanId=[FILL IN - updated each release]
echo ado.releaseSuiteId=[FILL IN - updated each release]
echo ado.pat=[FILL IN - never commit to repo]
echo ado.repositoryId=[FILL IN]
echo ado.reviewerIds=[FILL IN - comma separated]
echo ado.defaultBranch=main
echo report.outputPath=C:\Users\sunsagar\Sunil\Mayo\Automation\MC-Automation-Framework\output\reports
echo screenshot.outputPath=C:\Users\sunsagar\Sunil\Mayo\Automation\MC-Automation-Framework\output\screenshots
echo.
echo ## AUTHENTICATION
echo Basic Auth. Base64 encode :{PAT} with colon prefix.
echo Header: Authorization: Basic {encoded}
echo PAT never logged printed or written anywhere except config.properties.
echo.
echo ## KEY ENDPOINTS
echo Fetch test cases: GET /testplan/Plans/{planId}/suites/{suiteId}/testcase
echo Single test case: GET /wit/workitems/{id}
echo Create test run:  POST /test/runs
echo Update results:   PATCH /test/runs/{runId}/results
echo Fetch test points: GET /testplan/Plans/{planId}/suites/{suiteId}/testpoint
echo Create PR:        POST /git/repositories/{repoId}/pullrequests
echo Check PR:         GET /git/repositories/{repoId}/pullrequests/{prId}
echo.
echo ## PAGINATION
echo All list endpoints: max 100 per page.
echo Use $top=100 and $skip=N. Increment skip by 100 each page.
echo Stop when results returned less than $top.
echo Never assume all 400 fit in one call.
echo.
echo ## ERROR HANDLING
echo 200 OK / 400 Bad request log and stop / 401 PAT expired stop
echo 403 Wrong permissions stop / 404 Wrong ID stop
echo 429 Rate limited retry max 3 / 500 Retry once then stop
echo.
echo ## CRITICAL REMINDERS
echo Test Case ID and Test Point ID are NOT the same thing.
echo @tag in feature file IS the Test Case ID. Foundation of system.
echo PAT never in logs console or any file except config.properties.
echo Never PATCH or POST without showing Sunil what will be sent.
) > "%ROOT%\.vscode\instructions\ado-api-reference.instructions.md"

REM Create stub instruction files for remaining phases
for %%F in (
    "excel-output-spec.instructions"
    "phase0-reconciliation.instructions"
    "phase1-reporter.instructions"
    "phase2-migration.instructions"
    "phase3-web-healer.instructions"
    "phase4-perfecto-healer.instructions"
    "git-ado-workflow.instructions"
    "team-prompt-playbook.instructions"
) do (
    echo # %%F.md > "%ROOT%\.vscode\instructions\%%F.md"
    echo # STATUS: Copy full content from the %%F.md file >> "%ROOT%\.vscode\instructions\%%F.md"
    echo # delivered as part of the project setup package. >> "%ROOT%\.vscode\instructions\%%F.md"
)

echo [OK] .vscode\instructions files created
echo      framework-architecture and ado-api-reference have starter content
echo      All others: copy full content from delivered .md files
echo.

REM ------------------------------------------------------------
REM config.properties.template
REM ------------------------------------------------------------

echo Creating config.properties.template...

(
echo # config.properties.template
echo # Copy this file, rename to config.properties, fill in values
echo # NEVER commit config.properties to the repository
echo # Only commit this .template file
echo.
echo # ADO Configuration
echo ado.org=https://dev.azure.com/MCLM
echo ado.project=[FILL IN]
echo ado.masterPlanId=[FILL IN]
echo ado.masterSuiteId=[FILL IN]
echo ado.releasePlanId=[FILL IN]
echo ado.releaseSuiteId=[FILL IN]
echo ado.pat=[FILL IN - Personal Access Token - never commit actual value]
echo ado.repositoryId=[FILL IN]
echo ado.reviewerIds=[FILL IN - comma separated ADO user IDs]
echo ado.defaultBranch=main
echo.
echo # Framework Paths
echo reconciliation.oldFrameworkPath=[FILL IN - path to Patient_Portal_Automation features folder]
echo reconciliation.newFrameworkPath=[FILL IN - path to Personalized_Plus features folder]
echo.
echo # Execution
echo execution.mode=local
echo browser=chrome
echo environment=qa
echo.
echo # Perfecto
echo perfecto.host=[FILL IN - yourcloud.perfectomobile.com]
echo perfecto.securityToken=[FILL IN - never commit actual value]
echo perfecto.domSource=API
echo perfecto.manualDomFolder=[FILL IN - only if domSource=MANUAL_FOLDER]
echo.
echo # Claude API
echo claude.api.url=https://api.anthropic.com/v1/messages
echo claude.model=claude-sonnet-4-20250514
echo.
echo # Output Paths
echo report.outputPath=C:\Users\sunsagar\Sunil\Mayo\Automation\MC-Automation-Framework\output\reports
echo screenshot.outputPath=C:\Users\sunsagar\Sunil\Mayo\Automation\MC-Automation-Framework\output\screenshots
) > "%ROOT%\config.properties.template"

echo [OK] config.properties.template created
echo.

REM ------------------------------------------------------------
REM .gitignore
REM ------------------------------------------------------------

echo Creating .gitignore...

(
echo # Config with real values - never commit
echo config.properties
echo.
echo # Output files - never commit
echo output/
echo *.log
echo.
echo # Java build
echo target/
echo *.class
echo *.jar
echo.
echo # Backup files from locator healer
echo *.bak
echo.
echo # OS files
echo .DS_Store
echo Thumbs.db
echo desktop.ini
) > "%ROOT%\.gitignore"

echo [OK] .gitignore created
echo.

REM ============================================================
REM SETUP COMPLETE
REM ============================================================

echo.
echo ============================================================
echo  SETUP COMPLETE
echo ============================================================
echo.
echo  Project created at:
echo  C:\Users\sunsagar\Sunil\Mayo\Automation\MC-Automation-Framework
echo.
echo  NEXT STEPS:
echo.
echo  ON THIS MACHINE:
echo  1. Copy the 13 full skill .md files into:
echo     MC-Automation-Framework\.skills\
echo     (replace the stub files created here^)
echo.
echo  2. Copy the full instruction .md files into:
echo     MC-Automation-Framework\.vscode\instructions\
echo     (replace the stub files for phase0 through team-playbook^)
echo.
echo  COPY TO ODC MACHINE:
echo  3. Copy entire MC-Automation-Framework folder to:
echo     C:\Users\sunsagar\Sunil\Mayo\Automation\
echo.
echo  ON YOUR ODC MACHINE:
echo  4. Open .vscode\instructions\framework-architecture.instructions.md
echo     Fill in all [FILL IN] with actual folder paths
echo     Confirm: Patient_Portal_Automation folder name
echo     Confirm: Personalized_Plus folder name
echo.
echo  5. Open .vscode\instructions\ado-api-reference.instructions.md
echo     Fill in ADO project name, plan IDs, repository ID
echo.
echo  6. Copy config.properties.template to config.properties
echo     Fill in all values. Never commit config.properties.
echo.
echo  7. Update MC-Automation-Framework.code-workspace
echo     Replace [FILL IN] with actual framework folder paths
echo.
echo  8. Double-click MC-Automation-Framework.code-workspace
echo     VS Code opens with everything ready
echo.
echo  9. Read team-prompt-playbook before first session
echo.
echo ============================================================
echo.
pause
