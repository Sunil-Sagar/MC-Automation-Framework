# framework-architecture.instructions.md
# Attach this file in Copilot Chat at the start of every phase.
# INSTRUCTIONS FOR SUNIL: Every section marked with [FILL IN]
# means you need to replace the placeholder with the actual value
# from your project before attaching this file to any session.

---

## WORKSPACE OVERVIEW

This workspace contains TWO separate frameworks.
Copilot must always know which framework it is reading or modifying.
Never mix files from Old Framework into New Framework.

Old Framework root folder: [FILL IN]
New Framework root folder: [FILL IN]

---

## OLD FRAMEWORK - FOLDER STRUCTURE

Features folder:      [FILL IN]
Step definitions:     [FILL IN]
Locator/page files:   [FILL IN]
Config folder:        [FILL IN]

EXECUTION: Perfecto ONLY. Cannot run locally.
Real physical mobile devices inside Perfecto lab.

---

## NEW FRAMEWORK - FOLDER STRUCTURE

Step definitions folder:  [FILL IN]
Pages folder:             [FILL IN]
Runner folder:            [FILL IN]
Utilities folder:         [FILL IN]
Features folder:          [FILL IN]
Config folder:            [FILL IN]
Reports output folder:    [FILL IN]

EXECUTION:
- @local    runs Selenium locally
- @perfecto runs via Perfecto driver

---

## THREE-LAYER ARCHITECTURE

LAYER 1 - Feature Files
Location:   [FILL IN]
Language:   Gherkin (Given, When, Then, And, But)
Tag format: [FILL IN - example: @12345 or @TC_12345]
Rules:
- Never put Selenium logic in a .feature file
- Never change or remove a @tag without explicit instruction
- @tags are ADO Test Case IDs. They are sacred.

LAYER 2 - Step Definitions (Steps.java)
Location: [FILL IN]
Rules:
- NO Selenium actions. NO locators.
- Every method ONLY calls a method from a Pages.java file
- Search ALL Steps.java files before creating any new step
- Duplicate step definitions cause AmbiguousStepDefinitionsException

LAYER 3 - Page Object Model (Pages.java)
Location: [FILL IN]
Locator naming convention:    [FILL IN]
Locator strategy preference:  [FILL IN]
Rules:
- ALL locators live here and ONLY here
- ALL Selenium actions live here and ONLY here
- Never modify a locator without showing old and new side by side

---

## CONFIGURATION

Main config file: [FILL IN]
Required keys:    [FILL IN - list all keys in your config file]
Rule: PAT token value is NEVER hardcoded in any Java file

---

## MAVEN BUILD COMMANDS

Run regression: [FILL IN]
Run smoke:      [FILL IN]
Run single tag: [FILL IN]
Run local:      [FILL IN]
Run perfecto:   [FILL IN]

---

## REPORTS

Type:      ExtentReports HTML
Location:  [FILL IN]
Filename:  [FILL IN]
Screenshots folder: [FILL IN]
Screenshot naming:  [FILL IN]

---

## NAMING CONVENTIONS

Feature files:     [FILL IN]
Steps files:       [FILL IN]
Pages files:       [FILL IN]
Locator variables: [FILL IN]
Method names:      [FILL IN]

---

## WHAT COPILOT MUST NEVER DO

1. Never apply Old Framework structure to New Framework
2. Never create a Steps.java method without searching all
   existing Steps.java files for a matching annotation first
3. Never create a Pages.java method without searching all
   existing Pages.java files for the same method first
4. Never modify a locator without showing old and new side
   by side and waiting for Sunils approval
5. Never add a pom.xml dependency without checking it is
   not already present and waiting for Sunils approval
6. Never assume a folder path. Always read the actual structure.
