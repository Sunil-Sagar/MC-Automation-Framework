# create-doc.md
# SKILL: create-doc
# ================================================================
# HOW TO INVOKE THIS SKILL:
# Type in Copilot Chat:
#   "run create-doc: kt-guide"
#   "run create-doc: handover-report"
#   "run create-doc: migration-report"
#   "run create-doc: test-strategy"
#   "run create-doc: retrospective"
#   "run create-doc: final project report"
#       → generates all five documents in one run
#
# WHAT THIS SKILL DOES:
# Generates professional Word documents (.docx files) from the
# project files that already exist in this workspace.
# No manual writing required from Sunil.
# The logs, decisions, risks, and learnings written during
# the project are the raw material. This skill formats them.
#
# SOURCE FILES THIS SKILL READS:
#   .project/knowledge.md    → project context, team, goals
#   .project/devlog.md       → decisions, risks, learnings,
#                               milestones, mistakes, session history
#   .project/handoff.md      → current state of the project
#   .project/daily-log.md    → recent session summaries
#   Reconciliation Excel     → migration statistics (if available)
#   Run Report Excel         → test execution statistics (if available)
#
# OUTPUT:
#   Word .docx files written to config.getProperty("report.outputPath")
#   Built using Apache POI XWPF patterns from .skills/docx.md
#
# DEPENDENCY:
#   This skill requires docx.md to be read first.
#   If docx.md has not been read this session, read it before
#   generating any document.
# ================================================================

---

## BEFORE GENERATING ANY DOCUMENT

Copilot must complete these steps in order before writing
a single line of document content:

Step 1: Confirm docx.md has been read this session.
        If not, read .skills/docx.md now.

Step 2: Read .project/knowledge.md completely.
        Extract: project name, client, team, goals, constraints,
        tools, phases, environment details.

Step 3: Read .project/devlog.md completely from first to last entry.
        As you read, build four extraction lists:
          DECISIONS list  — every entry with type DECISION
          RISKS list      — every entry with type RISK
          LEARNINGS list  — every entry with type LEARNING
          MILESTONES list — every entry with type MILESTONE
          MISTAKES list   — every entry with type FAILURE
        Each list item must include: date, phase, full description.

Step 4: Read .project/handoff.md.
        Extract: current phase, current state, open questions.

Step 5: Check if Reconciliation Excel exists in output folder.
        If yes, run data-explore on it silently and extract:
          Total test cases, migrated count, not migrated count,
          structural splits count, migration percentage.
        If no, note: "Reconciliation report not available."

Step 6: Check if Run Report Excel exists in output folder.
        If yes, extract: pass count, fail count, skip count,
        pass rate, suite name, run date.
        If no, note: "Run report not available."

Step 7: Confirm all source reading is complete. Tell Sunil:
        "I have read all source files. Here is what I found:
          knowledge.md:  {N} sections read
          devlog.md:     {N} session entries, {N} decisions,
                         {N} risks, {N} learnings, {N} milestones
          handoff.md:    current phase {phase name}
          Reconciliation Excel: {available/not available}
          Run Report Excel:     {available/not available}
        Ready to generate {document type}.
        Shall I proceed?"

Step 8: Wait for Sunil to say proceed before writing anything.

---

## SECTION 1 — KT GUIDE (kt-guide)

### Purpose
Knowledge Transfer guide for the 5 QA Engineers and 1 Lead.
Written so any team member can use the framework, run tests,
add new test cases, and interact with the Copilot agent
without Sunil being present.

### Reading Level
Mid-level QA engineer. No assumed knowledge beyond basic Java
and Selenium concepts. Every technical term explained.

### Generation Steps

Step 1: Write cover page using docx.md cover page template.
        Title: "Automation Framework — Knowledge Transfer Guide"
        Version: 1.0

Step 2: Write TOC as plain text list.
        Include manual update instruction.

Step 3: Write Section 1 — Document Overview
        Purpose: "This guide enables the QA team to independently
        use, maintain, and extend the new BDD Cucumber automation
        framework for the MC healthcare portal."
        Scope: framework usage, not framework development.
        Audience: QA Engineers and QA Lead.

Step 4: Write Section 2 — Project Background
        Pull from knowledge.md:
          Client description, application overview, team details,
          project goals, environment constraints.

