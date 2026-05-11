# docx.md
# SKILL: docx
# ================================================================
# HOW TO INVOKE THIS SKILL:
# Read automatically when any task requires generating or
# reading a Word document (.docx file).
#
# Manual invocation:
#   "run docx: create {document type}"
#   "run docx: read {file path}"
#   "run docx: update {file path}"
#
# Document types this project produces:
#   "run docx: create kt-guide"
#       → Knowledge Transfer guide for the team
#   "run docx: create handover-report"
#       → Final handover document for the client
#   "run docx: create migration-report"
#       → Migration completion report (all 400 scripts status)
#   "run docx: create test-strategy"
#       → Test strategy document for client review
#   "run docx: create retrospective"
#       → Project retrospective for internal use
#
# LIBRARY: Apache POI XWPF for .docx format
# ALWAYS check pom.xml for poi-ooxml dependency before writing.
# The same poi-ooxml dependency that covers xlsx also covers docx.
# If xlsx.md confirmed poi-ooxml is present, docx can use it too.
# ================================================================

---

## SECTION 1 — APACHE POI XWPF DEPENDENCY CHECK

Before writing any Word document code, Copilot must:

Step 1: Check if poi-ooxml is already confirmed present from xlsx.md
        If xlsx.md was already used this session, poi-ooxml is confirmed.
        Skip to Section 2.
Step 2: If not confirmed, open pom.xml and search for "poi-ooxml".
Step 3: If NOT found, show Sunil and wait for approval:
        <dependency>
            <groupId>org.apache.poi</groupId>
            <artifactId>poi-ooxml</artifactId>
            <version>{same version as poi if poi exists}</version>
        </dependency>
Step 4: poi and poi-ooxml must always be the same version.
        Mismatched versions cause NoClassDefFoundError at runtime.

Key XWPF classes to use:
  XWPFDocument   — the Word document
  XWPFParagraph  — a paragraph (heading or body text)
  XWPFRun        — a text run inside a paragraph (styled text)
  XWPFTable      — a table
  XWPFTableRow   — a row in a table
  XWPFTableCell  — a cell in a table row

---

## SECTION 2 — STANDARD XWPF PATTERNS

### 2.1 — Creating a New Document

XWPFDocument document = new XWPFDocument();

// Page margins (in twips — 1 inch = 1440 twips)
CTSectPr sectPr = document.getDocument().getBody().addNewSectPr();
CTPageMar pageMar = sectPr.addNewPgMar();
pageMar.setTop(BigInteger.valueOf(1080));    // 0.75 inch top
pageMar.setBottom(BigInteger.valueOf(1080)); // 0.75 inch bottom
pageMar.setLeft(BigInteger.valueOf(1260));   // 0.875 inch left
pageMar.setRight(BigInteger.valueOf(1260));  // 0.875 inch right

### 2.2 — Adding a Title

XWPFParagraph titlePara = document.createParagraph();
titlePara.setAlignment(ParagraphAlignment.CENTER);
titlePara.setStyle("Title");

XWPFRun titleRun = titlePara.createRun();
titleRun.setText("Document Title Here");
titleRun.setBold(true);
titleRun.setFontSize(20);
titleRun.setFontFamily("Calibri");
titleRun.setColor("2F4F6F"); // dark blue-grey matching Excel header

### 2.3 — Adding Headings

// Heading 1 — major section
XWPFParagraph h1 = document.createParagraph();
h1.setStyle("Heading1");
XWPFRun h1Run = h1.createRun();
h1Run.setText("Section Name");
h1Run.setBold(true);
h1Run.setFontSize(14);
h1Run.setFontFamily("Calibri");
h1Run.setColor("2F4F6F");

// Heading 2 — subsection
XWPFParagraph h2 = document.createParagraph();
h2.setStyle("Heading2");
XWPFRun h2Run = h2.createRun();
h2Run.setText("Subsection Name");
h2Run.setBold(true);
h2Run.setFontSize(12);
h2Run.setFontFamily("Calibri");
h2Run.setColor("4F6F8F");

### 2.4 — Adding Body Text

XWPFParagraph para = document.createParagraph();
para.setAlignment(ParagraphAlignment.LEFT);
para.setSpacingAfter(120); // space after paragraph in twips

XWPFRun run = para.createRun();
run.setText("Body text content here.");
run.setFontSize(11);
run.setFontFamily("Calibri");
run.setColor("000000");

### 2.5 — Adding a Bullet List

// Apache POI bullet lists need numbering definition
// Use this helper pattern for simple bullet lists:
private void addBulletPoint(XWPFDocument doc, String text) {
    XWPFParagraph para = doc.createParagraph();
    para.setNumID(getOrCreateBulletNumId(doc));
    para.setIndentationLeft(720); // 0.5 inch indent

    XWPFRun run = para.createRun();
    run.setText(text);
    run.setFontSize(11);
    run.setFontFamily("Calibri");
}

