# xlsx.md
# SKILL: xlsx
# ================================================================
# HOW TO INVOKE THIS SKILL:
# This skill is NOT called manually in most cases.
# Copilot reads this file automatically whenever any phase
# requires creating, reading, or modifying an Excel file.
#
# Manual invocation:
#   "run xlsx: create reconciliation report"
#   "run xlsx: create run report"
#   "run xlsx: update {file path}"
#   "run xlsx: read {file path}"
#
# WHAT THIS SKILL DOES:
# Provides Apache POI patterns, column definitions, color codes,
# styling rules, and data population logic for every Excel file
# this project produces or consumes.
#
# THIS PROJECT PRODUCES TWO EXCEL FILES:
#   FILE 1 — Master Reconciliation Report  (Phase 0 output)
#   FILE 2 — Regression Run Report         (Phase 1 output)
#
# LIBRARY: Apache POI (XSSF for .xlsx format)
# Before using Apache POI, ALWAYS check pom.xml to confirm
# the dependency is present and note the exact version.
# Use only API methods available in that version.
# Never assume a version. Always read pom.xml first.
# ================================================================

---

## SECTION 1 — APACHE POI DEPENDENCY CHECK

Before writing any Excel code, Copilot must:

Step 1: Open pom.xml and search for "poi" dependency.
Step 2: If found, note the exact version and confirm it supports
        XSSF (xlsx format). Versions 3.x and above support XSSF.
Step 3: If NOT found, tell Sunil exactly:
        "Apache POI is not in pom.xml. I need to add these
         dependencies. Please approve before I add them:"
        Then show:
        <dependency>
            <groupId>org.apache.poi</groupId>
            <artifactId>poi-ooxml</artifactId>
            <version>{latest stable version}</version>
        </dependency>
        Wait for Sunil's approval before adding.
Step 4: Never add both poi and poi-ooxml with different versions.
        They must be the same version to avoid conflicts.

---

## SECTION 2 — STANDARD APACHE POI PATTERNS

### 2.1 — Creating a New Workbook and Sheet

// Always use XSSFWorkbook for .xlsx format
// Never use HSSFWorkbook — that is for old .xls format
XSSFWorkbook workbook = new XSSFWorkbook();
XSSFSheet sheet = workbook.createSheet("Sheet Name Here");

// Freeze the header row so it stays visible when scrolling
sheet.createFreezePane(0, 1);

// Set auto-filter on the header row
// Parameters: first row, last row, first col, last col
// Use after all data is written, not before
sheet.setAutoFilter(new CellRangeAddress(0, lastRowNum, 0, lastColNum));

### 2.2 — Creating the Header Row

// Always create header row at index 0
Row headerRow = sheet.createRow(0);
headerRow.setHeightInPoints(20); // slightly taller than data rows

// Style must be set on the cell, not just the row
// Create all styles ONCE at the top — do not create inside loops
XSSFCellStyle headerStyle = createHeaderStyle(workbook);

// Create each header cell
for (int i = 0; i < headers.length; i++) {
    Cell cell = headerRow.createCell(i);
    cell.setCellValue(headers[i]);
    cell.setCellStyle(headerStyle); // style after value
}

// Set column widths AFTER populating data for accuracy
// Or set fixed widths if you know the content
// Width unit is 1/256th of a character width
sheet.setColumnWidth(0, 20 * 256); // 20 characters wide

### 2.3 — Creating Data Rows

int rowNum = 1; // start at 1, row 0 is header
for (DataObject item : dataList) {
    Row row = sheet.createRow(rowNum++);
    row.setHeightInPoints(16);

    Cell cell0 = row.createCell(0);
    cell0.setCellValue(item.getFieldOne());
    cell0.setCellStyle(getStyleForRow(workbook, item)); // apply after value

    // ... repeat for each column
}

### 2.4 — Writing the File to Disk

// Always write to the output folder defined in config.properties
String outputPath = config.getProperty("report.outputPath");
String fileName = "ReportName_" + getTimestamp() + ".xlsx";
File outputFile = new File(outputPath + File.separator + fileName);

// Create output directory if it does not exist
outputFile.getParentFile().mkdirs();

try (FileOutputStream fos = new FileOutputStream(outputFile)) {
    workbook.write(fos);
} finally {
    workbook.close(); // always close to release memory
}