Step 5: Write Section 3 — Main Content
        3.1 Framework Architecture
            Explain the three-layer architecture with a simple diagram
            using ASCII art or a formatted table:
            LAYER        | FILE TYPE    | RESPONSIBILITY
            Feature file | .feature     | WHAT the test does
            Step Def     | Steps.java   | BRIDGE — links Gherkin to Java
            Page Object  | Pages.java   | HOW — Selenium + locators

        3.2 How to Run the Test Suite
            Pull Maven commands from framework-architecture.instructions.md
            Show: regression suite, smoke suite, single tag, local, Perfecto.
            Format each as a code block.

        3.3 How to Add a New Test Case
            Step by step numbered list:
            1. Create or open the relevant .feature file
            2. Add the @tag (from ADO Test Case ID)
            3. Add suite tag (@regression or @smoke)
            4. Add execution tag (@local or @perfecto)
            5. Write the Gherkin steps
            6. Check if step definitions already exist in Steps.java files
            7. If new step needed: add to Steps.java, call Pages.java method
            8. If new Pages.java method needed: add locator and method
            9. Run locally first: mvn test -Dtags="@{your tag} and @local"
            10. Verify pass then add to regression suite

        3.4 How to Use the Copilot Agent
            Pull from .vscode/instructions/team-prompt-playbook.instructions.md
            if it exists. If not yet built, write from the master prompt rules:
            - How to start a session
            - The approval commands: proceed, build this, stop, resume
            - How to invoke skills by name
            - What to do if agent goes off track
            - Common mistakes to avoid

        3.5 How to Use the Skills
            For each skill in .skills/ folder:
            Skill name | Invoke command | What it does | When to use it
            Table format. One row per skill.

        3.6 How to Read the Reports
            Reconciliation Report: column by column explanation.
            Pull column definitions from xlsx.md Section 4.
            Run Report: column by column explanation.
            Pull column definitions from xlsx.md Section 5.
            Color coding guide: what each color means.

        3.7 Common Issues and Solutions
            Pull from devlog.md FAILURE and MISTAKE entries.
            Format as: Problem | Likely Cause | Solution
            Minimum 5 entries. If fewer in devlog, supplement with
            known common issues for this type of project.

Step 6: Write Section 4 — Decisions and Rationale
        Pull all DECISION entries from devlog.md.
        Format as a table: Date | Decision | Reason | Phase

Step 7: Write Section 5 — Known Issues and Risks
        Pull all RISK entries from devlog.md.
        Format as: Date | Risk | Severity | Status | Action

Step 8: Write Section 6 — Lessons Learned
        Pull all LEARNING entries from devlog.md.
        Format as a numbered list with date and phase context.

Step 9: Write Section 7 — Appendix
        7.1 Glossary: define all technical terms used in this guide
        7.2 Tool versions: pull from pom.xml
        7.3 Config reference: pull from framework-architecture.instructions.md
        7.4 Contacts: Sunil Sagar — Automation and Performance Tester

---

## SECTION 2 — HANDOVER REPORT (handover-report)

### Purpose
Final document given to the client (MC) and the receiving team
when Sunil's engagement ends or when the project milestone is reached.
Professional, concise, client-ready.

### Generation Steps

Step 1: Cover page. Title: "Automation Framework — Handover Report"

Step 2: TOC.

Step 3: Section 1 — Document Overview
        Formal language. Client-facing tone.

Step 4: Section 2 — Project Background
        From knowledge.md. Client-appropriate level of detail.

Step 5: Section 3 — Main Content
        3.1 Migration Summary
            If Reconciliation Excel available:
              Total scripts: {count}
              Migrated:       {count} ({percentage}%)
              Not migrated:   {count} ({percentage}%)
              Structural splits resolved: {count}
            If not available: state "Migration statistics not yet available."

        3.2 Framework Status
            Current state of new framework.
            From handoff.md current state section.
            Any known issues or limitations.

        3.3 Environment Setup Instructions
            How to set up the framework on a new machine.
            Prerequisites, config steps, first run verification.

        3.4 Outstanding Items
            Pull from handoff.md "What to do next" section.
            Anything not completed that the receiving team must finish.
            Format as: Item | Priority | Estimated Effort | Owner

        3.5 Support and Escalation
            Who to contact for what type of issue.

Step 6-9: Same as KT Guide steps 6-9 (decisions, risks, learnings, appendix).

---

## SECTION 3 — MIGRATION REPORT (migration-report)

### Purpose
Complete record of the 400-script migration.
Shows exactly what was migrated, what remains, how splits were handled.
Primary audience: client (MC) and QA Lead.

### Generation Steps

Step 1: Cover page. Title: "Script Migration Report — Old Framework to New Framework"

Step 2: TOC.

Step 3: Section 1 — Document Overview

Step 4: Section 2 — Project Background (from knowledge.md)

