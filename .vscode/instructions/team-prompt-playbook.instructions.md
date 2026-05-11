# team-prompt-playbook.instructions.md
# ================================================================
# THIS FILE IS FOR THE TEAM — NOT FOR COPILOT
#
# This is the Knowledge Transfer guide for the 5 QA Engineers
# and 1 QA Lead on the MC project.
#
# It tells you:
#   - How to start a Copilot session correctly
#   - What commands to use and when
#   - How to use each skill
#   - What to do when something goes wrong
#   - Common mistakes to avoid
#   - FAQ from real scenarios you will face
#
# READ THIS BEFORE YOUR FIRST SESSION WITH COPILOT.
# Keep it open in a separate tab while you work.
#
# Written by: Sunil Sagar — Automation and Performance Tester
# Project:    MC Healthcare Portal — Automation Framework
# ================================================================

---

## SECTION 1 — BEFORE YOU START

### What is GitHub Copilot in this project?

Copilot is your AI coding assistant inside VS Code.
On this project it has been set up with special instructions
that make it understand our framework, our rules, and our goals.

Think of it as a very capable junior engineer who:
  - Knows the entire codebase
  - Never forgets the rules
  - Always asks before doing anything
  - Needs YOUR approval before touching any file
  - Will not make decisions on your behalf

You are always in charge. Copilot assists. You decide.

### What Copilot will NOT do

  - It will not write code without your approval
  - It will not modify files without showing you first
  - It will not push anything to the repository
  - It will not make decisions about your framework
  - It will not assume things it has not read from your files

If Copilot ever tries to do any of the above without asking:
Type "stop" and read Section 5 of this guide.

---

## SECTION 2 — HOW TO START A SESSION

### Step 1 — Open VS Code with the correct workspace
Make sure both the Old Framework folder and New Framework folder
are visible in your VS Code workspace.
Copilot needs to see both to do its job correctly.

### Step 2 — Open Copilot Chat
Click the Copilot icon in the left sidebar
or press Ctrl+Shift+I to open Copilot Chat.

### Step 3 — Paste the master prompt
The master prompt is saved in:
  .github/copilot-instructions.md

You do NOT need to paste this manually.
Copilot reads it automatically at the start of every session.

If for any reason it does not seem to know the project context:
Open .github/copilot-instructions.md
Copy the entire content
Paste it as your first message in Copilot Chat

### Step 4 — Attach relevant instruction files
Depending on what you are working on today, attach the
relevant instruction file using the paperclip icon in chat:

Working on Phase 0 → attach phase0-reconciliation.instructions.md
Working on Phase 1 → attach phase1-reporter.instructions.md
Working on Phase 2 → attach phase2-migration.instructions.md
Working on Phase 3 → attach phase3-web-healer.instructions.md
Working on Phase 4 → attach phase4-perfecto-healer.instructions.md
General framework work → attach framework-architecture.instructions.md
ADO API work → attach ado-api-reference.instructions.md
Excel output work → attach excel-output-spec.instructions.md

You can attach multiple files at once.

### Step 5 — Orient Copilot to where you left off
Type this to start:

  "Read .project/handoff.md and .project/daily-log.md
   and tell me where we left off."

Copilot will read both files and summarize the current state.
It will then ask which phase you are working on today.

### Step 6 — Tell Copilot what to do
Now tell Copilot what you need:
  "Start Phase 0"
  "Continue Phase 2 from where we left off"
  "Run end-session"
  "Run data-explore on the reconciliation report"

---

## SECTION 3 — THE APPROVAL COMMANDS

These are the only commands you need to control Copilot.
Learn these and use them consistently.

### TO APPROVE A PLAN
  "proceed"
  Use after Copilot presents a plan and you agree with it.

### TO APPROVE CODE
  "build this"
  Use after Copilot shows you code and you want it written.

### TO REJECT AND CHANGE
  "stop, change {X} to {Y}"
  Example: "stop, change the column width from 15 to 20"
  Copilot stops, makes your change, and presents again.

