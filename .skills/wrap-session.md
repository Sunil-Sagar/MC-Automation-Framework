# wrap-session.md
# SKILL: wrap-session
# ================================================================
# HOW TO INVOKE THIS SKILL:
# Type in Copilot Chat:
#   "run wrap-session"
#
# WHAT THIS SKILL DOES:
# Aggregates the current session into a daily log entry and
# stores it in .project/daily-log.md.
# Keeps only the last 5 session entries in this file.
# Older entries are not deleted — they live permanently in
# .project/devlog.md which project-log.md manages.
# The daily-log.md file is the QUICK REFERENCE — the 5 most
# recent sessions at a glance so the next session can orient
# itself in under 60 seconds.
#
# This skill is called automatically by end-session.md.
# You can also call it directly on its own if needed.
# ================================================================

---

## WHAT THIS SKILL READS BEFORE WRITING

Before writing anything, Copilot must:

1. Read the current .project/daily-log.md file completely.
   Understand how many entries are currently in it.
   If the file does not exist yet, note that and create it fresh.

2. Read the current session conversation from start to finish.
   Do not summarize from memory. Read what actually happened.

3. Read .project/handoff.md if it exists.
   Use it as additional context for what was done this session.

Only after reading all three sources does Copilot write anything.

---

## WHAT THIS SKILL WRITES

Target file: .project/daily-log.md

Rules:
- This file keeps ONLY the last 5 session entries at all times.
- When a new entry is added, if there are already 5 entries,
  the oldest entry is removed to make room for the new one.
- Entries are ordered newest first (most recent at the top).
- Never delete entries from devlog.md — that is permanent history.
  Only daily-log.md has the rolling 5-entry limit.
- If the file has fewer than 5 entries, just prepend the new one.
  Do not pad with empty entries.

---

## FORMAT FOR .project/daily-log.md

The entire file must follow this exact structure every time
this skill runs. Copilot rewrites the entire file from scratch
each time, keeping the 5 most recent entries.

================================================
# DAILY LOG — MC PROJECT
# Rolling window: last 5 sessions only.
# Full permanent history is in .project/devlog.md
# Last updated: {DATE} {TIME}
================================================

---

## ENTRY 1 — MOST RECENT SESSION
Date:          {DATE}
Time:          {approximate start} to {approximate end}
Phase:         {phase name and number}
Engineer:      Sunil Sagar

### IN ONE LINE
{Single sentence. What was the most important thing that
happened this session. Example: "Completed ADOClient.java
with full pagination support and error handling."}

### WHAT WAS COMPLETED
{Bullet list. Only things that are DONE and working.
Do not include things that are partially done here.
Be specific — file names, method names, feature names.}

### WHAT IS IN PROGRESS
{Bullet list. Things started but not finished.
Include exactly where the work stopped.
Example: "ADOClient.java pagination loop — while condition
written, response parsing not started yet."}

### WHAT IS BLOCKED OR WAITING
{Bullet list. Anything that cannot proceed until something
else happens. Name the blocker specifically.
Example: "Phase 1 cannot start until Sunil confirms how
ExtentReports is integrated in the framework."
If nothing blocked, write "Nothing blocked."}

### NEXT SESSION STARTS WITH
{Numbered list. Maximum 3 items. The exact first actions
the next session should take. Specific enough to act on
immediately without re-reading the entire conversation.}

---

## ENTRY 2 — PREVIOUS SESSION
{Same format as Entry 1}

---

## ENTRY 3
{Same format as Entry 1}

---

## ENTRY 4
{Same format as Entry 1}

---

## ENTRY 5 — OLDEST ENTRY IN THIS FILE
{Same format as Entry 1}

================================================
END OF DAILY LOG
Full history: see .project/devlog.md
================================================

---

## HOW TO HANDLE THE ROLLING WINDOW

When this skill runs, Copilot must follow these steps exactly:

Step 1: Read .project/daily-log.md
        Count how many entries currently exist (0 to 5).

Step 2: Create the new entry for the current session
        using the format above. Do not write it to the file yet.

Step 3: Apply the rolling window rule:
        - If current entries = 0: new file, add Entry 1 only
        - If current entries = 1: new entry becomes Entry 1,
          old Entry 1 becomes Entry 2
        - If current entries = 2: shift down, new is Entry 1,
          old 1 becomes 2, old 2 becomes 3
        - If current entries = 3: shift down, same pattern
        - If current entries = 4: shift down, same pattern
        - If current entries = 5: shift down, new is Entry 1,
          entries 1-4 become 2-5, old Entry 5 is DROPPED
          (it already exists permanently in devlog.md)

Step 4: Rewrite .project/daily-log.md completely from scratch
        with the updated header and all entries in correct order.

Step 5: Confirm to Sunil:
        "daily-log.md updated. {N} entries now in rolling window.
        Oldest entry removed: {YES/NO}
        Entry removed was from: {date of removed entry or N/A}"

---

## WHAT THE NEXT SESSION DOES WITH THIS FILE

At the start of every new session, after the Session Start
Checklist runs, Copilot must read .project/daily-log.md and
present a summary to Sunil like this:

"I have read your daily log. Here is where the project stands:

Most recent session ({date}): {one line summary from Entry 1}
Currently in progress: {in progress items from Entry 1}
Blocked or waiting: {blocked items from Entry 1}
Next session was supposed to start with:
  1. {item 1}
  2. {item 2}
  3. {item 3}

Shall we pick up from here or is there something else
you want to work on today?"

This ensures every session starts with full context in
under 60 seconds, regardless of how long ago the last
session was.

---

## IMPORTANT RULES FOR THIS SKILL

1. Never delete entries from .project/devlog.md.
   The rolling window rule applies ONLY to daily-log.md.

2. Never summarize from memory. Always read the actual
   conversation and the actual files before writing.

3. The "IN ONE LINE" field must be genuinely one sentence.
   Not a paragraph. Not a bullet list. One sentence that
   captures the single most important thing that happened.

4. "WHAT IS IN PROGRESS" must include the exact stopping point.
   Vague entries like "working on ADOClient" are not acceptable.
   The entry must say exactly where the code stopped, what line,
   what method, what was left to write.

5. If Sunil ran this skill and then continues working in the
   same session, the next time wrap-session runs it should
   include the additional work done after the last wrap.
   Always read the full conversation, not just since the last
   wrap-session call.
