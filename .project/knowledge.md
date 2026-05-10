# knowledge.md
# Project Knowledge Base - Copilot Context File
# Read by GitHub Copilot at the start of every session.
# Never delete. Update when anything changes.

---

## WHO I AM

- Name: Sunil Sagar
- Role: Automation and Performance Tester
- I am the sole builder of this automation system.
- The team of 5 QA Engineers and 1 Lead will use what I build.
- I am responsible for KT to the team on how to use this system.

---

## THE CLIENT

- Client codename: MC
- Domain: Healthcare
- Application type: Web application and Mobile application
- What it does: Patient-facing healthcare portal where patients
  log in to check messages, view test results, create and manage
  appointments, and track personal health records.
- Primary end users: Patients

---

## THE TEAM

- 5 QA Engineers + 1 QA Lead = 6 members total
- All work in Java. All tooling must be Java only.
- Not all comfortable with Python. No Python in this project.

---

## THE PROJECT

- Old Framework: Quantum + Perfecto
  Folder: Patient_Portal_Automation (confirm on ODC machine)
  Runs on Perfecto ONLY. Cannot run locally.
  Real physical mobile devices in Perfecto lab.

- New Framework: Java + Selenium + BDD Cucumber
  Folder: Personalized_Plus (confirm on ODC machine)
  Supports @local and @perfecto execution modes.
  Three-layer architecture: .feature / Steps.java / Pages.java
  No shared library folder. Step reuse via matching Gherkin text.

---

## THE PROBLEM WE ARE SOLVING

1. Dual framework maintenance - regression and maintenance in both
2. ADO title mismatch - scenario titles dont match ADO test case titles
3. Manual Excel reporting - Pass/Fail updated manually after every run
4. Locator breakage - XPaths break, manually found and fixed
5. Migration backlog - 400 scripts need moving to new framework
   30 percent clean migrations / 70 percent structural splits

---

## THE ULTIMATE GOAL

- Migrate all 400 scripts to new framework
- Sunset old framework completely
- Reduce maintenance effort to near zero
- Excel Pass/Fail updates automatically from HTML report
- Single framework, single source of truth

---

## ADO SETUP

- Organization URL: https://dev.azure.com/MCLM
- Project: [FILL IN]
- Tags in feature files map 1:1 to ADO Test Case IDs
- Master Test Plan - query-based suite - source of truth
- Per-release Test Plan - cloned from master - used for regression
- PAT: read from config.properties only. Never hardcode.

---

## TOOLS AND ACCESS

- Azure DevOps: full access, read and write via PAT
  ONLY tool for this project. No JIRA. No Figma here.
- Perfecto Lab: real physical mobile devices
  Post-session DOM snapshots accessible
- GitHub Copilot: VS Code with Claude Sonnet and Opus
- ZScaler: all internet filtered through ZScaler
  Only whitelisted URLs accessible

---

## ENVIRONMENT CONSTRAINTS

1. No new tools without client approval. Check pom.xml first.
2. No direct internet. ZScaler only. No workarounds.
3. Client approves all changes. Never auto-commit or auto-push.
4. All code in Java only. Batch .bat for Windows utilities only.
5. Code must be understandable by mid-level QA engineer.

---

## REPORTING

- ExtentReports HTML generated after every run
- Team manually updates Excel with Pass/Fail - TO BE AUTOMATED
- Target: Excel auto-updates after every run with zero manual effort

---

## OUTPUT PATHS

report.outputPath=C:\Users\sunsagar\Sunil\Mayo\Automation\MC-Automation-Framework\output\reports
screenshot.outputPath=C:\Users\sunsagar\Sunil\Mayo\Automation\MC-Automation-Framework\output\screenshots

---

## PHASES

PHASE 0 - Reconciliation Engine
PHASE 1 - Post-Run Excel Reporter
PHASE 2 - AI-Assisted Migration Engine
PHASE 3 - Web Locator Auto-Healer
PHASE 4 - Perfecto Mobile Locator Healer

---

## CRITICAL REMINDERS

1. HEALTHCARE project. Patient data privacy non-negotiable.
   pr-scan before every commit. No exceptions.
2. @tags are ADO Test Case IDs. Sacred. Never change them.
3. No shared library. Reuse via matching Gherkin text.
   Search all Steps.java before creating any new step.
4. Never auto-commit, auto-push, or overwrite silently.
   Every change presented and approved by Sunil first.
5. When in doubt, stop and ask. Slow and correct always wins.
