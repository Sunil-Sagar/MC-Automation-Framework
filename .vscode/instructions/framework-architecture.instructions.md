# framework-architecture.instructions.md
# ATTACH: at start of every phase session
# STATUS: [FILL IN REQUIRED] - complete all sections below

## WORKSPACE OVERVIEW
Old Framework root: [FILL IN - likely: C:\path\to\Patient_Portal_Automation]
New Framework root: [FILL IN - likely: C:\path\to\Personalized_Plus]

## OLD FRAMEWORK FOLDERS
Features folder:      [FILL IN]
Step definitions:     [FILL IN]
Locator/page files:   [FILL IN]
Config folder:        [FILL IN]

## NEW FRAMEWORK FOLDERS
Step definitions:  [FILL IN]
Pages folder:      [FILL IN]
Runner folder:     [FILL IN]
Features folder:   [FILL IN]
Config folder:     [FILL IN]
Reports folder:    [FILL IN]

## THREE-LAYER ARCHITECTURE
LAYER 1 - Feature Files: [FILL IN exact path]
LAYER 2 - Steps.java:    [FILL IN exact path]
LAYER 3 - Pages.java:    [FILL IN exact path]

Tag format:         [FILL IN - example @12345 or @TC_12345]
Locator convention: [FILL IN - example btnLogin txtEmail]
Locator preference: [FILL IN - example ID first CSS second XPath third]

## MAVEN BUILD COMMANDS
Regression: [FILL IN]
Smoke:      [FILL IN]
Single tag: [FILL IN]
Local:      [FILL IN]
Perfecto:   [FILL IN]

## REPORTS
Report type:     ExtentReports HTML
Report location: [FILL IN]
Report filename: [FILL IN]
Screenshots:     C:\Users\sunsagar\Sunil\Mayo\Automation\MC-Automation-Framework\output\screenshots

## NAMING CONVENTIONS
Feature files: [FILL IN]
Steps files:   [FILL IN]
Pages files:   [FILL IN]

## POI IN POM.XML
Apache POI present: [FILL IN - YES or NO]
POI version:        [FILL IN if present]
JSON library:       [FILL IN - org.json / Jackson / Gson]

## WHAT COPILOT MUST NEVER DO
1. Apply Old Framework structure to New Framework
2. Create Steps.java method without searching all existing Steps files
3. Create Pages.java method without searching all existing Pages files
4. Modify a locator without showing old and new side by side
5. Add pom.xml dependency without checking it is missing first
6. Assume a folder path. Always read the actual structure.
