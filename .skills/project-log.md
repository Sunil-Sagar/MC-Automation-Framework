# project-log.md
# SKILL: project-log
# ================================================================
# HOW TO INVOKE THIS SKILL:
# Type in Copilot Chat:
#   "run project-log"
#
# WHAT THIS SKILL DOES:
# Appends a timestamped entry to .project/devlog.md
# This is the long-term permanent memory of the project.
# No limit. Nothing is ever deleted. Everything is timestamped.
# Tracks milestones, failures, learnings, data sources, risks,
# project goals, steps followed, and decisions made.
#
# By the time this project ends, devlog.md will contain
# everything needed to write the final project documentation.
# No manual documentation effort required at the end.
# The work is already done entry by entry.
#
# This skill is called automatically by end-session.md.
# You can also call it directly at any point during a session
# to capture something important in the moment — a decision,
# a risk, a milestone, a failure, a learning.
# ================================================================

---

## TWO WAYS TO INVOKE THIS SKILL

### WAY 1 — End of session (called by end-session.md)
Copilot automatically generates the full session entry
and appends it to .project/devlog.md based on what
happened in the current session.

### WAY 2 — In the moment (called directly by Sunil)
Sunil types: "run project-log: {reason}"

Examples:
  "run project-log: milestone — Phase 0 reconciliation engine complete"
  "run project-log: decision — switching from JSONObject to Jackson"
  "run project-log: risk — Perfecto API rate limits unknown"
  "run project-log: learning — ADO pagination needs continuation token"
  "run project-log: failure — XPath locator strategy broke on iOS 17"

When called this way, Copilot writes a SHORT focused entry
capturing just that one thing, not a full session summary.

---

## TARGET FILE: .project/devlog.md

Rules:
- ALWAYS append. Never overwrite. Never delete.
- Every entry is separated by a clear divider.
- Entries are ordered oldest at top, newest at bottom.
- If .project/devlog.md does not exist, create it with the
  file header first, then append the first entry.
- This file has no size limit. Let it grow.
- This file is the source of truth for final documentation.

---

## FILE HEADER (written once when file is first created)

================================================
# MC PROJECT — PERMANENT DEVELOPMENT LOG
# Project: Old Framework to New Framework Migration
# Client: MC (Healthcare)
# Engineer: Sunil Sagar — Automation and Performance Tester
# Started: {DATE OF FIRST ENTRY}
#
# PURPOSE:
# This file is the permanent, append-only record of everything
# that happened on this project. Nothing is ever deleted.
# Every session, every decision, every milestone, every failure,
# every learning is recorded here in chronological order.
#
# When the project ends, this file contains everything needed
# to write the final project documentation, handover report,
# and retrospective. The documentation writes itself.
#
# DO NOT DELETE THIS FILE.
# DO NOT EDIT PAST ENTRIES.
# ONLY APPEND NEW ENTRIES AT THE BOTTOM.
================================================

---

## FORMAT — FULL SESSION ENTRY
# Used when called by end-session.md at end of session

================================================
## [{DATE} {TIME}] SESSION ENTRY — {PHASE NAME}
Type: Session Summary
Engineer: Sunil Sagar
Duration: {approximate}
================================================

### CONTEXT
{1-2 sentences. What was the state of the project at the
start of this session. What was the goal for this session.}

### COMPLETED THIS SESSION
{Bullet list. Everything that was finished and working
by the end of this session. Be specific.
Include: class names, method names, file paths, features built.
Example:
  - ADOClient.java — fetchTestCases() method complete with
    full pagination support. Tested against Master Test Plan.
    Returns List<TestCase> with ID and Title fields populated.
  - config.properties — added ado.masterPlanId and
    ado.masterSuiteId keys. Template updated in instructions file.}

### SKIPPED OR DEFERRED
{Bullet list. What was planned but not done and why.
If nothing deferred, write "Nothing deferred."}

### DECISIONS MADE
{Bullet list. Every decision made and approved by Sunil.
Format: DECISION: {what} | REASON: {why} | APPROVED BY: Sunil
Example:
  DECISION: Use HttpURLConnection instead of OkHttp
  REASON: No new dependencies without client approval.
          HttpURLConnection is standard Java, no pom.xml change needed.
  APPROVED BY: Sunil}

### MISTAKES AND CORRECTIONS
{Bullet list. Honest record of what went wrong and how it was fixed.
Format: MISTAKE: {what went wrong} | FIX: {how it was corrected}
Example:
  MISTAKE: Initial ADO API call used Test Case ID as Test Point ID.
           This caused a 400 Bad Request error.
  FIX: Separated the two ID types. Added Endpoint 5 call to
       fetch Test Point IDs before creating the test run.
If nothing went wrong, write "No mistakes this session."}

