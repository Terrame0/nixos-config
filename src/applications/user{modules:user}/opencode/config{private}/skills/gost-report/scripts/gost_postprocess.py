#!/usr/bin/env python3
"""Post-process a pandoc-generated report to match the formatting rules.

  - numbered headings (`1. Цель работы`, `4.1. Организация`) lose the literal
    number and get a Word auto-number field instead, so deleting a section
    renumbers the rest; level-1 headings are uppercased
  - every level-1 heading starts on a new page
  - table cell paragraphs switch from `Compact` to `TableText`
  - table rows never split across pages, and a table up to
    `KEEP_TABLE_MAX_ROWS` rows is kept on one page together with its caption
  - a centred page-number footer is added to the body section; the title-page
    section keeps none, so the title is counted but not numbered
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
    r"<w:p\b[^>]*/>|<w:p\b.*?</w:p>|<w:tbl\b[^>]*/>|<w:tbl\b.*?</w:tbl>", re.DOTALL
)
KEEP_TABLE_MAX_ROWS = 15
FOOTER_TYPE = (
    "http://schemas.openxmlformats.org/officeDocument/2006/relationships/footer"
)
FOOTER_CT = (
    "application/vnd.openxmlformats-officedocument."
    "wordprocessingml.footer+xml"
)
FOOTER_PART = "word/footer1.xml"
FOOTER_XML = (
    '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n'
    '<w:ftr xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">'
    '<w:p><w:pPr><w:spacing w:after="0" w:line="240" w:lineRule="auto"/>'
    '<w:jc w:val="center"/></w:pPr>'
    '<w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"'
    ' w:eastAsia="Times New Roman" w:cs="Times New Roman"/>'
    '<w:sz w:val="28"/><w:szCs w:val="28"/><w:lang w:val="ru-RU"'
    ' w:eastAsia="ru-RU"/></w:rPr><w:fldChar w:fldCharType="begin"/></w:r>'
    '<w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"'
    ' w:eastAsia="Times New Roman" w:cs="Times New Roman"/>'
    '<w:sz w:val="28"/><w:szCs w:val="28"/><w:lang w:val="ru-RU"'
    ' w:eastAsia="ru-RU"/></w:rPr>'
    '<w:instrText xml:space="preserve"> PAGE </w:instrText></w:r>'
    '<w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"'
    ' w:eastAsia="Times New Roman" w:cs="Times New Roman"/>'
    '<w:sz w:val="28"/><w:szCs w:val="28"/><w:lang w:val="ru-RU"'
    ' w:eastAsia="ru-RU"/></w:rPr><w:fldChar w:fldCharType="separate"/></w:r>'
    '<w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"'
    ' w:eastAsia="Times New Roman" w:cs="Times New Roman"/>'
    '<w:sz w:val="28"/><w:szCs w:val="28"/><w:lang w:val="ru-RU"'
    ' w:eastAsia="ru-RU"/></w:rPr><w:t>1</w:t></w:r>'
    '<w:r><w:rPr><w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"'
    ' w:eastAsia="Times New Roman" w:cs="Times New Roman"/>'
    '<w:sz w:val="28"/><w:szCs w:val="28"/><w:lang w:val="ru-RU"'
    ' w:eastAsia="ru-RU"/></w:rPr><w:fldChar w:fldCharType="end"/></w:r>'
    "</w:p></w:ftr>"
)


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
        texts = list(re.finditer(r"(<w:t[^>]*>)(.*?)(</w:t>)", para, re.DOTALL))
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

    return re.sub(r"<w:p\b.*?</w:p>", fix, document, flags=re.DOTALL)


def fix_code_paragraphs(document):
    def fix(match):
        para = match.group(0)
        if not CODE_STYLE_RE.search(para):
            return para
        return CODE_STYLE_RE.sub(
            lambda m: m.group(0) + CODE_PPR, para, count=1
        )

    return re.sub(r"<w:p\b.*?</w:p>", fix, document, flags=re.DOTALL)


RUN_RPR = (
    '<w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"'
    ' w:eastAsia="Times New Roman" w:cs="Times New Roman"/>'
    '<w:sz w:val="28"/><w:szCs w:val="28"/>'
    '<w:lang w:val="ru-RU" w:eastAsia="ru-RU"/>'
)
SOURCE_HEADING_RE = re.compile(
    r"СПИСОК\s+ИСПОЛЬЗОВАННЫХ\s+ИСТОЧНИКОВ", re.IGNORECASE
)
NUMPR_RE = re.compile(r"<w:numPr>.*?</w:numPr>", re.DOTALL)
PSTYLE_RE = re.compile(r'<w:pStyle w:val="[^"]+"\s*/>')
APPENDIX_RE = re.compile(
    r"^\s*Приложение\s+([А-ЯЁA-Z])\s*(\([^)]*\))?\s*\.?\s*(.*?)\s*$",
    re.IGNORECASE,
)
ABBREV_RE = re.compile(r"^\s*([A-ZА-ЯЁ][A-ZА-ЯЁ0-9]{1,9})\s+—\s+\S")
STRUCTURAL_HEADINGS = {
    "ВВЕДЕНИЕ",
    "ЗАКЛЮЧЕНИЕ",
    "РЕФЕРАТ",
    "СОДЕРЖАНИЕ",
    "СПИСОК ИСПОЛЬЗОВАННЫХ ИСТОЧНИКОВ",
    "ПЕРЕЧЕНЬ СОКРАЩЕНИЙ И ОБОЗНАЧЕНИЙ",
    "ОПРЕДЕЛЕНИЯ, ОБОЗНАЧЕНИЯ И СОКРАЩЕНИЯ",
    "ТЕРМИНЫ И ОПРЕДЕЛЕНИЯ",
}


def para_text(para):
    return "".join(re.findall(r"<w:t[^>]*>(.*?)</w:t>", para, re.DOTALL))


def para_style(para):
    match = re.search(r'<w:pStyle w:val="([^"]+)"', para)
    return match.group(1) if match else ""


def set_style(para, style_id):
    if PSTYLE_RE.search(para):
        return PSTYLE_RE.sub(f'<w:pStyle w:val="{style_id}" />', para, count=1)
    if "<w:pPr>" in para:
        return para.replace(
            "<w:pPr>", f'<w:pPr><w:pStyle w:val="{style_id}" />', 1
        )
    return re.sub(
        r"(<w:p\b[^>]*>)",
        r'\1<w:pPr><w:pStyle w:val="' + style_id + r'" /></w:pPr>',
        para, count=1,
    )


def convert_source_list(document):
    state = {"in_section": False, "index": 0}

    def fix(match):
        para = match.group(0)
        text = para_text(para)
        style = para_style(para)
        if style.startswith("Heading"):
            state["in_section"] = bool(SOURCE_HEADING_RE.search(text))
            state["index"] = 0
            return para
        if not state["in_section"]:
            return para
        if "<w:numPr>" not in para:
            if text.strip():
                state["in_section"] = False
            return para
        state["index"] += 1
        para = NUMPR_RE.sub("", para, count=1)
        para = set_style(para, "SourceList")
        run = (
            f'<w:r><w:rPr>{RUN_RPR}</w:rPr>'
            f'<w:t xml:space="preserve">{state["index"]}. </w:t></w:r>'
        )
        if "</w:pPr>" in para:
            return para.replace("</w:pPr>", "</w:pPr>" + run, 1)
        return re.sub(r"(<w:p\b[^>]*>)", r"\1" + run, para, count=1)

    return re.sub(r"<w:p\b.*?</w:p>", fix, document, flags=re.DOTALL)


def style_abbreviations(document):
    def fix(match):
        para = match.group(0)
        style = para_style(para)
        if style.startswith("Heading") or style in ("SourceList", "Formula"):
            return para
        if ABBREV_RE.match(para_text(para)):
            return set_style(para, "Abbrev")
        return para

    return re.sub(r"<w:p\b.*?</w:p>", fix, document, flags=re.DOTALL)


def center_structural_headings(document):
    def fix(match):
        para = match.group(0)
        if para_style(para) != "Heading1":
            return para
        text = para_text(para).strip()
        if NUMBER_PREFIX.match(text) or text.upper() not in STRUCTURAL_HEADINGS:
            return para
        para = set_style(para, "Heading1Center")
        texts = list(re.finditer(r"(<w:t[^>]*>)(.*?)(</w:t>)", para, re.DOTALL))
        if texts:
            first = texts[0]
            upper = first.group(2).upper()
            para = (
                para[: first.start()]
                + first.group(1) + upper + first.group(3)
                + para[first.end():]
            )
        return para

    return re.sub(r"<w:p\b.*?</w:p>", fix, document, flags=re.DOTALL)


def convert_appendices(document):
    def fix(match):
        para = match.group(0)
        if para_style(para) != "Heading1":
            return para
        text = para_text(para).strip()
        found = APPENDIX_RE.match(text)
        if not found:
            return para
        letter, status, title = found.group(1), found.group(2), found.group(3)
        head = f'<w:p><w:pPr><w:pStyle w:val="Heading1Center" />' \
               f"<w:keepNext/></w:pPr>" \
               f'<w:r><w:rPr>{RUN_RPR}<w:b/><w:bCs/></w:rPr>' \
               f'<w:t xml:space="preserve">ПРИЛОЖЕНИЕ {letter.upper()}</w:t>' \
               f"</w:r></w:p>"
        if status:
            head += (
                f'<w:p><w:pPr><w:pStyle w:val="AppendixTitle" />'
                f"<w:keepNext/></w:pPr>"
                f'<w:r><w:rPr>{RUN_RPR}</w:rPr>'
                f'<w:t xml:space="preserve">{status}</w:t></w:r></w:p>'
            )
        if title:
            head += (
                f'<w:p><w:pPr><w:pStyle w:val="AppendixTitle" /></w:pPr>'
                f'<w:r><w:rPr>{RUN_RPR}<w:b/><w:bCs/></w:rPr>'
                f'<w:t xml:space="preserve">{title}</w:t></w:r></w:p>'
            )
        return head

    return re.sub(r"<w:p\b.*?</w:p>", fix, document, flags=re.DOTALL)


def fix_formula_numbers(document):
    def fix(match):
        para = match.group(0)
        if para_style(para) != "Formula":
            return para
        texts = list(re.finditer(r"(<w:t[^>]*>)(.*?)(</w:t>)", para, re.DOTALL))
        if not texts:
            return para
        last = texts[-1]
        value = last.group(2)
        number = re.search(r"\(\s*\d+\s*\)\s*$", value)
        if not number:
            return para
        stripped = value[: number.start()].rstrip()
        para = (
            para[: last.start()]
            + last.group(1) + stripped + last.group(3)
            + para[last.end():]
        )
        tail = (
            '<w:r><w:tab/></w:r>'
            f'<w:r><w:rPr>{RUN_RPR}</w:rPr>'
            f'<w:t xml:space="preserve">{number.group(0).strip()}</w:t></w:r>'
        )
        return para.replace("</w:p>", tail + "</w:p>", 1)

    return re.sub(r"<w:p\b.*?</w:p>", fix, document, flags=re.DOTALL)


def fix_table_styles(document):
    def fix_table(match):
        table = match.group(0)
        if "FigureTable" in table:
            return table
        return table.replace(
            '<w:pStyle w:val="Compact" />', '<w:pStyle w:val="TableText" />'
        )

    return re.sub(r"<w:tbl>.*?</w:tbl>", fix_table, document, flags=re.DOTALL)


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

    return re.sub(r"<w:p\b.*?</w:p>", fix_para, element, flags=re.DOTALL)


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
        if "FigureTable" in table:
            return table
        rows = re.findall(r"<w:tr\b.*?</w:tr>", table, re.DOTALL)
        keep_all = len(rows) <= KEEP_TABLE_MAX_ROWS
        for i, row in enumerate(rows):
            new = add_cant_split(row)
            if keep_all and i < len(rows) - 1:
                new = add_keep_next(new)
            table = table.replace(row, new, 1)
        return table

    document = re.sub(r"<w:tbl>.*?</w:tbl>", fix_table, document, flags=re.DOTALL)
    return re.sub(
        r"((?:<w:p\b[^>]*>)(?:(?!</w:p>).)*?</w:p>)(\s*<w:tbl>)",
        lambda m: add_keep_next(m.group(1)) + m.group(2),
        document, flags=re.DOTALL,
    )


def title_docdefaults_spacing(tdoc):
    block = re.search(r"<w:pPrDefault>(.*?)</w:pPrDefault>", tdoc, re.DOTALL)
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
            element, flags=re.DOTALL,
        )
    return normalize_title_paragraph(element, doc_spacing)


def title_sectpr(sectpr):
    inner = re.sub(r"^<w:sectPr[^>]*>", "", sectpr)
    inner = re.sub(r"</w:sectPr>$", "", inner)
    inner = re.sub(r"<w:type [^>]*/>", "", inner, count=1)
    for tag in ("headerReference", "footerReference"):
        inner = re.sub(rf"<w:{tag}[^>]*/>", "", inner)
    for tag in ("footnotePr", "endnotePr"):
        inner = re.sub(rf"<w:{tag}\b.*?</w:{tag}>", "", inner, flags=re.DOTALL)
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
    for match in re.finditer(r"<w:style\b.*?</w:style>", tstyles, re.DOTALL):
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


def merge_namespaces(document, tdoc):
    target = re.search(r"<w:document\b[^>]*>", document)
    source = re.search(r"<w:document\b[^>]*>", tdoc)
    if not target or not source:
        return document
    declared = set(re.findall(r"xmlns:([A-Za-z0-9]+)=", target.group(0)))
    add = "".join(
        f' xmlns:{prefix}="{uri}"'
        for prefix, uri in re.findall(
            r'xmlns:([A-Za-z0-9]+)=["\']([^"\']*)["\']', source.group(0)
        )
        if prefix not in declared
    )
    if not add:
        return document
    root = target.group(0)[:-1] + add + ">"
    return document[: target.start()] + root + document[target.end():]


WT_SPACE_RE = re.compile(
    r"<w:t(?P<attrs>(?:\s[^>]*)?)>(?P<text>.*?)</w:t>", re.DOTALL
)


def preserve_run_spaces(fragment):
    def fix(match):
        text = match.group("text")
        if text and text != text.strip() and "xml:space" not in match.group("attrs"):
            return f'<w:t{match.group("attrs")} xml:space="preserve">{text}</w:t>'
        return match.group(0)

    return WT_SPACE_RE.sub(fix, fragment)


def inject_titlepage(document, titlepage_path):
    tz = zipfile.ZipFile(titlepage_path)
    tdoc = tz.read("word/document.xml").decode("utf-8")
    body = re.search(r"<w:body>(.*)</w:body>", tdoc, re.DOTALL).group(1)
    body = re.sub(r"<w:sectPr\b.*?</w:sectPr>", "", body, flags=re.DOTALL)
    doc_spacing = title_docdefaults_spacing(tdoc)
    elements = [
        normalize_title_element(el, doc_spacing)
        for el in BODY_ELEMENT_RE.findall(body)
    ]
    source_sectpr = re.search(r"<w:sectPr\b.*?</w:sectPr>", tdoc, re.DOTALL)
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
    fragment = preserve_run_spaces("".join(elements))
    spliced = document.replace("<w:body>", "<w:body>" + fragment, 1)
    return merge_namespaces(spliced, tdoc)


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


def add_page_numbers(document, rels, content_types):
    ids = [int(x) for x in re.findall(r'Id="rId(\d+)"', rels)]
    rel_id = f"rId{max(ids, default=0) + 1}"
    rels = rels.replace(
        "</Relationships>",
        f'<Relationship Id="{rel_id}" Type="{FOOTER_TYPE}"'
        f' Target="footer1.xml"/></Relationships>',
        1,
    )
    sects = list(re.finditer(r"<w:sectPr\b[^>]*>", document))
    if sects:
        last = sects[-1]
        document = (
            document[: last.start()]
            + last.group(0)
            + f'<w:footerReference w:type="default" r:id="{rel_id}"/>'
            + document[last.end():]
        )
    content_types = content_types.replace(
        "</Types>",
        f'<Override PartName="/word/footer1.xml" ContentType="{FOOTER_CT}"/></Types>',
        1,
    )
    return document, rels, content_types


def main():
    args = [a for a in sys.argv[1:]]
    titlepage = None
    has_toc = "--toc" in args
    if has_toc:
        args.remove("--toc")
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
    doc = convert_source_list(doc)
    doc = style_abbreviations(doc)
    doc = center_structural_headings(doc)
    doc = convert_appendices(doc)
    doc = fix_formula_numbers(doc)
    doc = keep_tables_together(doc)
    doc = fix_code_paragraphs(doc)
    doc = process_headings(
        doc, num_id, skip_first_break=bool(titlepage) and not has_toc
    )
    styles = zin.read("word/styles.xml").decode("utf-8")
    if titlepage:
        doc = inject_titlepage(doc, titlepage)
        styles = merge_styles(styles, titlepage)
    rels = zin.read("word/_rels/document.xml.rels").decode("utf-8")
    content_types = zin.read("[Content_Types].xml").decode("utf-8")
    doc, rels, content_types = add_page_numbers(doc, rels, content_types)
    names = [item.filename for item in zin.infolist()]
    with zipfile.ZipFile(dst, "w", zipfile.ZIP_DEFLATED) as zout:
        for item in zin.infolist():
            data = zin.read(item.filename)
            if item.filename == "word/document.xml":
                data = doc.encode("utf-8")
            elif item.filename == "word/numbering.xml":
                data = numbering.encode("utf-8")
            elif item.filename == "word/styles.xml":
                data = styles.encode("utf-8")
            elif item.filename == "word/_rels/document.xml.rels":
                data = rels.encode("utf-8")
            elif item.filename == "[Content_Types].xml":
                data = content_types.encode("utf-8")
            zout.writestr(item, data)
        if FOOTER_PART not in names:
            zout.writestr(FOOTER_PART, FOOTER_XML.encode("utf-8"))


if __name__ == "__main__":
    main()