### TO PAUSE IMMEDIATELY
  "stop"
  Copilot stops whatever it is doing.
  It summarizes what was done and waits.
  Use this any time something looks wrong.

### TO RESUME AFTER A STOP
  "resume from where we stopped"
  Copilot picks up from the last confirmed step.

### TO ASK A QUESTION WITHOUT TRIGGERING ACTION
  "question: {your question}"
  Example: "question: why did you choose XPath over CSS here?"
  Copilot answers without taking any action.

### TO SKIP SOMETHING
  "skip this, move to next"
  Copilot logs the skip and moves to the next item.
  Use during migration when you want to defer a specific script.

### TO SEE THE CURRENT PLAN
  "show me the plan"
  Copilot summarizes what it plans to do next without doing it.

### TO SEE WHAT FILES WERE CHANGED
  "show me what was changed this session"
  Copilot lists every file created or modified.

---

## SECTION 4 — HOW TO USE THE SKILLS

Skills are reusable commands built specifically for this project.
Type the skill name in Copilot Chat to invoke it.

### DAILY SKILLS — USE EVERY SESSION

"run end-session"
  Use this BEFORE you /clear or close VS Code.
  It does three things automatically:
    1. Updates the daily log (last 5 sessions)
    2. Appends to the permanent project log
    3. Writes the handoff note for the next session
  Then asks if you want to push to the ADO repository.
  NEVER skip this. If you clear chat without running it,
  that session's work is not recorded anywhere.

"run end-session: status"
  Use at the START of a session if you forgot to run
  end-session at the end of the previous session.
  It reads and summarizes the current log state without writing.

### QUALITY SKILLS — RUN WHEN NEEDED

"run validation"
  Checks the last output against all project rules.
  Copilot runs this automatically before saying "task complete"
  but you can also run it manually if something looks off.

"run pr-scan"
  Privacy and security check before committing anything.
  ALWAYS run this before pushing to the repository.
  Especially important on this project because of patient data.

"run data-explore: {file path}"
  Profiles an Excel or feature file automatically.
  Use before starting any phase to check data quality.
  Example: "run data-explore: reconciliation"

### DOCUMENTATION SKILLS — USE AT END OF PROJECT

"run create-doc: kt-guide"
  Generates the Knowledge Transfer guide as a Word document.
  Reads your project logs and builds the document automatically.

"run create-doc: handover-report"
  Generates the client handover report.

"run create-doc: migration-report"
  Generates the full migration statistics report.

"run create-doc: final project report"
  Generates all five documents at once.

### LOGGING SKILLS — USE MID-SESSION WHEN NEEDED

"run project-log: milestone — {what was achieved}"
  Use immediately when something significant is completed.
  Example: "run project-log: milestone — Phase 0 complete"

"run project-log: decision — {what was decided and why}"
  Use when a significant technical decision is made.
  Example: "run project-log: decision — using HttpURLConnection
           instead of OkHttp to avoid new dependencies"

"run project-log: risk — {risk description}"
  Use when a new risk is identified.
  Example: "run project-log: risk — Perfecto API rate limits unknown"

---

## SECTION 5 — WHEN SOMETHING GOES WRONG

### Copilot is going off track

Signs: it is doing something you did not ask for,
       it skipped your approval, it assumed something.

What to do:
  1. Type "stop" immediately
  2. Type "what did you just do and why"
  3. Review what happened
  4. If files were changed without approval:
     Type "list every file you modified in the last action"
     Manually revert any unapproved changes using git

### Copilot wrote placeholder code

If you see comments like "// TODO" or "// add your logic here":
  Type "stop — you have written placeholder code in {file name}.
        Complete every placeholder before we continue."
  Copilot must complete all code. Never accept incomplete code.

### Copilot created a duplicate step definition

This is a serious error. It will break the entire test suite.
Signs: Cucumber throws AmbiguousStepDefinitionsException on run.

