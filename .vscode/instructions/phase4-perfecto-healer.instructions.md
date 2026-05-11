# phase4-perfecto-healer.instructions.md
# Attach this file in Copilot Chat when you say "start Phase 4"
# This file gives Copilot everything it needs to build the
# Perfecto Mobile Locator Healer.
#
# ATTACH ALONGSIDE:
#   - framework-architecture.instructions.md
#   - phase3-web-healer.instructions.md
#   - .skills/validation.md
#   - .skills/standard-of-working.md
#
# PREREQUISITES:
#   Phase 3 must be complete and stable before Phase 4.
#   Phase 4 reuses several classes from Phase 3.
#   Building Phase 4 before Phase 3 means building twice.
#
# CRITICAL DIFFERENCE FROM PHASE 3:
#   Phase 3 — web tests run locally, live DOM available.
#   Phase 4 — mobile tests run on Perfecto lab devices.
#             DOM is NOT available live during execution.
#             DOM snapshots are retrieved AFTER the session ends
#             via Perfecto API or dashboard download.
#             This means Phase 4 is ALWAYS reactive (Mode B).
#             There is no live healing mode for Perfecto.
#
# HUMAN-IN-THE-LOOP IS MANDATORY FOR EVERY SINGLE FIX.
# No exceptions. No batch auto-apply. Every fix individually
# reviewed and approved by Sunil before any file is touched.
#
# INSTRUCTIONS FOR SUNIL:
#   Before starting Phase 4, answer these questions for Copilot:
#   Q1: How do you access post-session DOM snapshots from Perfecto?
#       (Perfecto dashboard download, Perfecto API, or both)
#   Q2: What locator strategies are used for mobile elements?
#       (XPath, resource-id, accessibility-id, name, or combination)
#   Q3: Do mobile and web Pages.java files share the same class
#       or are they separate classes for mobile vs web?
#   Q4: What is the Perfecto host URL your team uses?
#       (format: {yourcloud}.perfectomobile.com)
#   Copilot will ask these questions at the start of Phase 4.
# ================================================================

---

## WHAT PHASE 4 BUILDS

Phase 4 builds a Perfecto Mobile Locator Healer that:
  1. Reads Perfecto session IDs from failed test runs
  2. Retrieves post-session DOM snapshots from Perfecto
     (via Perfecto API or from downloaded snapshot files)
  3. Sends the failed mobile locator + DOM snapshot to Claude API
  4. Claude suggests a corrected mobile locator
  5. Presents the old and new locator to Sunil side by side
  6. Writes the fix to Pages.java ONLY after Sunil explicitly approves
  7. Every single fix requires individual approval — no exceptions

Phase 4 reuses from Phase 3:
  - ClaudeApiClient.java (extended for mobile context)
  - PagesFileUpdater.java (unchanged)
  - HealingReport.java (extended for mobile entries)
  - FailedLocator.java (extended with mobile fields)

Phase 4 adds new:
  - PerfectoSessionClient.java
  - PerfectoDOMExtractor.java
  - MobileLocatorHealingService.java
  - MobileHealerMain.java

---

## FIRST QUESTIONS — MUST BE ANSWERED BEFORE PLANNING

Before Copilot plans or writes anything for Phase 4:

"Before I plan Phase 4, I need to understand your Perfecto setup.

Q1: How do you access post-session DOM snapshots from Perfecto?
    A. Perfecto REST API — programmatic download after session
    B. Manual download from Perfecto dashboard as XML/HTML file
    C. Both available — prefer programmatic
    D. Not sure — need to check with Perfecto admin

