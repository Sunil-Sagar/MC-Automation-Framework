# session-end.md
# SKILL: session-end
# ================================================================
# HOW TO INVOKE THIS SKILL:
# At the end of any working session, type in Copilot Chat:
#   "run session-end"
#
# WHAT THIS SKILL DOES:
# Step 1 — Writes a short handoff note to .project/handoff.md
#           Overwrites the previous handoff note every time.
#           This file always reflects the CURRENT state only.
# Step 2 — Writes a full dev log entry to .project/devlog.md
#           Appends to the bottom. Never overwrites. Never deletes.
#           Every session is permanently recorded here.
# Step 3 — Asks Sunil if he wants to push to ADO repository.
#           Never pushes automatically. Always asks first.
#
# IMPORTANT:
# This skill is usually called by end-session.md which also
# calls wrap-session.md and project-log.md together.
# You can also call session-end directly on its own if needed.
# ================================================================

---

## STEP 1 — WRITE HANDOFF NOTE

When this skill runs, Copilot must:

1. Read the entire conversation history of the current session
   from start to finish before writing anything.
   Do not summarize from memory. Read what actually happened.

2. Write the following handoff note to .project/handoff.md.
   Overwrite whatever was there before. This file is always
   the latest state only.

3. Use exactly this format. Do not add extra sections.
   Do not remove any section. Fill every section fully.

---

FORMAT FOR .project/handoff.md:
================================================
# HANDOFF NOTE
Last updated: {DATE} {TIME}
Session duration: {approximate duration}
Phase active: {which phase was being worked on}
================================================

## WHERE WE ARE RIGHT NOW

{2-4 sentences. Plain English. What is the current state of
the project. What was completed this session. What is partially
done. What is waiting. Be specific — name files, class names,
methods, anything concrete that the next session needs to know.}

## WHAT TO DO NEXT

{Numbered list. Each item is one concrete next action.
Be specific enough that someone reading this cold can
pick up and continue without asking questions.
Example: "1. Open ADOClient.java and complete the pagination
loop starting at line 47. The $skip variable is declared but
the while loop condition is not written yet."}

## WHAT TO WATCH OUT FOR

{Bullet list. Risks, gotchas, unresolved decisions, things
that were flagged but not yet resolved, dependencies that
are not confirmed yet. If nothing to watch out for, write
"Nothing flagged this session." Do not leave this blank.}

## DECISIONS MADE THIS SESSION

{Bullet list. Every decision that was made and approved by
Sunil this session. Example: "Decided to use HttpURLConnection
instead of OkHttp to avoid adding new dependencies."
If no decisions were made, write "No new decisions this session."}

## FILES TOUCHED THIS SESSION

{List every file that was created, modified, or read in detail
this session. Format: ACTION | FILE PATH | WHAT CHANGED
Example:
  CREATED  | src/main/java/reconciliation/ADOClient.java | new file
  MODIFIED | config.properties | added ado.masterPlanId key
  READ     | pom.xml | verified Apache POI dependency present}
================================================

---

## STEP 2 — WRITE DEV LOG ENTRY

After writing the handoff note, Copilot must append a new entry
to .project/devlog.md.

Rules:
- ALWAYS append. Never overwrite. Never delete existing entries.
- Each entry is separated by a divider line.
- If .project/devlog.md does not exist yet, create it with a
  header first, then append the first entry.

FORMAT FOR EACH ENTRY IN .project/devlog.md:
================================================
---
## SESSION LOG
Date: {DATE}
Time: {START TIME} to {END TIME} (approximate)
Phase: {which phase}
Engineer: Sunil Sagar
================================================

### WHAT GOT BUILT
{Bulleted list. Be specific. Name every class, method, file,
or feature that was completed and working by end of session.
If nothing was fully completed, say so honestly.}

### WHAT GOT SKIPPED OR DEFERRED
{Bulleted list. Anything that was planned for this session
but did not get done, and why. If nothing was skipped, write
"Nothing deferred this session."}

### DECISIONS MADE
{Bulleted list. Every decision made and approved by Sunil.
Include WHY the decision was made, not just what it was.
Example: "Used HttpURLConnection instead of OkHttp — reason:
no new dependencies without client approval, and
HttpURLConnection is available in standard Java."}

### MISTAKES OR WRONG TURNS
{Bulleted list. Honest account of anything that went wrong,
had to be redone, or was built incorrectly and corrected.
This is not a blame log. It is a learning log.
If nothing went wrong, write "Clean session, no wrong turns."}

### RISKS AND OPEN QUESTIONS
{Bulleted list. Anything unresolved, uncertain, or that needs
a decision before the next session can proceed.
If nothing open, write "No open risks or questions."}

### NEXT SESSION MUST START WITH
{Numbered list. The exact first 3 things the next session
should do, in order. Be specific enough that Copilot can
read this and know exactly where to begin without asking.}
================================================

---

## STEP 3 — ASK ABOUT ADO REPOSITORY PUSH

After completing Steps 1 and 2, Copilot must ask exactly this:

"Session-end complete.

Handoff note written to .project/handoff.md
Dev log entry appended to .project/devlog.md

Do you want to push the changes from this session to the
ADO repository?

If yes, tell me:
  1. Which files should be included in the commit
  2. What commit message to use
  3. Which branch to push to

I will show you the exact git commands to run.
I will NOT run them automatically.
You run them yourself after reviewing."

Rules for the push step:
- Copilot NEVER runs git commands automatically
- Copilot NEVER decides which files to commit
- Copilot NEVER decides the commit message
- Copilot NEVER decides the branch
- Copilot only suggests the git commands after Sunil provides
  all three pieces of information above
- If Sunil says no to the push, Copilot says:
  "Understood. Changes are saved locally. Session closed."
- Remember: client approves all changes. Nothing goes to the
  repository without client sign-off. Copilot must remind
  Sunil of this if pushing to a shared or main branch.

---

## IMPORTANT RULES FOR THIS SKILL

1. Do not summarize the session from memory or assumption.
   Read the actual conversation before writing anything.

2. Do not skip any section in the handoff note or dev log.
   Every section must be filled. If a section has nothing
   to report, write an explicit "nothing to report" statement.
   Never leave a section blank.

3. Do not write vague entries like "worked on Phase 0" or
   "made some progress". Every entry must be specific enough
   for someone reading it cold to understand exactly what
   happened without asking any questions.

4. The handoff note is for the next session.
   Write it as if you are handing off to a colleague who
   knows the project but was not in this session.

5. The dev log is permanent project history.
   Write it as if it will be read during a final project
   retrospective or used to generate project documentation.
   It probably will be.