// For simple use cases, prefix with bullet character instead:
private void addSimpleBullet(XWPFDocument doc, String text) {
    XWPFParagraph para = doc.createParagraph();
    para.setIndentationLeft(720);

    XWPFRun bulletRun = para.createRun();
    bulletRun.setText("\u2022  " + text); // unicode bullet point
    bulletRun.setFontSize(11);
    bulletRun.setFontFamily("Calibri");
}

### 2.6 — Adding a Table

XWPFTable table = document.createTable(rows, cols);

// Remove default border styling and set custom
table.setTableAlignment(TableRowAlign.LEFT);

// Style the header row
XWPFTableRow headerRow = table.getRow(0);
for (int i = 0; i < cols; i++) {
    XWPFTableCell cell = headerRow.getCell(i);
    cell.setText(headers[i]);

    // Set header cell background color
    CTTcPr tcPr = cell.getCTTc().addNewTcPr();
    CTShd shd = tcPr.addNewShd();
    shd.setVal(STShd.CLEAR);
    shd.setColor("auto");
    shd.setFill("2F4F6F"); // dark blue-grey header

    // Set header text to white bold
    XWPFParagraph cellPara = cell.getParagraphs().get(0);
    XWPFRun cellRun = cellPara.createRun();
    cellRun.setBold(true);
    cellRun.setColor("FFFFFF");
    cellRun.setFontSize(11);
    cellRun.setFontFamily("Calibri");
}

// Add data rows
for (int r = 1; r < rows; r++) {
    XWPFTableRow dataRow = table.getRow(r);
    // Alternating row color for readability
    String rowColor = (r % 2 == 0) ? "F2F2F2" : "FFFFFF";
    for (int c = 0; c < cols; c++) {
        XWPFTableCell cell = dataRow.getCell(c);
        // Set background
        CTTcPr tcPr = cell.getCTTc().isSetTcPr()
            ? cell.getCTTc().getTcPr()
            : cell.getCTTc().addNewTcPr();
        CTShd shd = tcPr.isSetShd() ? tcPr.getShd() : tcPr.addNewShd();
        shd.setFill(rowColor);
    }
}

### 2.7 — Adding a Page Break

XWPFParagraph pageBreak = document.createParagraph();
XWPFRun breakRun = pageBreak.createRun();
breakRun.addBreak(BreakType.PAGE);

### 2.8 — Adding a Horizontal Line

XWPFParagraph separator = document.createParagraph();
CTBorder border = separator.getCTP().addNewPPr().addNewPBdr().addNewBottom();
border.setVal(STBorder.SINGLE);
border.setSz(BigInteger.valueOf(6));
border.setSpace(BigInteger.valueOf(1));
border.setColor("2F4F6F");

### 2.9 — Writing the File to Disk

String outputPath = config.getProperty("report.outputPath");
String fileName = documentType + "_" + getTimestamp() + ".docx";
File outputFile = new File(outputPath + File.separator + fileName);
outputFile.getParentFile().mkdirs();

try (FileOutputStream fos = new FileOutputStream(outputFile)) {
    document.write(fos);
} finally {
    document.close();
}

---

## SECTION 3 — DOCUMENT TEMPLATE STRUCTURE

Every document this project produces follows this exact structure.
Same structure every time. Zero manual formatting required.

### FIXED TEMPLATE STRUCTURE:

PAGE 1 — COVER PAGE
  Document title (centered, large, dark blue)
  Project name: MC Healthcare Portal — Automation Framework
  Document type: {KT Guide / Handover Report / Migration Report / etc.}
  Prepared by: Sunil Sagar
  Date: {generation date}
  Version: {version number}
  Client: MC
  Confidentiality notice: CONFIDENTIAL — For MC internal use only

  Page break after cover page.

PAGE 2 — TABLE OF CONTENTS
  Heading: "Table of Contents"
  Note: Apache POI cannot auto-generate TOC with hyperlinks.
        Write TOC as a plain text list with section names and
        placeholder page numbers.
        Tell Sunil: "TOC page numbers need manual update after
        opening in Word. Press Ctrl+A then F9 to update fields."

  Page break after TOC.

SECTION 1 — DOCUMENT OVERVIEW
  1.1 Purpose
      What this document is for and who should read it.
  1.2 Scope
      What is covered and what is not covered.
  1.3 Audience
      Who this document is written for.
  1.4 Related Documents
      Links or references to other project documents.

SECTION 2 — PROJECT BACKGROUND
  2.1 Client and Application Overview
      Brief description of MC healthcare portal.
      Pulled from .project/knowledge.md automatically.
  2.2 Project Goals
      The migration goals and success criteria.
      Pulled from .project/knowledge.md automatically.
  2.3 Team
      Team members and roles.
      Pulled from .project/knowledge.md automatically.

SECTION 3 — MAIN CONTENT
  This section is document-type specific.
  See per-document definitions below.

SECTION 4 — DECISIONS AND RATIONALE
  All significant decisions made during the project.
  Pulled from .project/devlog.md DECISION entries automatically.

