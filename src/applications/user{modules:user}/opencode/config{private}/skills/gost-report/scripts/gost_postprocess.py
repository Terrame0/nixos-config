#!/usr/bin/env python3
"""Post-process a pandoc-generated report to match the formatting rules.

  - numbered headings (`1. Цель работы`, `4.1. Организация`) lose the literal
    number and get a Word auto-number field instead, so deleting a section
    renumbers the rest; level-1 headings are uppercased
  - every level-1 heading starts on a new page
  - table cell paragraphs switch from `Compact` to `TableText`
  - table rows never split across pages, and a table up to
    `KEEP_TABLE_MAX_ROWS` rows is kept on one page together with its caption
  - a `--titlepage <file.docx>` splices a source title page in verbatim, with
    its section, styles and paragraph spacing, so the layout is reproduced
"""
import re
import sys
import zipfile

HEADING_LEVELS = {"Heading1": 0, "Heading2": 1, "Heading3": 2}
NUMBERING_LEVELS = 9
HEADING_INDENT = 709
NUMBER_PREFIX = re.compile(r"^\s*\d+(?:\.\d+)*\.?\s+")
STYLE_RE = re.compile(r'<w:pStyle w:val="(Heading[123])"\s*/>')
CODE_PPR = (
    '<w:spacing w:before="0" w:after="0" w:line="240" w:lineRule="auto"/>'
    '<w:ind w:left="0" w:right="0" w:firstLine="0"/>'
    '<w:jc w:val="left"/>'
)
CODE_STYLE_RE = re.compile(r'<w:pStyle w:val="(?:SourceCode|Verbatim)"\s*/>')
TITLE_PPR = (
    '<w:spacing w:after="0" w:line="240" w:lineRule="auto"/>'
    '<w:ind w:left="0" w:right="0" w:firstLine="0"/>'
)
BODY_ELEMENT_RE = re.compile(
    r"<w:p\b[^>]*/>|<w:p\b.*?</w:p>|<w:tbl\b[^>]*/>|<w:tbl\b.*?</w:tbl>", re.S
)
KEEP_TABLE_MAX_ROWS = 15


def process_headings(document, num_id, skip_first_break=False):
    state = {"seen_h1": False}

    def fix(match):
        para = match.group(0)
        style = STYLE_RE.search(para)
        if not style:
            return para
        heading = style.group(1)
        insert = ""
        if heading == "Heading1":
            first = not state["seen_h1"]
            state["seen_h1"] = True
            if not (first and skip_first_break):
                insert += "<w:pageBreakBefore/>"
        texts = list(re.finditer(r"(<w:t[^>]*>)(.*?)(</w:t>)", para, re.S))
        if texts:
            first_text = texts[0]
            value = first_text.group(2)
            prefix = NUMBER_PREFIX.match(value)
            if prefix:
                value = value[prefix.end():]
            if heading == "Heading1":
                value = value.upper()
            para = (
                para[: first_text.start()]
                + first_text.group(1) + value + first_text.group(3)
                + para[first_text.end():]
            )
            if prefix:
                insert += (
                    f'<w:numPr><w:ilvl w:val="{HEADING_LEVELS[heading]}"/>'
                    f'<w:numId w:val="{num_id}"/></w:numPr>'
                )
        if insert:
            para = STYLE_RE.sub(lambda m: m.group(0) + insert, para, count=1)
        return para

    return re.sub(r"<w:p\b.*?</w:p>", fix, document, flags=re.S)


def fix_code_paragraphs(document):
    def fix(match):
        para = match.group(0)
        if not CODE_STYLE_RE.search(para):
            return para
        return CODE_STYLE_RE.sub(
            lambda m: m.group(0) + CODE_PPR, para, count=1
        )

    return re.sub(r"<w:p\b.*?</w:p>", fix, document, flags=re.S)


def fix_table_styles(document):
    def fix_table(match):
        return match.group(0).replace(
            '<w:pStyle w:val="Compact" />', '<w:pStyle w:val="TableText" />'
        )

    return re.sub(r"<w:tbl>.*?</w:tbl>", fix_table, document, flags=re.S)


def add_keep_next(element):
    def fix_para(match):
        para = match.group(0)
        if "<w:keepNext/>" in para:
            return para
        if "<w:pStyle " in para:
            return para.replace("<w:pStyle ", "<w:keepNext/><w:pStyle ", 1)
        if "<w:pPr>" in para:
            return para.replace("<w:pPr>", "<w:pPr><w:keepNext/>", 1)
        return re.sub(
            r"(<w:p\b[^>]*>)", r"\1<w:pPr><w:keepNext/></w:pPr>", para, count=1
        )

    return re.sub(r"<w:p\b.*?</w:p>", fix_para, element, flags=re.S)