### 2.5 — Timestamp Helper Method

private String getTimestamp() {
    return new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
}

### 2.6 — Reading an Existing Excel File

try (FileInputStream fis = new FileInputStream(existingFile);
     XSSFWorkbook workbook = new XSSFWorkbook(fis)) {

    XSSFSheet sheet = workbook.getSheetAt(0);

    // Always check for null rows — Excel can have empty rows
    for (int i = 1; i <= sheet.getLastRowNum(); i++) {
        Row row = sheet.getRow(i);
        if (row == null) continue; // skip empty rows

        Cell cell = row.getCell(0);
        if (cell == null) continue; // skip empty cells

        String value = getCellValueAsString(cell);
    }
}

### 2.7 — Safe Cell Value Reader

// Always use this pattern — never assume cell type
private String getCellValueAsString(Cell cell) {
    if (cell == null) return "";
    switch (cell.getCellType()) {
        case STRING:  return cell.getStringCellValue().trim();
        case NUMERIC: return String.valueOf((long) cell.getNumericCellValue());
        case BOOLEAN: return String.valueOf(cell.getBooleanCellValue());
        case FORMULA: return cell.getCellFormula();
        default:      return "";
    }
}

---

## SECTION 3 — CELL STYLING RULES

### 3.1 — Color Codes (Apache POI uses IndexedColors or XSSFColor)

HEADER ROW BACKGROUND:
  Color:  Dark blue-grey
  Hex:    #2F4F6F
  Usage:  XSSFColor headerBg = new XSSFColor(new byte[]{(byte)0x2F,
                                (byte)0x4F, (byte)0x6F}, null);

HEADER ROW FONT:
  Color:  White
  Hex:    #FFFFFF
  Bold:   true
  Size:   11pt

DATA ROW — GREEN (exact match, fully migrated):
  Color:  #C6EFCE  (light green — matches Excel conditional format style)
  Hex:    new byte[]{(byte)0xC6, (byte)0xEF, (byte)0xCE}

DATA ROW — YELLOW (name mismatch, needs title update):
  Color:  #FFEB9C  (light yellow — matches Excel warning style)
  Hex:    new byte[]{(byte)0xFF, (byte)0xEB, (byte)0x9C}

DATA ROW — RED (not migrated to new framework):
  Color:  #FFC7CE  (light red/pink — matches Excel error style)
  Hex:    new byte[]{(byte)0xFF, (byte)0xC7, (byte)0xCE}

DATA ROW — ORANGE (structural split — one tag, multiple scenarios):
  Color:  #FFCC99  (light orange)
  Hex:    new byte[]{(byte)0xFF, (byte)0xCC, (byte)0x99}

DATA ROW — DEFAULT (no issues):
  Color:  White #FFFFFF or no fill
  Alternating rows optional: very light grey #F2F2F2 for readability

PASS STATUS (Phase 1 run report):
  Color:  #C6EFCE  (same green as match)
  Font:   Dark green #006100

FAIL STATUS (Phase 1 run report):
  Color:  #FFC7CE  (same red as not migrated)
  Font:   Dark red #9C0006

### 3.2 — Style Creation Pattern

// Create styles ONCE, reuse across rows
// Creating a new style per cell causes Excel to hit style limits
// Excel has a limit of approximately 64,000 unique cell styles

private XSSFCellStyle createHeaderStyle(XSSFWorkbook workbook) {
    XSSFCellStyle style = workbook.createCellStyle();
    XSSFFont font = workbook.createFont();

    // Font
    font.setBold(true);
    font.setFontHeightInPoints((short) 11);
    font.setColor(IndexedColors.WHITE.getIndex());
    style.setFont(font);

    // Background
    XSSFColor bgColor = new XSSFColor(
        new byte[]{(byte)0x2F, (byte)0x4F, (byte)0x6F}, null);
    style.setFillForegroundColor(bgColor);
    style.setFillPattern(FillPatternType.SOLID_FOREGROUND);

    // Border
    style.setBorderBottom(BorderStyle.THIN);
    style.setBorderTop(BorderStyle.THIN);
    style.setBorderLeft(BorderStyle.THIN);
    style.setBorderRight(BorderStyle.THIN);

    // Alignment
    style.setAlignment(HorizontalAlignment.CENTER);
    style.setVerticalAlignment(VerticalAlignment.CENTER);
    style.setWrapText(false);

    return style;
}