Q2: What locator strategies are used for mobile elements?
    List all that apply:
    A. XPath (//android.widget.Button[@text='Login'])
    B. resource-id (com.example.app:id/login_button)
    C. accessibility-id (login_button)
    D. name (Login)
    E. class name (android.widget.Button)

Q3: Are mobile and web locators in the same Pages.java class
    or in separate classes?
    A. Same class — branching inside methods for web vs mobile
    B. Separate classes — MobileLoginPage.java vs WebLoginPage.java
    C. Mixed — some shared, some separate

Q4: What is your Perfecto host URL?
    (format: {yourcloud}.perfectomobile.com)
    This is needed for API calls.

Q5: Do you have a Perfecto security token available in
    config.properties already, or does it need to be added?

Your answers determine the architecture of Phase 4.
Please check and confirm before I proceed."

Copilot waits for all five answers before planning anything.

---

## PERFECTO API REFERENCE

### Authentication
All Perfecto API calls use a security token.
Token stored in config.properties:
  perfecto.host=[FILL IN — {yourcloud}.perfectomobile.com]
  perfecto.securityToken=[FILL IN — never hardcode]

Authentication header:
  PERFECTO-AUTHORIZATION: {securityToken}
  OR
  Parameter: securityToken={token} in query string
  Check Perfecto API docs for your cloud version.
  Ask Sunil which format your Perfecto instance uses.

### Endpoint — List Executions (find session IDs)
GET https://{host}/services/executions
Parameters:
  securityToken={token}
  startTime={epoch ms — start of run}
  endTime={epoch ms — end of run}
  status=FAILED
Response: list of execution objects with executionId

### Endpoint — Get Execution Report
GET https://{host}/services/reports/{executionId}
Parameters:
  securityToken={token}
  format=xml OR format=html
Response: execution report with steps, status, errors

### Endpoint — Download DOM Snapshot
Perfecto captures device DOM at specific points during execution.
GET https://{host}/services/executions/{executionId}/artifacts
Parameters:
  securityToken={token}
  type=DOM
Response: list of artifact URLs

Then download each artifact:
GET {artifactUrl}
Parameters:
  securityToken={token}
Response: XML or JSON DOM content

### IMPORTANT NOTE ON PERFECTO API:
Perfecto API endpoints and response structure vary by
cloud version and configuration.
Before writing PerfectoSessionClient.java:
  Ask Sunil: "Can you provide a sample Perfecto API response
             from your cloud instance, or access to the API docs
             for your specific Perfecto version?"
  Do not assume the exact endpoint format.
  Read actual documentation or sample responses first.

---

## JAVA CLASS PLAN

Present this plan and wait for approval before coding.

### REUSED FROM PHASE 3 (no changes needed)
  PagesFileUpdater.java   — reuse as-is
  HealingReport.java      — extend to add mobile-specific fields

### EXTENDED FROM PHASE 3

CLASS: FailedLocator.java (extended)
  Add mobile-specific fields to existing class:
    String platform         → "ANDROID" or "IOS"
    String appPackage       → mobile app package name
    String perfectoSessionId→ Perfecto execution session ID
    String deviceModel      → device model from Perfecto
    String osVersion        → OS version from Perfecto

CLASS: ClaudeApiClient.java (extended)
  Add mobile-specific prompt building:
    buildMobilePrompt(FailedLocator locator, String domContent)
                          → builds prompt with mobile context
  The mobile prompt differs from web prompt:
    - Mentions platform (Android/iOS)
    - Mentions available mobile locator strategies
    - Requests mobile-appropriate locator (not CSS)

### NEW CLASSES FOR PHASE 4

CLASS: PerfectoSessionClient.java
  Package:      healer
  Responsibility: Communicates with Perfecto REST API.
                  Retrieves session IDs and DOM snapshots.
  Methods:
    getFailedSessions(String startTime, String endTime)
                          → returns List<PerfectoSession>
    getDOMSnapshot(String executionId)
                          → returns String (DOM content)
    downloadArtifacts(String executionId)
                          → returns List<String> artifact URLs
    callPerfectoAPI(String endpoint, Map<String,String> params)
                          → returns String JSON response
    buildAuthHeader()     → returns auth header string

CLASS: PerfectoSession.java
  Package:      healer
  Responsibility: Data model. One Perfecto test session.
  Fields:
    String executionId
    String testName
    String status
    String startTime
    String endTime
    String deviceModel
    String osVersion
    String platform       → ANDROID or IOS
    String errorMessage
    String appPackage

CLASS: PerfectoDOMExtractor.java
  Package:      healer
  Responsibility: Parses Perfecto DOM snapshot XML/JSON.
                  Extracts relevant sections around failed element.
                  Strips patient data before any external call.
  Methods:
    extractDOM(String rawSnapshot)
                          → returns cleaned DOM String
    findElementContext(String dom, String failedLocatorValue)
                          → returns section of DOM around element
    stripSensitiveContent(String dom)
                          → removes text content, values, labels
                            keeps only structure and attributes

CLASS: MobileLocatorHealingService.java
  Package:      healer
  Responsibility: Orchestrates the mobile healing workflow.
                  Equivalent of LocatorHealingService for mobile.
  Methods:
    healSession(PerfectoSession session)
                          → full healing workflow for one session
    findFailedLocator(PerfectoSession session)
                          → extracts locator info from error message
    presentMobileFix(FailedLocator old, String suggested)
                          → shows comparison, waits for approval
    processApproval(String decision, FailedLocator old,
                    String suggested)
                          → handles yes/no/skip

CLASS: MobileHealerMain.java
  Package:      healer
  Responsibility: Entry point for Phase 4.
                  Reads config, retrieves sessions, runs healing.
  Methods:
    main(String[] args)

---

## MOBILE LOCATOR STRATEGIES

Mobile locators differ from web XPath. Claude must be told
which strategies are valid for mobile and in what preference order.

### Android Locator Preference Order
  1. resource-id    (most stable — matches element ID in app code)
     Format: com.example.app:id/element_name
     XPath:  //*[@resource-id='com.example.app:id/element_name']

  2. accessibility-id (stable if developer sets it)
     Format: login_button
     Appium: driver.findElement(AppiumBy.accessibilityId("login_button"))
     XPath:  //*[@content-desc='login_button']

  3. text/label     (readable but can change with app updates)
     XPath:  //android.widget.Button[@text='Login']
     XPath:  //*[@text='Login']

  4. class + index  (fragile — last resort)
     XPath:  //android.widget.Button[1]

### iOS Locator Preference Order
  1. accessibility-id (most stable for iOS)
     XPath:  //*[@name='login_button']

  2. label/value    (readable but can change)
     XPath:  //XCUIElementTypeButton[@label='Login']

  3. type + index   (fragile — last resort)
     XPath:  //XCUIElementTypeButton[1]

### Claude Mobile Prompt Template

SYSTEM PROMPT for mobile:
"You are an expert Appium mobile test automation engineer.
You are given a failed mobile locator and the current app DOM
(XML hierarchy from Appium). Your job is to suggest the most
reliable corrected locator for this element.

Rules for Android:
1. Prefer resource-id if available: //*[@resource-id='...']
2. Prefer content-desc (accessibility-id): //*[@content-desc='...']
3. Use text as fallback: //*[@text='...']
4. Never use position-based XPath: //android.widget.Button[1]
5. Never use class-only XPath: //android.widget.TextView

Rules for iOS:
1. Prefer accessibility id (name attribute): //*[@name='...']
2. Use label as fallback: //XCUIElementTypeButton[@label='...']
3. Never use index-based XPath

Return ONLY the corrected XPath string. Nothing else."

USER PROMPT for mobile:
"Failed locator:
Platform:  {ANDROID or IOS}
Strategy:  {strategy}
Value:     {value}
Variable:  {variableName}
Error:     {errorMessage}
App:       {appPackage}
Device:    {deviceModel}
OS:        {osVersion}

App DOM snapshot (relevant section):
{extracted DOM section — max 50000 chars, sensitive data stripped}"

---

## DOM SENSITIVITY RULES FOR MOBILE

Mobile app DOM (Appium XML hierarchy) may contain:
  - Text displayed in labels (could be patient name, results)
  - Values in input fields (could be health data)
  - Content descriptions (usually safe)

BEFORE sending DOM to Claude API:
  Strip the "text" attribute from all elements
  Strip the "value" attribute from input elements
  Strip the "label" attribute from text display elements
  Keep: resource-id, content-desc, class, bounds, enabled, clickable
  These structural attributes are safe and sufficient for locator repair.

Java implementation:
  Use regex or XML parser to remove text/value/label attributes.
  Pattern: text="[^"]*"    → replace with text=""
  Pattern: value="[^"]*"   → replace with value=""
  Pattern: label="[^"]*"   → replace with label=""

