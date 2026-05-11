# knowledge.md
# Project Knowledge Base — Copilot Context File
# This file is read by GitHub Copilot at the start of every session.
# It gives Copilot the business context, team context, environment
# constraints, and project goals it needs to give relevant suggestions.
# Never delete this file. Update it when anything changes.

---

## WHO I AM

- Name: Sunil Sagar
- Role: Automation & Performance Tester
- I am the sole builder of this automation system.
- The entire team of 5 QA Engineers and 1 Lead will use what I build.
- I am responsible for KT (Knowledge Transfer) to the team on how to
  use this system and how to interact with the Copilot agent correctly.

---

## THE CLIENT

- Client codename: MC
- Domain: Healthcare
- Application type: Web application and Mobile application (iOS and Android)
- What the application does: A patient-facing healthcare portal where
  patients can log in to check messages from their care team, view
  test results, create and manage appointments, and track their
  personal health records.
- Primary end users: Patients (members of the public using the portal
  to manage their own healthcare)

---

## THE TEAM

- 5 QA Engineers
- 1 QA Lead
- Total: 6 members
- All team members are expected to use the automation framework and
  interact with the Copilot agent after KT is completed.
- Not all team members are comfortable with Python. The entire team
  works in Java. All tooling and automation must be in Java only.

---

## THE PROJECT

- Internal name: Old Framework → New Framework migration project
- Old Framework: Built on Quantum + Perfecto
  - Tests web and mobile applications using Perfecto driver
  - Web instances and mobile instances run inside Perfecto lab
  - Mobile devices are real physical devices inside the Perfecto lab
  - Running tests locally was not possible in this framework
  - Test execution was Perfecto-only for both web and mobile
- New Framework: Built on Java + Selenium + BDD Cucumber
  - Supports both Perfecto execution and local execution
  - Execution mode is controlled by tags: @local or @perfecto
  - Follows a strict three-layer architecture:
    Layer 1 → .feature files written in Gherkin language
    Layer 2 → Steps.java files (step definitions, no Selenium logic)
    Layer 3 → Pages.java files (POM, all Selenium actions, all locators)
  - There is no separate shared library folder. Step reuse happens
    organically — same Gherkin sentence in any feature file
    automatically maps to the same Steps.java method via Cucumber.
  - Creating duplicate step definitions will cause
    AmbiguousStepDefinitionsException and break the entire suite.

---

## THE PROBLEM WE ARE SOLVING

1. Dual framework maintenance burden
   Running regression and maintenance in both Old and New Framework
   simultaneously is doubling the team's workload.

2. ADO title mismatch
   Scenario outline titles in the Old Framework do not match the
   test case titles in Azure DevOps (ADO). The team manually searches
   by @tag to reconcile them, which is slow and error-prone.

3. Manual Excel reporting
   After every regression or smoke suite run, the team manually
   updates an Excel file with Pass/Fail results. This must be
   automated so the Excel updates itself from the HTML report output.

4. Locator breakage
   When XPath locators break on web (local) or mobile (Perfecto),
   the team manually finds and fixes them in Pages.java files.
   This maintenance effort must be reduced significantly.

5. Migration backlog
   Approximately 400 scripts exist in the Old Framework.
   All 400 must be migrated to the New Framework before the
   Old Framework can be sunset.
   30% are clean migrations (title mismatch only, same logic).
   70% are structural splits (1 old script maps to 2 or more
   ADO test cases and must become 2 or more scenarios).

---

## THE ULTIMATE GOAL

- Migrate all 400 scripts from Old Framework to New Framework
- Sunset the Old Framework completely
- Reduce ongoing maintenance effort to near zero
- Automate Excel Pass/Fail updates directly from HTML test reports
- When a test fails, the system captures it and updates the
  Excel file automatically without manual intervention
- The team works from a single framework only, with a single
  source of truth for test results

---

## AZURE DEVOPS (ADO) SETUP

- ADO is the test management tool
- Organization URL: https://dev.azure.com/MCLM
- @tags in feature files map 1:1 with ADO Test Case IDs
  (tags were taken directly from ADO, not custom-created)
- ADO structure:
  → Master Test Plan (source of truth, all test cases live here)
  → Query-based suite inside Master Test Plan
  → Per-release Test Plan (cloned from Master for each release)
  → Per-release Test Plan is what is executed during regression
- ADO API access: Read and Write access via PAT (Personal Access Token)
- PAT must never be hardcoded. Always read from config.properties.
- ADO also contains a Wiki with guidelines on how to write test cases,
  use shared steps, and structure test suites. This Wiki is a valid
  reference source.

---

## TOOLS AND ACCESS