def add_cant_split(row):
    if "<w:cantSplit/>" in row:
        return row
    if "<w:trPr>" in row:
        return row.replace("<w:trPr>", "<w:trPr><w:cantSplit/>", 1)
    return re.sub(
        r"(<w:tr\b[^>]*>)", r"\1<w:trPr><w:cantSplit/></w:trPr>", row, count=1
    )


def keep_tables_together(document):
    def fix_table(match):
        table = match.group(0)
        rows = re.findall(r"<w:tr\b.*?</w:tr>", table, re.S)
        keep_all = len(rows) <= KEEP_TABLE_MAX_ROWS
        for i, row in enumerate(rows):
            new = add_cant_split(row)
            if keep_all and i < len(rows) - 1:
                new = add_keep_next(new)
            table = table.replace(row, new, 1)
        return table

    document = re.sub(r"<w:tbl>.*?</w:tbl>", fix_table, document, flags=re.S)
    return re.sub(
        r"((?:<w:p\b[^>]*>)(?:(?!</w:p>).)*?</w:p>)(\s*<w:tbl>)",
        lambda m: add_keep_next(m.group(1)) + m.group(2),
        document, flags=re.S,
    )


def title_docdefaults_spacing(tdoc):
    block = re.search(r"<w:pPrDefault>(.*?)</w:pPrDefault>", tdoc, re.S)
    if block:
        spacing = re.search(r"<w:spacing [^>]*/>", block.group(1))
        if spacing:
            return spacing.group(0)
    return TITLE_PPR


def normalize_title_paragraph(element, doc_spacing):
    if not element.startswith("<w:p"):
        return element
    spacing = TITLE_PPR if "<w:pStyle " in element else doc_spacing
    if element.rstrip().endswith("/>"):
        return element.rstrip()[:-2] + "><w:pPr>" + spacing + "</w:pPr></w:p>"
    element = re.sub(r"<w:pStyle [^>]*/>", "", element)
    element = re.sub(r"<w:spacing [^>]*/>", "", element)
    element = re.sub(r"<w:ind [^>]*/>", "", element)
    if "<w:pPr>" not in element:
        return re.sub(
            r"(<w:p\b[^>]*>)", r"\1<w:pPr>" + spacing + "</w:pPr>", element, count=1
        )
    if "<w:jc " in element:
        return element.replace("<w:jc ", spacing + "<w:jc ", 1)
    return element.replace("</w:pPr>", spacing + "</w:pPr>", 1)


def normalize_title_element(element, doc_spacing):
    if element.startswith("<w:tbl"):
        return re.sub(
            r"<w:p\b[^>]*/>|<w:p\b.*?</w:p>",
            lambda m: normalize_title_paragraph(m.group(0), doc_spacing),
            element, flags=re.S,
        )
    return normalize_title_paragraph(element, doc_spacing)


def title_sectpr(sectpr):
    inner = re.sub(r"^<w:sectPr[^>]*>", "", sectpr)
    inner = re.sub(r"</w:sectPr>$", "", inner)
    inner = re.sub(r"<w:type [^>]*/>", "", inner, count=1)
    for tag in ("headerReference", "footerReference"):
        inner = re.sub(rf"<w:{tag}[^>]*/>", "", inner)
    for tag in ("footnotePr", "endnotePr"):
        inner = re.sub(rf"<w:{tag}\b.*?</w:{tag}>", "", inner, flags=re.S)
    return f'<w:sectPr><w:type w:val="nextPage"/>{inner}</w:sectPr>'


def merge_styles(styles, titlepage_path):
    tz = zipfile.ZipFile(titlepage_path)
    try:
        tstyles = tz.read("word/styles.xml").decode("utf-8")
    except KeyError:
        return styles
    existing = set(re.findall(r'w:styleId="([^"]+)"', styles))
    defaults = set(re.findall(r'w:type="(\w+)" w:default="1"', styles))
    added = []
    for match in re.finditer(r"<w:style\b.*?</w:style>", tstyles, re.S):
        block = match.group(0)
        sid = re.search(r'w:styleId="([^"]+)"', block)
        stype = re.search(r'w:type="(\w+)"', block)
        if not sid or sid.group(1) in existing:
            continue
        if 'w:default="1"' in block and stype and stype.group(1) in defaults:
            block = block.replace('w:default="1" ', "")
        added.append(block)
    if added:
        styles = re.sub(
            r"(<w:styles\b[^>]*>)", lambda m: m.group(1) + "".join(added), styles, count=1
        )
    return styles


