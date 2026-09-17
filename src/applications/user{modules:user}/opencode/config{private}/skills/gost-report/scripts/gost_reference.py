#!/usr/bin/env python3
"""Build a pandoc reference.docx matching the university formatting rules.

Rules (from the formatting guide, section 3.2):
  A4, margins: left 25 mm, right 10 mm, top/bottom 20 mm
  Times New Roman, 14 pt, line spacing 1.5, justified
  first-line indent 1.25 cm, section headings uppercase

Usage:
  python3 gost_reference.py <out.docx> <base_reference.docx>

Fetch the base reference with:
  pandoc --print-default-data-file reference.docx > base.docx
"""
import re
import sys
import zipfile

TWIP_PER_MM = 1440 / 25.4
MARGINS = {
    "top": round(20 * TWIP_PER_MM),
    "bottom": round(20 * TWIP_PER_MM),
    "left": round(25 * TWIP_PER_MM),
    "right": round(10 * TWIP_PER_MM),
}
FONT = "Times New Roman"
HALF_PT = 28
LINE = 360
FIRST_INDENT = round(12.5 * TWIP_PER_MM)
LANG = '<w:lang w:val="ru-RU" w:eastAsia="ru-RU"/>'
SECT_PR = (
    "<w:sectPr>"
    f'<w:pgSz w:w="11906" w:h="16838"/>'
    f'<w:pgMar w:top="{MARGINS["top"]}" w:right="{MARGINS["right"]}"'
    f' w:bottom="{MARGINS["bottom"]}" w:left="{MARGINS["left"]}"'
    ' w:header="720" w:footer="720" w:gutter="0"/>'
    "</w:sectPr>"
)

RUN_FONT = (
    f'<w:rFonts w:ascii="{FONT}" w:hAnsi="{FONT}"'
    f' w:eastAsia="{FONT}" w:cs="{FONT}"/>'
    f'<w:sz w:val="{HALF_PT}"/><w:szCs w:val="{HALF_PT}"/>'
    + LANG
)
BODY_PPR = (
    f'<w:spacing w:before="0" w:after="0" w:line="{LINE}" w:lineRule="auto"/>'
    f'<w:ind w:firstLine="{FIRST_INDENT}"/>'
    "<w:jc w:val=\"both\"/>"
)

CODE_FONT = "Courier New"
CODE_HALF_PT = 22
CODE_PPR = (
    '<w:spacing w:before="0" w:after="0" w:line="240" w:lineRule="auto"/>'
    '<w:ind w:left="0" w:right="0" w:firstLine="0"/>'
    '<w:jc w:val="left"/>'
)
CODE_RPR = (
    f'<w:rFonts w:ascii="{CODE_FONT}" w:hAnsi="{CODE_FONT}"'
    f' w:eastAsia="{CODE_FONT}" w:cs="{CODE_FONT}"/>'
    f'<w:sz w:val="{CODE_HALF_PT}"/><w:szCs w:val="{CODE_HALF_PT}"/>'
)


def replace_style(xml, style_id, new_style):
    pattern = re.compile(
        r'<w:style [^>]*w:styleId="' + re.escape(style_id) + r'".*?</w:style>', re.DOTALL
    )
    if not pattern.search(xml):
        return xml, False
    return pattern.sub(new_style, xml, count=1), True


def style(style_id, name, ppr="", rpr="", based=None, next_=None, custom=False):
    parts = [f'<w:style w:type="paragraph"{" w:customStyle=\"1\"" if custom else ""}'
             f' w:styleId="{style_id}">']
    parts.append(f'<w:name w:val="{name}"/>')
    if based:
        parts.append(f'<w:basedOn w:val="{based}"/>')
    if next_:
        parts.append(f'<w:next w:val="{next_}"/>')
    parts.append("<w:qFormat/>")
    if ppr:
        parts.append(f"<w:pPr>{ppr}</w:pPr>")
    if rpr:
        parts.append(f"<w:rPr>{rpr}</w:rPr>")
    parts.append("</w:style>")
    return "".join(parts)