private XSSFCellStyle createColoredRowStyle(XSSFWorkbook workbook,
                                             byte[] rgbColor,
                                             boolean boldFont) {
    XSSFCellStyle style = workbook.createCellStyle();
    XSSFFont font = workbook.createFont();

    font.setBold(boldFont);
    font.setFontHeightInPoints((short) 10);
    style.setFont(font);

    XSSFColor bgColor = new XSSFColor(rgbColor, null);
    style.setFillForegroundColor(bgColor);
    style.setFillPattern(FillPatternType.SOLID_FOREGROUND);

    style.setBorderBottom(BorderStyle.THIN);
    style.setBorderTop(BorderStyle.THIN);
    style.setBorderLeft(BorderStyle.THIN);
    style.setBorderRight(BorderStyle.THIN);

    style.setAlignment(HorizontalAlignment.LEFT);
    style.setVerticalAlignment(VerticalAlignment.CENTER);
    style.setWrapText(false);

    return style;
}

---

## SECTION 4 — FILE 1: MASTER RECONCILIATION REPORT

### 4.1 — File Details
File name:    Reconciliation_Report_{timestamp}.xlsx
Sheet name:   Reconciliation
Output path:  config.getProperty("report.outputPath")
Phase:        Phase 0 output
Purpose:      Maps ADO test cases to Old Framework and New Framework.
              Single source of truth for migration status.

### 4.2 — Column Definitions (in this exact order)

Col 0 — ADO Tag
  Header:   "ADO Tag"
  Content:  The @tag value exactly as it appears in ADO and feature files
  Example:  @12345
  Width:    15 characters

Col 1 — ADO Title
  Header:   "ADO Title"
  Content:  The test case title exactly as it appears in ADO
  Example:  Verify patient can view appointment details
  Width:    50 characters

Col 2 — Old Framework Title
  Header:   "Old Framework Title"
  Content:  The Scenario or Scenario Outline title from old .feature file
  Example:  Patient_appointment_view
  Width:    50 characters

Col 3 — New Framework Title
  Header:   "New Framework Title"
  Content:  The Scenario or Scenario Outline title from new .feature file
            If not migrated yet, value is: "NOT MIGRATED"
  Width:    50 characters

Col 4 — Name Match Status
  Header:   "Name Match Status"
  Content:  One of these exact values:
              EXACT MATCH     — all three titles match
              NAME MISMATCH   — titles differ between framework and ADO
              NOT MIGRATED    — tag missing from new framework
              STRUCTURAL SPLIT — one tag maps to multiple scenarios
  Width:    20 characters

Col 5 — Migration Status
  Header:   "Migration Status"
  Content:  One of these exact values:
              MIGRATED        — tag exists in new framework
              NOT MIGRATED    — tag missing from new framework
              PARTIAL         — tag exists but title or steps differ
  Width:    18 characters

Col 6 — Split Case Flag
  Header:   "Split Case Flag"
  Content:  One of these exact values:
              YES             — one @tag maps to 2+ scenarios in old framework
              NO              — one @tag maps to exactly one scenario
  Width:    15 characters

Col 7 — Action Needed
  Header:   "Action Needed"
  Content:  One of these exact values:
              NONE            — no action needed, fully matched
              UPDATE TITLE    — title needs updating in framework
              MIGRATE         — script needs to be migrated to new framework
              REVIEW SPLIT    — structural split needs manual review
              VERIFY          — needs manual verification
  Width:    18 characters

### 4.3 — Color Coding Logic

if (migrationStatus == "NOT MIGRATED")          → RED row
else if (splitCaseFlag == "YES")                 → ORANGE row
else if (nameMatchStatus == "NAME MISMATCH")     → YELLOW row
else if (nameMatchStatus == "EXACT MATCH"
         && migrationStatus == "MIGRATED")       → GREEN row
else                                             → DEFAULT (white) row

### 4.4 — Summary Row
After the last data row, add one empty row then a summary section:

