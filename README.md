# MC-Automation-Framework

## What is this?

This folder contains the AI-powered Copilot setup for the
MC Healthcare Portal automation project.
It does NOT contain the test framework code itself.
The test frameworks are in separate folders:
  Old Framework: Patient_Portal_Automation (or confirm on ODC)
  New Framework: Personalized_Plus (or confirm on ODC)

This folder contains:
  - Copilot instructions and context files
  - Reusable skills for the team
  - Project memory (logs, handoff notes)
  - Phase instruction files
  - Output folder for generated reports

## How to open this project

1. Double-click MC-Automation-Framework.code-workspace
2. VS Code opens with all three folders visible
3. Copilot reads .github/copilot-instructions.md automatically
4. Read .vscode/instructions/team-prompt-playbook.instructions.md
   before your first session

## Before your first session

Fill in these placeholders:
  .vscode\instructions\framework-architecture.instructions.md
    - Replace [FILL IN] with actual folder paths
    - Confirm old and new framework folder names

  .vscode\instructions\ado-api-reference.instructions.md
    - Replace [FILL IN] with ADO project name and plan IDs

  .vscode\instructions\git-ado-workflow.instructions.md
    - Replace [FILL IN] with repository ID and reviewer IDs

  MC-Automation-Framework.code-workspace
    - Replace [FILL IN] with actual framework folder paths

## Folder structure

.github\
  copilot-instructions.md     Master prompt - auto-loaded by Copilot

.vscode\instructions\
  framework-architecture      Project folder structure and layers
  ado-api-reference           ADO REST API endpoints and auth
  excel-output-spec           Excel column definitions and colors
  phase0-reconciliation       Phase 0 build guide
  phase1-reporter             Phase 1 build guide
  phase2-migration            Phase 2 build guide
  phase3-web-healer           Phase 3 build guide
  phase4-perfecto-healer      Phase 4 build guide
  git-ado-workflow            Git and PR workflow rules
  team-prompt-playbook        Team guide - read before first session

.project\
  knowledge.md                Project context - Copilot reads this first
  handoff.md                  Where we left off - updated each session
  devlog.md                   Permanent project log - never deleted
  daily-log.md                Last 5 sessions rolling window
  module-change-log.md        Per-module change history

.skills\
  end-session                 Daily shutdown ritual
  wrap-session                Updates rolling daily log
  project-log                 Appends to permanent devlog
  session-end                 Handoff note + ADO push prompt
  validation                  Quality gate - runs before task complete
  standard-of-working         Coding conventions and naming rules
  pr-scan                     Privacy check before every commit
  pr-workflow                 Complete git and PR workflow
  xlsx                        Apache POI Excel patterns
  docx                        Apache POI Word document patterns
  data-explore                Dataset profiling and analysis
  create-doc                  Generates final project documentation
  locator-change-log          Tracks all locator changes automatically
  module-change-log           Per-module change history skill

output\
  reports\                    Generated Excel reports land here
  screenshots\                Test failure screenshots land here

## Project phases

Phase 0 - Reconciliation Engine
  Builds master Excel mapping ADO, old framework, new framework

Phase 1 - Post-Run Excel Reporter
  Auto-generates Pass/Fail Excel after every regression run

Phase 2 - AI-Assisted Migration Engine
  Migrates 400 scripts from old framework to new framework

Phase 3 - Web Locator Auto-Healer
  Detects and fixes broken XPath locators for local web tests

Phase 4 - Perfecto Mobile Locator Healer
  Detects and fixes broken locators for Perfecto mobile tests

## Contact

Project lead: Sunil Sagar - Automation and Performance Tester
All framework questions: escalate to Sunil first
Client changes: require MC approval before push to main
