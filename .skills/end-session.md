# end-session.md
# SKILL: end-session
# ================================================================
# HOW TO INVOKE THIS SKILL:
# Type in Copilot Chat:
#   "run end-session"
#
# WHAT THIS SKILL DOES:
# This is the single daily shutdown command.
# It orchestrates three skills in strict order:
#   Step 1 — runs wrap-session   (.skills/wrap-session.md)
#   Step 2 — runs project-log   (.skills/project-log.md)
#   Step 3 — runs session-end   (.skills/session-end.md)
#
# One command. Everything runs. Nothing is missed.
# This is Sunil's daily shutdown ritual before /clear.
#
# WHEN TO USE:
# Run this at the end of every working session before
# closing VS Code or clearing the Copilot Chat window.
# Do not clear the chat before running this.
# Clearing the chat before end-session means the session
# history is lost and the logs cannot be written accurately.
#
# IMPORTANT ORDER:
# The three skills must always run in this exact order:
#   1. wrap-session FIRST  — updates the rolling daily log
#   2. project-log SECOND  — appends permanent dev log entry
#   3. session-end THIRD   — writes handoff note, asks about push
#
# Reason for this order:
# wrap-session and project-log both read the session conversation.
# session-end writes the handoff note which summarizes what
# wrap-session and project-log just captured.
# If session-end runs first, the handoff note is written before
# the logs are complete and may be inconsistent.
# ================================================================

---

## WHAT COPILOT DOES WHEN "run end-session" IS TYPED

Copilot must follow these steps exactly, in this exact order.
Do not skip any step. Do not reorder any step.
Do not combine steps.

---

### STEP 0 — ANNOUNCE START

Copilot says exactly:

"Running end-session. This will take a moment.
I am reading the full session conversation now before writing anything.
Do not clear the chat until I confirm end-session is complete."

Then Copilot reads the ENTIRE session conversation from the very
first message to the current message.
Copilot also reads:
  - .project/daily-log.md (for wrap-session context)
  - .project/devlog.md (to know where to append)
  - .project/handoff.md (current state before this session)
  - .project/knowledge.md (project context)

Only after reading all of these does Copilot proceed to Step 1.

---

### STEP 1 — RUN wrap-session

Copilot executes the full wrap-session skill as defined in
.skills/wrap-session.md

This means:
- Creates a new session entry in the correct format
- Applies the rolling window rule (keep last 5 entries)
- Rewrites .project/daily-log.md completely
- Confirms to Sunil how many entries are now in the rolling window

When Step 1 is complete, Copilot says:
"Step 1 of 3 complete — daily-log.md updated."

Then immediately proceeds to Step 2. Does not wait for input.

---

### STEP 2 — RUN project-log

Copilot executes the full project-log skill as defined in
.skills/project-log.md

This means:
- Generates the full session entry in the correct format
- Includes: completed, deferred, decisions, mistakes,
  milestones, risks, learnings, open questions, next plan
- Appends the entry to .project/devlog.md
- Never overwrites anything already in devlog.md

When Step 2 is complete, Copilot says:
"Step 2 of 3 complete — devlog.md updated."

Then immediately proceeds to Step 3. Does not wait for input.

---

### STEP 3 — RUN session-end

Copilot executes the full session-end skill as defined in
.skills/session-end.md

This means:
- Writes the handoff note to .project/handoff.md
  (overwrites previous handoff note — always current state only)
- Confirms handoff note is written
- Then asks about ADO repository push

The ADO push question is the ONLY point where Copilot
pauses and waits for Sunil's input.
Everything before this runs automatically without interruption.

---

### FINAL CONFIRMATION

After all three steps are complete and the ADO push question
is answered (yes or no), Copilot says exactly:

"================================================
END-SESSION COMPLETE
================================================
Files updated this session:
  .project/daily-log.md     — rolling log updated ({N} entries)
  .project/devlog.md        — entry appended ({DATE} {TIME})
  .project/handoff.md       — handoff note written

ADO push: {PUSHED / NOT PUSHED — reason if not pushed}

Session summary in one line:
{Single sentence capturing the most important thing
that happened this session.}

You are clear to /clear the chat.
See you next session, Sunil.
================================================"

---

## WHAT COPILOT MUST NEVER DO DURING end-session

1. Never skip wrap-session, project-log, or session-end.
   All three must run every time without exception.

2. Never run the steps out of order.
   wrap-session → project-log → session-end. Always.

3. Never ask Sunil for input between Step 0 and the ADO push
   question in Step 3. The first two steps run fully automatic.
   The only pause is the ADO push question.

4. Never write vague log entries because the session was short
   or "nothing much happened." Even a short session where only
   planning or reading was done must be logged accurately.
   "Read 15 feature files to understand old framework patterns"
   is a valid and useful log entry.

5. Never clear or summarize only part of the conversation.
   Read the entire conversation from first message to last
   before writing anything. Missing context produces bad logs.

6. Never run end-session if the chat has already been cleared.
   If Sunil accidentally cleared the chat, tell him:
   "The session history is no longer available. I can write
   a partial log entry based on what you tell me manually.
   Please describe what was done this session and I will
   format it correctly into the log files."

---

## SHORTCUT COMMANDS RELATED TO end-session

"run end-session"
→ Full shutdown ritual. All three steps. Use this every day.

"run end-session: skip push"
→ Runs all three steps but skips the ADO push question entirely.
→ Use when you know you are not pushing today and want to
  finish faster.

"run end-session: quick"
→ Runs all three steps but uses shorter log entries.
→ Use for very short sessions where not much happened.
→ Still mandatory — never skip logging entirely.

"run end-session: status"
→ Does not write any logs.
→ Only reads and summarizes the current state of all three
  log files so Sunil can see where the project stands.
→ Use at the start of a session if you forgot to run
  end-session at the end of the previous session.

---

## REMINDER FOR SUNIL

This is your daily shutdown ritual:

BEFORE YOU /clear OR CLOSE VS CODE:
  1. Type: "run end-session"
  2. Wait for all three steps to complete
  3. Answer the ADO push question
  4. Wait for the final confirmation message
  5. Now you can /clear or close VS Code

If you skip end-session even once, that session's work,
decisions, risks, and learnings are not recorded anywhere.
The daily log and dev log will have a gap.
The handoff note will be stale.
The next session will start without context.

One command. 60 seconds. Everything is captured.
Do not skip it.