This must run in PerfectoDOMExtractor.stripSensitiveContent()
before any DOM content is passed to ClaudeApiClient.

---

## MANDATORY INDIVIDUAL APPROVAL RULES

Phase 4 has stricter approval requirements than Phase 3.
These rules are non-negotiable.

RULE 1 — Every fix individually approved
  There is no batch mode for Phase 4.
  There is no auto-apply mode for Phase 4.
  Every single suggested fix is presented to Sunil one at a time.
  Sunil approves or rejects each fix before the next is shown.

RULE 2 — Side by side presentation is mandatory
  Format:
  "================================================
   MOBILE LOCATOR FIX — {platform}
   ================================================
   Test:      {test name from Perfecto}
   Device:    {device model}
   OS:        {OS version}
   Session:   {executionId}

   Variable:  {variableName}
   File:      {filePath}
   Line:      {lineNumber}

   OLD LOCATOR:
     Strategy: {old strategy}
     Value:    {old value}

   SUGGESTED LOCATOR:
     Strategy: {new strategy}
     Value:    {new value}

   Confidence: {HIGH / MEDIUM / LOW}
   Reason:     {why this locator was suggested}

   WARNING: This is a mobile locator fix.
   Please verify this fix on a Perfecto device before
   considering this fix permanent.

   Approve? (yes / no / skip)"

RULE 3 — Low confidence fixes require extra confirmation
  If confidence is LOW:
  "This fix has LOW confidence. The suggested locator
   may not reliably identify the correct element.
   It is strongly recommended to manually verify this
   locator on the Perfecto device before approving.
   Are you sure you want to apply this fix? (yes / no)"

RULE 4 — Runtime verification reminder after every approval
  After every approved fix, Copilot says:
  "Fix written. IMPORTANT: This fix has not been verified
   at runtime on a Perfecto device yet.
   Please run the test on Perfecto and confirm it passes
   before marking this locator as healed."