What to do:
  1. Type "stop immediately"
  2. Type "you have created a duplicate step definition.
          Search all Steps.java files and show me every
          method that has matching annotation text."
  3. Remove the duplicate (keep the original, delete the new one)
  4. Run the suite to confirm the error is gone

### Copilot is not reading files correctly

Signs: it says "I assume the folder is..." or
       "the file probably contains..."

What to do:
  Type "do not assume. read the actual file at {path} and
        tell me exactly what you found."

### Copilot seems to have forgotten the project context

This can happen in long sessions.
What to do:
  Type "re-read .project/knowledge.md and
        .github/copilot-instructions.md and confirm
        you understand the project context."

### You accidentally cleared the chat

What to do:
  1. Start a new session
  2. Paste the master prompt from .github/copilot-instructions.md
  3. Type "run end-session: status" to see current log state
  4. Manually write a brief log entry:
     "run project-log: note — session was cleared accidentally.
      Last known state: {describe what you were doing}"

### A test failed after a migration

What to do:
  1. Type "stop — test {tag} is failing after migration.
          The error is: {paste error message}"
  2. Copilot will investigate which step or locator is failing
  3. Do NOT run Phase 3 healer on migrated tests immediately
     First understand if it is a migration issue or a real locator change
  4. Fix the root cause first

---

## SECTION 6 — COMMON MISTAKES TO AVOID

### MISTAKE 1 — Clearing chat without running end-session
Impact: The session's work, decisions, and risks are not recorded.
        The next session starts without context.
Fix: Run "run end-session" BEFORE every /clear. No exceptions.

### MISTAKE 2 — Approving code without reading it
Impact: Incorrect code gets written to files.
        Could break the test suite silently.
Fix: Read every piece of code Copilot presents.
     If you do not understand a section: type "question: explain {section}"
     Never say "proceed" to code you have not read.

### MISTAKE 3 — Letting Copilot skip the learning phase in Phase 2
Impact: Migrations are incorrect and fail at runtime.
Fix: Phase 2 must always start with the learning phase.
     If Copilot tries to skip it: type
     "do not skip the learning phase. read 15 files from each
      framework first and present your findings before migrating."

### MISTAKE 4 — Pushing to the repository without pr-scan
Impact: Patient data, credentials, or debug code could be committed.
Fix: Always run "run pr-scan" before every git push.
     Never commit without client approval.

### MISTAKE 5 — Accepting a fix for Phase 4 without Perfecto verification
Impact: The fixed locator may look correct but fail on the real device.
Fix: After every Phase 4 fix is written, run the test on Perfecto.
     Confirm it passes before marking it as healed.

### MISTAKE 6 — Modifying .project/devlog.md manually
Impact: The permanent log becomes inconsistent.
        create-doc generates incorrect documentation.
Fix: Never edit devlog.md manually.
     Only Copilot appends to it via the project-log skill.
     If you need to add something: type
     "run project-log: note — {your note}"

### MISTAKE 7 — Asking multiple questions at once
Impact: Copilot may answer all of them at once and take action
        on the first one before you review the others.
Fix: Ask one question at a time.
     Wait for the answer before asking the next.

---

## SECTION 7 — FAQ

Q: How do I know which phase to work on?
A: Run "run end-session: status" at the start of each session.
   It reads the handoff note and tells you exactly where you left off.
   If you are starting fresh: start with Phase 0.

Q: Can I work on multiple phases in one session?
A: Yes, but only move to the next phase when the current one
   meets its completion criteria. Never start Phase 1 if
   Phase 0 is not complete. The phases depend on each other.

Q: Copilot is taking a long time to respond. Is that normal?
A: Yes for complex tasks. Reading 400 feature files takes time.
   Do not interrupt it mid-read. Wait for the response.
   If it has been more than 2 minutes: type "are you still reading?"

Q: Can I use Copilot for tasks not related to these phases?
A: Yes. You can ask Copilot general coding questions, ask it to
   explain code, help with debugging, or generate test data.
   For general tasks you do not need to attach instruction files.