### MILESTONES REACHED
{Bullet list. Any significant milestone crossed this session.
Example:
  - MILESTONE: Phase 0 complete. Reconciliation engine builds
    master Excel with all 400 test cases mapped and color coded.
If no milestone reached, write "No milestone this session."}

### RISKS IDENTIFIED OR UPDATED
{Bullet list. New risks found this session or updates to
previously identified risks.
Format: RISK: {description} | SEVERITY: High/Medium/Low |
        STATUS: Open/Mitigated/Accepted | ACTION: {what to do}
Example:
  RISK: Perfecto API rate limits are not documented.
  SEVERITY: Medium
  STATUS: Open
  ACTION: Test with small batch first. Add retry logic with backoff.
If no new risks, write "No new risks identified."}

### LEARNINGS
{Bullet list. Technical or process learnings from this session.
These are things the team should know going forward.
Example:
  - ADO REST API requires Test Point ID not Test Case ID when
    creating test runs. These are different values. Always fetch
    Test Points via Endpoint 5 before creating a run.
  - Apache POI setCellStyle must be called after setCellValue
    or the style does not apply correctly.
If no new learnings, write "No new learnings this session."}

### OPEN QUESTIONS
{Bullet list. Questions that need answers before work can proceed.
Format: QUESTION: {what needs to be answered} |
        BLOCKING: {YES/NO} | ASKED TO: {who needs to answer}
Example:
  QUESTION: How is ExtentReports integrated in the framework?
  Via Cucumber JSON, EventListener, or IReporterPlugin?
  BLOCKING: YES — Phase 1 cannot be designed without this answer.
  ASKED TO: Sunil to check framework and confirm.
If no open questions, write "No open questions."}

### NEXT SESSION PLAN
{Numbered list. Exactly what the next session will do.
Maximum 5 items. Be specific enough to act on immediately.}

================================================

---

## FORMAT — SHORT FOCUSED ENTRY
# Used when called directly by Sunil mid-session
# "run project-log: {reason}"

================================================
## [{DATE} {TIME}] {TYPE}: {TITLE}
Type: {Milestone / Decision / Risk / Learning / Failure / Note}
Engineer: Sunil Sagar
Phase: {current phase}
================================================

{3-10 sentences or bullet points capturing the specific thing
Sunil wanted to record. No fixed sections for this format.
Just capture the thing clearly and completely.
Include enough context that someone reading this 6 months from
now understands what happened and why it mattered.}

================================================

---

## ENTRY TYPES AND WHEN TO USE THEM

MILESTONE
  Use when a phase, feature, or significant deliverable is complete.
  Example: "Phase 0 reconciliation engine complete and tested."

DECISION
  Use when a technical or process decision is made.
  Always include WHY the decision was made.
  Example: "Decided to use HttpURLConnection — reason: no new deps."

RISK
  Use when a new risk is identified or an existing risk changes.
  Always include severity and current status.
  Example: "Perfecto API rate limits unknown — severity: medium."

LEARNING
  Use when something is discovered that the team should know.
  Example: "ADO Test Point ID ≠ Test Case ID — always fetch separately."

FAILURE
  Use when something broke, had to be redone, or caused a setback.
  Be honest. This is a learning record, not a blame record.
  Example: "Wrong locator strategy used for iOS — had to redo 12 steps."

NOTE
  Use for anything that does not fit the above categories but
  needs to be recorded.
  Example: "Client confirmed PAT scope requirements — read and write."

---

## HOW THIS FILE BECOMES DOCUMENTATION

At the end of the project, when it is time to write:
- Final handover document
- Project retrospective
- KT (Knowledge Transfer) guide for the team
- Migration completion report for the client

Sunil types: "run create-doc: final project report"

The create-doc skill reads .project/devlog.md from start to
finish and generates the documentation automatically.

Because every session was logged here with decisions, learnings,
risks, and milestones, the documentation is already written.
create-doc just formats and organizes it.

This is why quality of entries matters.
Vague entries produce vague documentation.
Specific entries produce documentation that the client can use.

---

## IMPORTANT RULES FOR THIS SKILL

1. NEVER overwrite or delete any past entry in devlog.md.
   This is an append-only file. Past entries are permanent.

2. NEVER write vague entries. Every entry must be specific
   enough that someone reading it 6 months from now
   understands exactly what happened without asking questions.

3. ALWAYS include the timestamp on every entry.
   Format: [{DATE} {TIME}] — example: [2024-03-15 14:32]

4. When recording a MISTAKE or FAILURE, be honest and complete.
   Include what went wrong, why it went wrong, and how it was
   fixed. This is the most valuable part of the log.
   Teams that document failures learn faster than teams that hide them.

5. When recording a DECISION, always include the reason.
   A decision without a reason is useless 6 months later when
   someone asks "why did we do it this way?"

6. This is a healthcare project. Never record any patient data,
   test data containing real names or IDs, or any sensitive
   information in this log. Log technical decisions and actions
   only. Never log data values.