Step 5: Section 3 — Main Content
        3.1 Migration Overview
            Goal: migrate 400 scripts, sunset old framework.
            Approach: AI-assisted with human approval at every step.
            Timeline: pull session dates from devlog.md.

        3.2 Migration Statistics
            If Reconciliation Excel available, generate this table:
            Metric               | Count  | Percentage
            Total scripts        | 400    | 100%
            Migrated             | {N}    | {N}%
            Not migrated         | {N}    | {N}%
            Clean migration      | {N}    | {N}%
            Structural splits    | {N}    | {N}%
            Name mismatches only | {N}    | {N}%

        3.3 Scripts Migrated — Full List
            Table: ADO Tag | ADO Title | Old Title | New Title | Status
            Pull from Reconciliation Excel, MIGRATED rows only.
            If Excel not available: note "See reconciliation report."

        3.4 Scripts Remaining — Full List
            Table: ADO Tag | ADO Title | Reason Not Migrated | Action Needed
            Pull from Reconciliation Excel, NOT MIGRATED rows only.

        3.5 Structural Splits Resolved
            Table: ADO Tag | Old Title | New Scenario 1 | New Scenario 2 | Notes
            Pull from Reconciliation Excel, STRUCTURAL SPLIT rows only.

Step 6-9: Decisions, risks, learnings, appendix. Same pattern.

---

## SECTION 4 — TEST STRATEGY (test-strategy)

### Purpose
Defines how testing is done on this project.
Used for client review and team alignment.

### Generation Steps

Step 1: Cover page. Title: "Test Automation Strategy — MC Healthcare Portal"

Step 2: TOC.

Step 3-9: Follow fixed template from docx.md Section 4 test-strategy definition.
          Pull objectives, scope, and test types from knowledge.md.
          Pull environment details from framework-architecture.instructions.md.

---

## SECTION 5 — RETROSPECTIVE (retrospective)

### Purpose
Internal document. Honest reflection on the project.
Used by the team and Sunil for future project improvement.
Not client-facing.

### Generation Steps

Step 1: Cover page. Title: "Project Retrospective — MC Automation Framework"
        Add: "INTERNAL USE ONLY — Not for client distribution"

Step 2: TOC.

Step 3: Section 3 — Main Content
        3.1 What Went Well
            Pull MILESTONE entries from devlog.md.
            Supplement with session entries where things ran smoothly.

        3.2 What Could Have Been Better
            Pull FAILURE and MISTAKE entries from devlog.md.
            Be honest. This document is internal.

        3.3 What We Would Do Differently
            Based on mistakes and risks, what would change
            if starting this project again from scratch.
            Copilot synthesizes this from devlog.md entries.

        3.4 Key Achievements
            Final migration statistics.
            Framework improvements delivered.
            Team capability improvements.

        3.5 Recommendations for Future Projects
            Pull from LEARNING entries in devlog.md.
            Synthesize into actionable recommendations.

---

## SECTION 6 — FINAL PROJECT REPORT (all documents)

When "run create-doc: final project report" is invoked:

Copilot generates all five documents in this order:
  1. kt-guide
  2. handover-report
  3. migration-report
  4. test-strategy
  5. retrospective

After each document is generated, Copilot says:
"{document name} complete — saved to {output path}"

After all five are complete:
"All 5 documents generated.
 Output folder: {output path}
 Files created:
   1. KT_Guide_{timestamp}.docx
   2. Handover_Report_{timestamp}.docx
   3. Migration_Report_{timestamp}.docx
   4. Test_Strategy_{timestamp}.docx
   5. Retrospective_{timestamp}.docx

 Remember: open each document in Word and press Ctrl+A
 then F9 to update the table of contents page numbers.

 Run pr-scan on the output folder before sharing
 any document with the client or team."

---

## IMPORTANT RULES FOR THIS SKILL

1. Always read all source files before generating any document.
   Never generate from memory or assumptions.
   The content must come from the actual project files.

2. Always call docx.md patterns for all Word generation code.
   Never invent new formatting or structure outside docx.md.

3. Sections 2, 4, 5, and 6 of every document are populated
   from devlog.md automatically. Never ask Sunil to manually
   provide decisions, risks, or learnings. They are already written.

4. If devlog.md has no entries for a section type
   (example: no RISK entries), write:
   "No risks were formally recorded during this project."
   Never leave a section empty or skip it.

5. Never include real patient data in any document.
   If any source file contains patient data, invoke pr-scan
   immediately and do not continue document generation until
   the issue is resolved.

6. Retrospective is marked INTERNAL USE ONLY.
   Never include it in a client-facing delivery package.
   Always remind Sunil of this after generating it.

7. Always run pr-scan on every generated document before
   presenting it to Sunil. pr-scan runs silently.
   Only report if pr-scan finds an issue.
   If pr-scan passes, say "pr-scan passed" at the end.

8. After generating any document, always say:
   "Document generated. Before sharing:
    1. Open in Word and press Ctrl+A then F9 to update TOC
    2. Review all [FILL IN] placeholders and complete them
    3. Run pr-scan if sharing outside the team
    4. Get client approval before sharing with MC"