def patch_table_borders(xml):
    borders = (
        "<w:tblBorders>"
        '<w:top w:val="single" w:sz="4" w:space="0" w:color="000000"/>'
        '<w:left w:val="single" w:sz="4" w:space="0" w:color="000000"/>'
        '<w:bottom w:val="single" w:sz="4" w:space="0" w:color="000000"/>'
        '<w:right w:val="single" w:sz="4" w:space="0" w:color="000000"/>'
        '<w:insideH w:val="single" w:sz="4" w:space="0" w:color="000000"/>'
        '<w:insideV w:val="single" w:sz="4" w:space="0" w:color="000000"/>'
        "</w:tblBorders>"
    )

    def patch(match):
        block = match.group(0)
        if "<w:tblBorders>" in block:
            return block
        return block.replace("<w:tblPr>", "<w:tblPr>" + borders, 1)

    return re.sub(
        r'<w:style [^>]*w:styleId="Table".*?</w:style>', patch, xml, flags=re.DOTALL
    )


def patch_doc_lang(xml):
    def patch(match):
        block = match.group(0)
        if "<w:lang " in block:
            return re.sub(r"<w:lang [^>]*/>", LANG, block, count=1)
        return block.replace("<w:rPr>", "<w:rPr>" + LANG, 1)

    return re.sub(
        r"<w:rPrDefault>.*?</w:rPrDefault>", patch, xml, count=1, flags=re.DOTALL
    )