Q: Someone else on the team made changes to the framework.
   Will Copilot know about them?
A: Copilot reads the actual files every session.
   If the files were changed, it will see the new content.
   Always start sessions with "read the project structure"
   to make sure Copilot has the latest state.

Q: Can I share the copilot-instructions.md with the client?
A: Check with Sunil first. The file contains internal project
   details. It is not confidential but should be reviewed
   before external sharing.

Q: What if Copilot suggests something that conflicts with
   what the client asked for?
A: Type "stop" and consult Sunil before proceeding.
   Client requirements always take priority over Copilot suggestions.
   Sunil is the final decision maker on all technical choices.

Q: The reconciliation Excel shows a script as NOT MIGRATED
   but I already migrated it. What do I do?
A: Type: "update the reconciliation Excel for tag @{tag}.
          The migration status should be MIGRATED.
          The new framework title is: {exact title}"
   Copilot will update the Excel. Always verify the update.

Q: I need to add a new test case to the new framework.
   How do I do it without Copilot?
A: See Section 3.3 of the KT Guide document.
   The guide has step-by-step instructions for adding test cases
   without needing Copilot assistance.

Q: What is the difference between daily-log.md and devlog.md?
A: daily-log.md = last 5 sessions only. Quick reference.
   devlog.md = permanent full history. Never deleted.
   Think of daily-log as your desk notepad and devlog as
   the official project logbook.

Q: Can I run regression while Copilot is also doing migration work?
A: Yes. They are separate processes.
   Copilot works on files in the IDE.
   The test runner executes the framework.
   They do not conflict. But coordinate with the team so
   you are not migrating a file while someone else is running it.

Q: I got an AmbiguousStepDefinitionsException. What does that mean?
A: It means two step definitions have the same annotation text.
   Cucumber cannot decide which one to use.
   This means a duplicate was created during migration.
   See Section 5 — "Copilot created a duplicate step definition."
   This must be fixed before any tests can run.

Q: The ADO Test Case title is very long. Can I shorten it
   when I write the Scenario title?
A: No. The Scenario title must match the ADO title exactly.
   This is the rule that keeps ADO and the framework in sync.
   If you think an ADO title needs to be shortened, raise it
   with the QA Lead. The change must be made in ADO first,
   then reflected in the framework.

---

## SECTION 8 — QUICK REFERENCE CARD

Print this section and keep it at your desk.

START OF SESSION:
  1. Open VS Code with both frameworks visible
  2. Copilot reads master prompt automatically
  3. Attach relevant instruction file for today's phase
  4. Type: "read .project/handoff.md and tell me where we left off"

APPROVAL COMMANDS:
  proceed          → approve a plan
  build this       → approve code
  stop             → pause everything
  stop, change X to Y → reject and change
  resume           → continue after stop
  skip this        → defer current item
  question: {X}   → ask without triggering action

SKILLS:
  run end-session          → shutdown ritual (use BEFORE /clear^)
  run end-session: status  → check log state
  run pr-scan              → privacy check before commit
  run validation           → quality check on last output
  run data-explore: {file} → profile a dataset
  run project-log: {type}  → log a decision/risk/milestone

END OF SESSION:
  1. Type: "run end-session"
  2. Wait for all three steps to complete
  3. Answer the ADO push question
  4. Wait for final confirmation
  5. NOW you can /clear or close VS Code

EMERGENCY STOP:
  Something looks wrong? Type "stop" immediately.
  Ask "what did you just do and why" before anything else.
  Review. Then decide whether to continue or revert.

---

## SECTION 9 — CONTACTS

Project lead:     Sunil Sagar — Automation and Performance Tester
                  Escalate all framework questions to Sunil first.

Client contact:   MC team — all changes require client approval
                  before being pushed to the shared repository.

For questions about this playbook: ask Sunil.
For questions about ADO: check the ADO Wiki first.
For questions about Perfecto: check with your Perfecto admin.