Row: "SUMMARY"
  Total test cases:         {count from ADO}
  Exact matches:            {count of GREEN rows}
  Name mismatches:          {count of YELLOW rows}
  Not migrated:             {count of RED rows}
  Structural splits:        {count of ORANGE rows}
  Migration complete (%):   {migrated / total * 100}%

---

## SECTION 5 — FILE 2: REGRESSION RUN REPORT

### 5.1 — File Details
File name:    RunReport_{suiteName}_{timestamp}.xlsx
Sheet name:   Run Report
Output path:  config.getProperty("report.outputPath")
Phase:        Phase 1 output
Purpose:      Auto-generated after every regression or smoke run.
              Replaces the manual Excel update the team currently does.

### 5.2 — Column Definitions (in this exact order)

Col 0 — ADO Tag
  Header:   "ADO Tag"
  Content:  The @tag value from the executed scenario
  Width:    15 characters

Col 1 — ADO Title
  Header:   "ADO Title"
  Content:  Title from ADO (looked up using the tag)
  Width:    50 characters

Col 2 — Scenario Title
  Header:   "Scenario Title (Feature File)"
  Content:  The exact Scenario or Scenario Outline title from the
            feature file as it was executed
  Width:    50 characters

Col 3 — Execution Status
  Header:   "Status"
  Content:  One of these exact values:
              PASS
              FAIL
              SKIP
  Width:    10 characters
  Styling:  PASS = green background, FAIL = red background,
            SKIP = yellow background

Col 4 — Failure Reason
  Header:   "Failure Reason"
  Content:  For FAIL rows: the exception message or assertion failure
            message from the test output.
            For PASS and SKIP rows: empty cell.
            Never leave this blank for a FAIL row.
  Width:    60 characters

Col 5 — Screenshot Path
  Header:   "Screenshot"
  Content:  For FAIL rows: relative path to the screenshot file.
            If no screenshot available, value is: "No screenshot"
            For PASS rows: empty cell.
  Width:    40 characters

Col 6 — Execution Time
  Header:   "Duration (sec)"
  Content:  Time taken to execute the scenario in seconds.
            If not available from report, value is: "N/A"
  Width:    15 characters

Col 7 — Suite
  Header:   "Suite"
  Content:  regression or smoke — which suite was run
  Width:    15 characters

### 5.3 — Color Coding Logic

if (status == "PASS")  → GREEN row  (#C6EFCE)
if (status == "FAIL")  → RED row    (#FFC7CE)
if (status == "SKIP")  → YELLOW row (#FFEB9C)

### 5.4 — Summary Sheet
Add a second sheet named "Summary" with:

  Suite run:              {regression or smoke}
  Run date:               {date and time}
  Total scenarios:        {count}
  Passed:                 {count} ({percentage}%)
  Failed:                 {count} ({percentage}%)
  Skipped:                {count} ({percentage}%)
  Pass rate:              {passed / total * 100}%

  Failed test cases:
  {list of ADO tags and titles for all FAIL rows}

---

## SECTION 6 — IMPORTANT RULES FOR THIS SKILL

1. Always check pom.xml for Apache POI before writing any code.
   Never assume it is present. Never assume the version.

2. Create all cell styles ONCE at the top of the method.
   Never create a new style inside a loop.
   Excel style limit is approximately 64,000 unique styles.
   Hitting this limit corrupts the Excel file.

3. Always call setCellStyle AFTER setCellValue.
   If style is set before value, the style may not apply correctly.

4. Always close the workbook in a finally block or try-with-resources.
   Unclosed workbooks cause memory leaks and file corruption.

5. Never hardcode the output file path.
   Always read from config.getProperty("report.outputPath").

6. Always create the output directory if it does not exist.
   Use outputFile.getParentFile().mkdirs() before writing.

7. Column order must match the definitions in this file exactly.
   The team relies on consistent column positions.
   Changing column order breaks the manual processes that
   depend on these reports until the team is retrained.

8. The ADO Tag column must always contain the exact @tag string
   including the @ symbol, exactly as it appears in the feature file.
   Example: @12345 not 12345

9. Summary rows and sheets must always be present.
   The team uses the summary to quickly assess run health
   without scrolling through 400 rows.

10. This is a healthcare project.
    Never populate test data cells with real patient information
    even during development or testing of the report generator.
    Use placeholder values only.