def build_styles(xml):
    normal = style("Normal", "Normal", ppr=BODY_PPR, rpr=RUN_FONT)
    body = style(
        "BodyText", "Body Text",
        ppr=f'<w:spacing w:before="0" w:after="0" w:line="{LINE}" w:lineRule="auto"/>'
            f'<w:ind w:firstLine="{FIRST_INDENT}"/><w:jc w:val="both"/>',
        rpr=RUN_FONT, based="Normal",
    )
    first = style(
        "FirstParagraph", "First Paragraph",
        ppr=f'<w:ind w:firstLine="{FIRST_INDENT}"/><w:jc w:val="both"/>',
        rpr=RUN_FONT, based="BodyText", next_="BodyText", custom=True,
    )
    compact = style(
        "Compact", "Compact",
        ppr=f'<w:spacing w:before="0" w:after="0" w:line="{LINE}" w:lineRule="auto"/>'
            f'<w:jc w:val="both"/>',
        rpr=RUN_FONT, based="BodyText",
    )
    h1 = style(
        "Heading1", "heading 1",
        ppr=f'<w:keepNext/><w:keepLines/>'
            f'<w:spacing w:before="0" w:after="{LINE}" w:line="{LINE}" w:lineRule="auto"/>'
            f'<w:ind w:firstLine="{FIRST_INDENT}"/><w:jc w:val="left"/>'
            '<w:outlineLvl w:val="0"/>',
        rpr=f'{RUN_FONT}<w:b/><w:bCs/>',
        based="Normal", next_="BodyText",
    )
    h2 = style(
        "Heading2", "heading 2",
        ppr=f'<w:keepNext/><w:keepLines/>'
            f'<w:spacing w:before="{LINE}" w:after="{LINE}" w:line="{LINE}" w:lineRule="auto"/>'
            f'<w:ind w:firstLine="{FIRST_INDENT}"/><w:jc w:val="left"/>'
            '<w:outlineLvl w:val="1"/>',
        rpr=f'{RUN_FONT}<w:b/><w:bCs/>',
        based="Normal", next_="BodyText",
    )
    h3 = style(
        "Heading3", "heading 3",
        ppr='<w:keepNext/>'
            f'<w:spacing w:before="{LINE}" w:after="{LINE}" w:line="{LINE}" w:lineRule="auto"/>'
            f'<w:ind w:firstLine="{FIRST_INDENT}"/><w:jc w:val="left"/>'
            '<w:outlineLvl w:val="2"/>',
        rpr=f'{RUN_FONT}<w:b/><w:bCs/>',
        based="Normal", next_="BodyText",
    )
    caption = style(
        "Caption", "Caption",
        ppr=f'<w:spacing w:before="120" w:after="120" w:line="{LINE}" w:lineRule="auto"/>'
            '<w:jc w:val="center"/>',
        rpr=f'<w:rFonts w:ascii="{FONT}" w:hAnsi="{FONT}" w:eastAsia="{FONT}" w:cs="{FONT}"/>'
            '<w:sz w:val="24"/><w:szCs w:val="24"/>',
        based="Normal",
    )
    tabletext = style(
        "TableText", "Table Text",
        ppr='<w:spacing w:before="0" w:after="0" w:line="240" w:lineRule="auto"/>'
            '<w:ind w:left="0" w:right="0" w:firstLine="0"/>'
            '<w:jc w:val="left"/>',
        rpr=f'<w:rFonts w:ascii="{FONT}" w:hAnsi="{FONT}" w:eastAsia="{FONT}" w:cs="{FONT}"/>'
            '<w:sz w:val="24"/><w:szCs w:val="24"/>',
        based="Normal", custom=True,
    )
    tablecaption = style(
        "TableCaption", "Table Caption",
        ppr='<w:keepNext/>', based="Caption", custom=True,
    )
    styles = [normal, body, first, compact, h1, h2, h3, caption, tabletext,
              tablecaption]
    for sid in ("SourceCode", "Verbatim"):
        styles.append(style(
            sid, sid if sid == "SourceCode" else "Verbatim",
            ppr=CODE_PPR, rpr=CODE_RPR, based="Normal", custom=True,
        ))
    for sid, name in (("Heading4", "heading 4"), ("Heading5", "heading 5"),
                      ("Heading6", "heading 6")):
        lvl = int(sid[-1]) - 1
        styles.append(style(
            sid, name,
            ppr=f'<w:keepNext/><w:outlineLvl w:val="{lvl}"/>',
            rpr=f'{RUN_FONT}<w:b/><w:bCs/>', based="Normal", next_="BodyText",
        ))
    for sid, name in (("Title", "Title"), ("Author", "Author"), ("Date", "Date")):
        styles.append(style(
            sid, name, ppr='<w:jc w:val="center"/>',
            rpr=f'{RUN_FONT}<w:b/>', based="Normal",
        ))
    for sid, name, jc, bold in (
        ("TitleCenter", "Title Center", "center", False),
        ("TitleCenterBold", "Title Center Bold", "center", True),
        ("TitleLeft", "Title Left", "left", False),
        ("TitleRight", "Title Right", "right", False),
    ):
        styles.append(style(
            sid, name,
            ppr=f'<w:spacing w:before="0" w:after="0" w:line="{LINE}" w:lineRule="auto"/>'
                f'<w:ind w:firstLine="0"/><w:jc w:val="{jc}"/>',
            rpr=RUN_FONT + ("<w:b/><w:bCs/>" if bold else ""),
            based="Normal", custom=True,
        ))
    styles.append(style(
        "PageBreak", "Page Break",
        ppr='<w:pageBreakBefore/>'
            '<w:spacing w:before="0" w:after="0" w:line="240" w:lineRule="auto"/>'
            '<w:ind w:left="0" w:right="0" w:firstLine="0"/>',
        rpr=f'<w:rFonts w:ascii="{FONT}" w:hAnsi="{FONT}"'
            f' w:eastAsia="{FONT}" w:cs="{FONT}"/>'
            '<w:sz w:val="4"/><w:szCs w:val="4"/>',
        based="Normal", custom=True,
    ))
    new = "".join(styles)
    ids = re.findall(r'w:styleId="([^"]+)"', new)
    for sid in ids:
        xml = re.sub(
            r'<w:style [^>]*w:styleId="' + re.escape(sid) + r'".*?</w:style>',
            "", xml, flags=re.DOTALL,
        )
    xml = re.sub(r"(<w:styles\b[^>]*>)", lambda m: m.group(1) + new, xml, count=1)
    xml = patch_table_borders(xml)
    xml = patch_doc_lang(xml)
    return xml


def main():
    out = sys.argv[1]
    base = sys.argv[2] if len(sys.argv) > 2 else None
    if not base:
        print("provide a base reference.docx", file=sys.stderr)
        sys.exit(2)
    zin = zipfile.ZipFile(base)
    styles = build_styles(zin.read("word/styles.xml").decode("utf-8"))
    document = zin.read("word/document.xml").decode("utf-8")
    document = re.sub(r"<w:sectPr>.*?</w:sectPr>", SECT_PR, document, flags=re.DOTALL)
    if "<w:sectPr" not in document:
        document = document.replace("</w:body>", SECT_PR + "</w:body>")
    with zipfile.ZipFile(out, "w", zipfile.ZIP_DEFLATED) as zout:
        for item in zin.infolist():
            data = zin.read(item.filename)
            if item.filename == "word/styles.xml":
                data = styles.encode("utf-8")
            elif item.filename == "word/document.xml":
                data = document.encode("utf-8")
            zout.writestr(item, data)


if __name__ == "__main__":
    main()