SECTION 5 — KNOWN ISSUES AND RISKS
  All risks identified during the project.
  Pulled from .project/devlog.md RISK entries automatically.

SECTION 6 — LESSONS LEARNED
  All learnings captured during the project.
  Pulled from .project/devlog.md LEARNING entries automatically.

SECTION 7 — APPENDIX
  7.1 Glossary of terms
  7.2 Tool versions and dependencies
  7.3 Configuration reference
  7.4 Contact information

---

## SECTION 4 — PER-DOCUMENT MAIN CONTENT (SECTION 3)

### KT Guide (kt-guide)
Section 3 content:
  3.1 Framework Architecture Overview
      The three-layer architecture explained with examples.
  3.2 How to Run the Test Suite
      Maven commands for regression, smoke, local, Perfecto.
  3.3 How to Add a New Test Case
      Step by step: create feature file, step definition, page method.
  3.4 How to Use the Copilot Agent
      The prompt playbook for the team.
      Reference: .vscode/instructions/team-prompt-playbook.instructions.md
  3.5 How to Use the Skills
      Each skill explained with invoke command and expected output.
  3.6 How to Read the Reports
      Reconciliation report and run report column by column.
  3.7 Common Issues and Solutions
      Top 5 most likely problems and how to fix them.

### Handover Report (handover-report)
Section 3 content:
  3.1 Migration Summary
      Total scripts migrated, remaining, pass rate.
      Pull from latest reconciliation Excel if available.
  3.2 Framework Status
      New framework health. Any known issues.
  3.3 Outstanding Items
      Anything not completed that the receiving team must finish.
  3.4 Environment Setup Instructions
      How to set up the framework from scratch on a new machine.
  3.5 Support and Escalation
      Who to contact for what issue.

### Migration Report (migration-report)
Section 3 content:
  3.1 Migration Overview
      Total scripts, migrated count, structural splits handled.
  3.2 Migration Statistics
      Table: by module, by status, by suite type.
  3.3 Scripts Migrated
      Full list: ADO tag, old title, new title, status.
      Pull from reconciliation Excel.
  3.4 Scripts Remaining
      Full list of NOT MIGRATED items with action needed.
  3.5 Structural Splits Resolved
      List of every structural split and how it was resolved.

### Test Strategy (test-strategy)
Section 3 content:
  3.1 Test Objectives
  3.2 Test Scope
  3.3 Test Types (regression, smoke, exploratory)
  3.4 Test Environment (local, Perfecto)
  3.5 Test Data Strategy
  3.6 Entry and Exit Criteria
  3.7 Defect Management

### Retrospective (retrospective)
Section 3 content:
  3.1 What Went Well
  3.2 What Could Have Been Better
  3.3 What We Would Do Differently
  3.4 Key Achievements
  3.5 Recommendations for Future Projects

---

## SECTION 5 — TYPOGRAPHY AND STYLING STANDARDS

Font family:      Calibri (all text)
Title font size:  20pt, bold, color #2F4F6F
H1 font size:     14pt, bold, color #2F4F6F
H2 font size:     12pt, bold, color #4F6F8F
Body font size:   11pt, regular, color #000000
Table header:     11pt, bold, white text on #2F4F6F background
Table body:       10pt, regular, alternating #FFFFFF and #F2F2F2
Caption text:     9pt, italic, color #666666

Page size:        A4 (or Letter — match client preference)
                  [FILL IN — confirm with Sunil which to use]
Margins:          0.75 inch top/bottom, 0.875 inch left/right
Line spacing:     1.15 for body text
Paragraph spacing: 6pt after each paragraph

---

## SECTION 6 — IMPORTANT RULES FOR THIS SKILL

1. Always check pom.xml for poi-ooxml before writing any code.
   poi-ooxml covers both xlsx and docx. Same dependency.
   If xlsx.md already confirmed it this session, skip the check.

2. Always close XWPFDocument in finally or try-with-resources.
   Unclosed documents cause memory leaks and file corruption.

3. Never use HWPFDocument. That is for old .doc format.
   Always use XWPFDocument for .docx format.

4. The document structure defined in Section 3 is fixed.
   Every document follows this structure.
   Do not invent new structures or skip sections.
   Consistency is what makes this documentation useful.

5. Sections 2, 4, 5, and 6 of every document are populated
   automatically from .project/knowledge.md and .project/devlog.md.
   Copilot reads these files and extracts the relevant entries.
   Do not ask Sunil to manually provide this content.
   It is already written in the log files.

6. The TOC cannot be auto-generated with live page numbers
   by Apache POI alone. Always include the manual update
   instruction for Sunil: "Press Ctrl+A then F9 in Word
   to update page numbers after opening."

7. Never put patient data, real credentials, or any sensitive
   information in any document. This is a healthcare project.
   All examples and sample data must use placeholders.

8. Output path always from config.getProperty("report.outputPath").
   Never hardcode paths.

9. When create-doc skill calls this skill, it passes the
   document type as a parameter. Use Section 4 to determine
   what goes in Section 3 of the document.
