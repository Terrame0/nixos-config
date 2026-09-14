#!/usr/bin/env python3
"""Post-process a pandoc-generated report to match the formatting rules.

  - level-1 headings become uppercase and lose the dot after the section number
    ("1. Цель работы" -> "1 ЦЕЛЬ РАБОТЫ")
  - every level-1 heading except the first starts on a new page
"""
import re
import sys
import zipfile

HEADING1 = "Heading1"
PAGE_BREAK = '<w:r><w:br w:type="page"/></w:r>'


def uppercase_h1(document):
    def fix(match):
        para = match.group(0)
        if f'<w:pStyle w:val="{HEADING1}"' not in para:
            return para
        texts = list(re.finditer(r"(<w:t[^>]*>)(.*?)(</w:t>)", para, re.S))
        if not texts:
            return para
        first = texts[0]
        value = re.sub(r"^\s*(\d+)\.\s+", r"\1 ", first.group(2)).upper()
        para = para[: first.start()] + first.group(1) + value + first.group(3) + para[first.end():]
        return re.sub(
            r"<w:pPr>.*?</w:pPr>",
            lambda m: m.group(0) + PAGE_BREAK,
            para, count=1, flags=re.S,
        )

    return re.sub(r"<w:p\b.*?</w:p>", fix, document, flags=re.S)


def fix_table_styles(document):
    def fix_table(match):
        return match.group(0).replace(
            '<w:pStyle w:val="Compact" />', '<w:pStyle w:val="TableText" />'
        )

    return re.sub(r"<w:tbl>.*?</w:tbl>", fix_table, document, flags=re.S)


def main():
    src, dst = sys.argv[1], sys.argv[2]
    zin = zipfile.ZipFile(src)
    doc = zin.read("word/document.xml").decode("utf-8")
    doc = fix_table_styles(doc)
    doc = uppercase_h1(doc)
    with zipfile.ZipFile(dst, "w", zipfile.ZIP_DEFLATED) as zout:
        for item in zin.infolist():
            data = zin.read(item.filename)
            if item.filename == "word/document.xml":
                data = doc.encode("utf-8")
            zout.writestr(item, data)


if __name__ == "__main__":
    main()
