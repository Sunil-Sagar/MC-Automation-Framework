# ado-api-reference.instructions.md
# ATTACH: whenever any phase involves ADO API calls
# STATUS: [FILL IN REQUIRED] - complete project-specific values

## ADO DETAILS
Organization URL: https://dev.azure.com/MCLM
Project name:     [FILL IN]
API version:      7.0

## CONFIG.PROPERTIES KEYS
ado.org=https://dev.azure.com/MCLM
ado.project=[FILL IN]
ado.masterPlanId=[FILL IN]
ado.masterSuiteId=[FILL IN]
ado.releasePlanId=[FILL IN - updated each release]
ado.releaseSuiteId=[FILL IN - updated each release]
ado.pat=[FILL IN - never commit to repo]
ado.repositoryId=[FILL IN]
ado.reviewerIds=[FILL IN - comma separated]
ado.defaultBranch=main
report.outputPath=C:\Users\sunsagar\Sunil\Mayo\Automation\MC-Automation-Framework\output\reports
screenshot.outputPath=C:\Users\sunsagar\Sunil\Mayo\Automation\MC-Automation-Framework\output\screenshots

## AUTHENTICATION
Basic Auth. Base64 encode :{PAT} with colon prefix.
Header: Authorization: Basic {encoded}
PAT never logged printed or written anywhere except config.properties.

## KEY ENDPOINTS
Fetch test cases: GET /testplan/Plans/{planId}/suites/{suiteId}/testcase
Single test case: GET /wit/workitems/{id}
Create test run:  POST /test/runs
Update results:   PATCH /test/runs/{runId}/results
Fetch test points: GET /testplan/Plans/{planId}/suites/{suiteId}/testpoint
Create PR:        POST /git/repositories/{repoId}/pullrequests
Check PR:         GET /git/repositories/{repoId}/pullrequests/{prId}

## PAGINATION
All list endpoints: max 100 per page.
Use $top=100 and $skip=N. Increment skip by 100 each page.
Stop when results returned less than $top.
Never assume all 400 fit in one call.

## ERROR HANDLING
200 OK / 400 Bad request log and stop / 401 PAT expired stop
403 Wrong permissions stop / 404 Wrong ID stop
429 Rate limited retry max 3 / 500 Retry once then stop

## CRITICAL REMINDERS
Test Case ID and Test Point ID are NOT the same thing.
@tag in feature file IS the Test Case ID. Foundation of system.
PAT never in logs console or any file except config.properties.
Never PATCH or POST without showing Sunil what will be sent.