- Azure DevOps (ADO): Full access, read and write via PAT
  This is the ONLY project management and test management tool
  used on this project. JIRA and Figma are used on other projects
  but are NOT used here. Do not suggest JIRA or Figma integrations.
- Perfecto Lab: Access for mobile and web test execution
  - Real physical mobile devices
  - Post-session DOM snapshots and recordings accessible
  - Mobile locators are typically XPath based
- GitHub Copilot: Available in VS Code with Claude Sonnet and Opus
- ZScaler: Internet access is filtered through ZScaler
  - Only whitelisted URLs are accessible
  - Cannot access arbitrary external URLs or install tools freely

---

## ENVIRONMENT CONSTRAINTS — COPILOT MUST ALWAYS REMEMBER THESE

1. Cannot install new tools, libraries, or dependencies without
   explicit client approval. Always check pom.xml before suggesting
   any new dependency. If a dependency is missing, flag it and
   wait for approval before adding it.

2. No direct internet access. All external calls go through ZScaler.
   Only whitelisted URLs are reachable. Do not suggest solutions
   that require downloading tools or hitting non-whitelisted endpoints.

3. Client approves all changes. Nothing goes to the repository
   without client sign-off. Never auto-commit, never auto-push.
   Always present changes for review first.

4. All code must be in Java. No Python, no Node.js, no shell scripts
   in the framework itself. Utility scripts for one-time tasks may
   use batch (.bat) files for Windows only.

5. The team is not all at the same technical level. All code,
   explanations, and documentation must be written clearly enough
   for a mid-level QA engineer to understand and maintain.

---

## REPORTING SETUP

- Current report type: ExtentReports HTML
- After every run, an HTML report is generated
- The team currently manually updates an Excel file with Pass/Fail
  based on the HTML report — this must be automated
- The Excel file tracks: ADO Tag, ADO Title, Scenario Title,
  Pass/Fail status
- Target: Excel updates itself automatically after every run
  without any manual intervention from the team

---

## PROJECT PHASES

The work is divided into 5 phases. Copilot works on one phase
at a time, only when explicitly told to start a phase.

PHASE 0 — Reconciliation Engine
  Builds a master Excel mapping ADO titles, Old Framework titles,
  and New Framework titles. Flags mismatches and migration gaps.

PHASE 1 — Post-Run Excel Reporter
  Hooks into the Cucumber + ExtentReports pipeline to auto-generate
  a Pass/Fail Excel after every regression or smoke suite run.

PHASE 2 — AI-Assisted Migration Engine
  Uses Claude AI via GitHub Copilot to migrate Old Framework
  feature files to New Framework BDD Cucumber format, one at a time
  with human approval, then in batches once accuracy is confirmed.

PHASE 3 — Web Locator Auto-Healer
  Detects broken XPath locators on local web runs, suggests fixes
  using AI + DOM analysis, and presents fixes for human approval
  before touching any Pages.java file.

PHASE 4 — Perfecto Mobile Locator Healer
  Same as Phase 3 but for Perfecto mobile devices using post-session
  DOM snapshots. Human-in-the-loop review is mandatory for every fix.

---

## SKILLS AVAILABLE IN THIS PROJECT

The .skills/ folder contains reusable instruction sets that can be
invoked by name in Copilot Chat. Available skills:

- end-session     → daily shutdown ritual, runs wrap-session
                    and project-log together
- wrap-session    → aggregates session into daily log,
                    keeps last 5 entries in .project/daily-log.md
- project-log     → appends timestamped entry to .project/devlog.md,
                    nothing ever deleted
- session-end     → writes handoff note, dev log entry,
                    prompts for ADO repository push
- validation      → checks every output against defined rules
                    before marking it as done
- standard-of-working → coding conventions, naming patterns,
                    how things are structured in this project
- pr-scan         → privacy review checklist before any code ships,
                    ensures no patient data or sensitive information
                    is exposed (critical for healthcare project)
- data-explore    → profiles new datasets automatically,
                    null counts, distributions, field types
- create-doc      → generates documentation from project files
                    in a fixed template format

---

## CRITICAL REMINDERS FOR COPILOT

1. This is a HEALTHCARE project. Patient data privacy is non-negotiable.
   Never suggest storing, logging, or exposing any patient-related data.
   The pr-scan skill must be run before any code ships.

2. The @tags in feature files are ADO Test Case IDs. They are sacred.
   Never change, remove, or rename a @tag without explicit instruction.

3. There is no shared library folder. Reuse happens via matching
   Gherkin sentences. Always search all Steps.java files before
   creating any new step definition.

4. Never auto-commit, never auto-push, never overwrite files silently.
   Every change must be presented and approved by Sunil first.

5. When in doubt, stop and ask. Slow and correct is better than
   fast and broken.