RULE 5 — Never auto-approve even if similar fix was approved before
  Even if the exact same XPath change was approved for a
  different element in the same session, each fix is still
  presented individually. No shortcuts.

---

## BUILD SEQUENCE

STEP 1: Ask all five questions.
        Read framework Pages.java files to understand mobile structure.
        Confirm with Sunil whether mobile and web are in same class.

STEP 2: Confirm Perfecto API access.
        Ask Sunil for a sample API response from their Perfecto instance.
        Do not write PerfectoSessionClient until response structure confirmed.

STEP 3: Check ZScaler whitelist.
        "Is {host}.perfectomobile.com whitelisted in ZScaler
         for outbound API calls from the build machine?"
        If not: Phase 4 API mode cannot proceed.
        Fall back to manual DOM download approach (Q1 Option B).

STEP 4: Present full class plan. Wait for approval.

STEP 5: Check pom.xml.
        Phase 4 needs same dependencies as Phase 3.
        No new dependencies expected.
        Confirm with Sunil before adding anything.

STEP 6: Build classes in this order:
  6a. Extend FailedLocator.java with mobile fields
  6b. PerfectoSession.java           (no dependencies)
  6c. PerfectoDOMExtractor.java      (no dependencies)
  6d. PerfectoSessionClient.java     (depends on PerfectoSession)
  6e. Extend ClaudeApiClient.java    (add mobile prompt method)
  6f. MobileLocatorHealingService.java (depends on all above)
  6g. MobileHealerMain.java          (depends on all above)
  Each: present, approve, write, explain, validate, confirm.

STEP 7: Test with one known Perfecto failure.
        Ask Sunil: "Please provide a Perfecto session ID from a
                   recent failed run so I can test the retrieval."
        Walk through full workflow for that one failure.
        Confirm DOM retrieval, stripping, Claude suggestion.
        Do not write any fix to disk in this test run.
        Observation only for first test.

STEP 8: Full healing run.
        Process all failed sessions from the last regression run.
        Present every fix to Sunil one at a time.
        Log all decisions in healing report.

---

## PHASE 4 COMPLETION CRITERIA

Phase 4 is NOT complete until ALL of these are true:
  1. Perfecto session retrieval works correctly
  2. DOM snapshot download and parsing works
  3. Sensitive data stripping verified before any Claude API call
  4. Claude API returns valid mobile XPath suggestions
  5. Side-by-side presentation is clear with platform context
  6. Pages.java update works correctly (reused from Phase 3)
  7. Every fix individually presented — no batch auto-apply
  8. Healing report includes all mobile fix attempts
  9. pr-scan passes on all modified Pages.java files
  10. Sunil has approved at least 3 mobile fixes and confirmed
      they pass on Perfecto device in subsequent runs

---

## IMPORTANT REMINDERS FOR PHASE 4

1. Phase 4 is ALWAYS reactive. No live DOM. No Mode A.
   Perfecto DOM is only available post-session.
   Never attempt to capture DOM during live Perfecto execution.

2. Human-in-the-loop is MANDATORY. No exceptions.
   Mobile locator healing has higher risk than web healing.
   A wrong mobile locator can pass on one device and fail on another.
   Sunil reviews and approves every single fix. Always.

3. Sensitive data stripping is non-negotiable.
   stripSensitiveContent() runs on every DOM before Claude call.
   If stripping fails for any reason: skip that DOM.
   Never send unstripped DOM to Claude.
   Log: "DOM stripping failed for session {id} — skipped."

4. Perfecto security token in config.properties only.
   Never hardcode. Never log. Never print.
   perfecto.securityToken=[FILL IN]

5. Mobile fixes need runtime verification on Perfecto.
   A fix that looks correct from the DOM may behave differently
   on a real device due to scroll state, load timing, or
   platform-specific rendering.
   Always remind Sunil to run the test on Perfecto after approval.

6. If the Perfecto API is not accessible due to ZScaler:
   Fall back to manual DOM download:
     Sunil downloads the DOM snapshot XML from Perfecto dashboard.
     Places it in a designated input folder.
     MobileHealerMain reads from that folder instead of API.
   This fallback must be built as a config option:
     perfecto.domSource=API or perfecto.domSource=MANUAL_FOLDER
     perfecto.manualDomFolder=[FILL IN if using manual mode]

7. iOS and Android DOM structure are different.
   iOS uses XCUIElementType hierarchy.
   Android uses android.widget hierarchy.
   PerfectoDOMExtractor must detect platform from DOM content
   and pass the platform flag to ClaudeApiClient for correct prompting.
   Never send an Android DOM to Claude with iOS instructions or vice versa.
