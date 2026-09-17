#!/usr/bin/env python3
"""Crop a title page out of a larger .docx into a standalone editable .docx.

  extract_titlepage.py <src.docx> <out.docx> [--until <text> | --count <n>]

Selects the leading body paragraphs of <src.docx> up to (excluding) the first
one containing <text>, or the first <n> paragraphs, and writes them to
<out.docx> with the same package, so the result opens in Word and can be fed to
build.nu via --titlepage. Without --until/--count the whole source body is kept.
"""
import re
import sys
import zipfile

from gost_postprocess import BODY_ELEMENT_RE


def select(elements, until, count):
    if until is not None:
        selected = []
        for el in elements:
            text = "".join(re.findall(r"<w:t[^>]*>(.*?)</w:t>", el, re.DOTALL))
            if until in text:
                break
            selected.append(el)
        return selected
    if count is not None:
        return elements[:count]
    return elements


def main():
    args = sys.argv[1:]
    until = None
    count = None
    if "--until" in args:
        i = args.index("--until")
        until = args[i + 1]
        del args[i:i + 2]
    if "--count" in args:
        i = args.index("--count")
        count = int(args[i + 1])
        del args[i:i + 2]
    src, out = args[0], args[1]

    zin = zipfile.ZipFile(src)
    document = zin.read("word/document.xml").decode("utf-8")
    body = re.search(r"<w:body>(.*)</w:body>", document, re.DOTALL).group(1)
    body = re.sub(r"<w:sectPr\b.*?</w:sectPr>", "", body, flags=re.DOTALL)
    sectpr = re.search(r"<w:sectPr\b.*?</w:sectPr>", document, re.DOTALL)
    elements = BODY_ELEMENT_RE.findall(body)
    kept = select(elements, until, count)
    fragment = "".join(kept)
    if sectpr:
        fragment += sectpr.group(0)
    document = document.replace(body, fragment, 1)

    with zipfile.ZipFile(out, "w", zipfile.ZIP_DEFLATED) as zout:
        for item in zin.infolist():
            data = zin.read(item.filename)
            if item.filename == "word/document.xml":
                data = document.encode("utf-8")
            zout.writestr(item, data)

    print(f"written: {out} ({len(kept)} paragraph(s))")


if __name__ == "__main__":
    main()