def inject_titlepage(document, titlepage_path):
    tz = zipfile.ZipFile(titlepage_path)
    tdoc = tz.read("word/document.xml").decode("utf-8")
    body = re.search(r"<w:body>(.*)</w:body>", tdoc, re.S).group(1)
    body = re.sub(r"<w:sectPr\b.*?</w:sectPr>", "", body, flags=re.S)
    doc_spacing = title_docdefaults_spacing(tdoc)
    elements = [
        normalize_title_element(el, doc_spacing)
        for el in BODY_ELEMENT_RE.findall(body)
    ]
    source_sectpr = re.search(r"<w:sectPr\b.*?</w:sectPr>", tdoc, re.S)
    if source_sectpr and elements:
        break_sectpr = title_sectpr(source_sectpr.group(0))
        if elements[-1].startswith("<w:p"):
            last = elements[-1]
            if "<w:pPr>" in last:
                last = last.replace("</w:pPr>", break_sectpr + "</w:pPr>", 1)
            else:
                last = re.sub(
                    r"(<w:p\b[^>]*>)", r"\1<w:pPr>" + break_sectpr + "</w:pPr>",
                    last, count=1,
                )
            elements[-1] = last
        else:
            elements.append(f"<w:p><w:pPr>{break_sectpr}</w:pPr></w:p>")
    fragment = "".join(elements)
    return document.replace("<w:body>", "<w:body>" + fragment, 1)


def next_free_ids(numbering):
    abstracts = [int(x) for x in re.findall(r'<w:abstractNum w:abstractNumId="(\d+)"', numbering)]
    nums = [int(x) for x in re.findall(r'<w:num w:numId="(\d+)"', numbering)]
    abstract_id = max(abstracts, default=0) + 1
    num_id = max(nums, default=0) + 1
    return abstract_id, num_id


def add_heading_numbering(numbering, abstract_id, num_id):
    levels = []
    for ilvl in range(NUMBERING_LEVELS):
        text = ".".join(f"%{i + 1}" for i in range(ilvl + 1))
        levels.append(
            f'<w:lvl w:ilvl="{ilvl}">'
            '<w:start w:val="1"/>'
            '<w:numFmt w:val="decimal"/>'
            '<w:suff w:val="space"/>'
            f'<w:lvlText w:val="{text}"/>'
            '<w:lvlJc w:val="left"/>'
            f'<w:pPr><w:ind w:left="{HEADING_INDENT}" w:hanging="0"/></w:pPr>'
            "</w:lvl>"
        )
    abstract = (
        f'<w:abstractNum w:abstractNumId="{abstract_id}">'
        '<w:multiLevelType w:val="multilevel"/>'
        + "".join(levels)
        + "</w:abstractNum>"
    )
    num = (
        f'<w:num w:numId="{num_id}">'
        f'<w:abstractNumId w:val="{abstract_id}"/>'
        "</w:num>"
    )
    numbering = re.sub(r"(<w:abstractNum\b)", abstract + r"\1", numbering, count=1)
    return numbering.replace("</w:numbering>", num + "</w:numbering>")


def main():
    args = [a for a in sys.argv[1:]]
    titlepage = None
    if "--titlepage" in args:
        i = args.index("--titlepage")
        titlepage = args[i + 1]
        del args[i:i + 2]
    src, dst = args[0], args[1]
    zin = zipfile.ZipFile(src)
    doc = zin.read("word/document.xml").decode("utf-8")
    numbering = zin.read("word/numbering.xml").decode("utf-8")
    abstract_id, num_id = next_free_ids(numbering)
    numbering = add_heading_numbering(numbering, abstract_id, num_id)
    doc = fix_table_styles(doc)
    doc = keep_tables_together(doc)
    doc = fix_code_paragraphs(doc)
    doc = process_headings(doc, num_id, skip_first_break=bool(titlepage))
    styles = zin.read("word/styles.xml").decode("utf-8")
    if titlepage:
        doc = inject_titlepage(doc, titlepage)
        styles = merge_styles(styles, titlepage)
    with zipfile.ZipFile(dst, "w", zipfile.ZIP_DEFLATED) as zout:
        for item in zin.infolist():
            data = zin.read(item.filename)
            if item.filename == "word/document.xml":
                data = doc.encode("utf-8")
            elif item.filename == "word/numbering.xml":
                data = numbering.encode("utf-8")
            elif item.filename == "word/styles.xml":
                data = styles.encode("utf-8")
            zout.writestr(item, data)


if __name__ == "__main__":
    main()
