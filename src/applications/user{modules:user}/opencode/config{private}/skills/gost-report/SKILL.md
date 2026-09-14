---
name: gost-report
description: Use when writing, formatting, or converting a Russian university report — отчёт по лабораторной работе, курсовая, ВКР, ГОСТ 7.32 — into a .docx with Times New Roman 14, 1.5 spacing, margins 25/10/20/20 mm, uppercase numbered sections, titled tables and figures. Covers the pandoc markdown→docx pipeline and PlantUML diagram rendering, with helper scripts for the formatting that pandoc cannot express.
---

# GOST-formatted reports

Turn a markdown draft into a `.docx` that passes for a university lab report,
then hand the markdown to `pandoc` with a reference document that carries the
formatting.

## Formatting rules to enforce

| Parameter | Value |
|---|---|
| Page | A4, one side |
| Margins | left 25 mm, right 10 mm, top/bottom 20 mm |
| Font | Times New Roman, 14 pt |
| Line spacing | 1.5 |
| Paragraph | justified, first-line indent 1.25 cm |
| Page numbers | bottom centre; title page counted but not printed |
| Section heading | `1 НАЗВАНИЕ` — arabic number without dot, uppercase, left with indent |
| Subsection heading | `1.1 Название` — lowercase except first letter, no trailing dot |
| New section | starts on a new page |
| Figure | caption below, centred, 12 pt, `Рисунок N – Название` |
| Table | `Таблица N – Название` above, 9–12 pt body |
| Lists | dash `–` or `а)`, `б)`, `в)` |

A headline must not be the last line on a page; keep it with at least three
lines of the following text.

## Pipeline

```
report.md ──pandoc + reference_gost.docx──▶ out.docx ──gost_postprocess──▶ report.docx
diagrams/*.puml ──plantuml──▶ diagrams/*.png  (referenced from the markdown)
```

1. Write the report as markdown (`#` = section, `##` = subsection). Number
   sections in the text (`# 1. Цель работы`); the post-processor converts the
   number into GOST form and uppercases the heading. Do **not** number the
   title page or an unnumbered preamble — only real sections.

2. Render diagrams:

   ```bash
   scripts/render_diagrams.sh diagrams
   ```

   One `.puml` per figure, always `left to right direction`. Embed the PNG in
   the markdown with the caption as the alt text (pandoc turns it into a
   centred caption under the image):

   ```markdown
   ![Рисунок 1 – Организационная структура объекта](diagrams/org.png){ width=15cm }
   ```

   Do **not** add a separate `Рисунок …` paragraph after the image — it
   duplicates the caption.

3. Build the `.docx`:

   ```bash
   scripts/build.sh report.md
   ```

   The script fetches pandoc's default reference, rewrites its styles and page
   setup to the rules above, runs pandoc, then post-processes heading case and
   page breaks. Output defaults to `report.docx` (same stem as the input).

## What the scripts do

- `scripts/gost_reference.py` — takes pandoc's default `reference.docx` and
  rewrites `word/styles.xml` (Normal, BodyText, FirstParagraph, Compact,
  Heading1–3, Caption, TableText, Title/Author/Date) plus `word/sectPr` page
  setup. Tables get `tblBorders`. Called by `build.sh`; call directly only to
  produce a reusable `reference_gost.docx`.
- `scripts/gost_postprocess.py` — after pandoc: uppercases `Heading1` text and
  turns `N. Title` into `N TITLE`, starts each section on a new page, and
  switches table cell paragraphs from `Compact` to `TableText`.
- `scripts/build.sh` — end-to-end `.md → .docx`.
- `scripts/render_diagrams.sh` — `diagrams/*.puml → *.png`.

All scripts pull `pandoc`, `plantuml`, and `graphviz` through `nix shell` when
the binaries are missing, so they work on a bare NixOS host.

## Gotchas

- **Table cells use `Compact` by default**, which inherits the 1.25 cm
  first-line indent and 1.5 spacing; in narrow columns this breaks words
  mid-syllable (`Сопроти\вл ение`). The post-processor rewrites cell
  paragraphs to `TableText` (12 pt, single spacing, no indent). If you change
  that mapping, keep the `ind firstLine=0`.
- **The Table style has no borders** out of the box. `gost_reference.py`
  injects `tblBorders`; without them the table prints as guide lines only.
- **Images with a width in braces** need the `{ width=15cm }` attribute form;
  a bare `![alt](path)` scales to natural size and can overflow the page.
- **Section numbers are literal text in the markdown**, not Word
  auto-numbering. Deleting a section means renumbering the rest by hand. That
  is intentional — real Word numbering fights pandoc's heading styles.
- The layout is tuned for this university's guide; different faculties may
  vary margins or fonts. Recheck `MARGINS`, `FONT`, `HALF_PT`, `LINE` at the
  top of `gost_reference.py`.

## Suggested document structure

```
Title page
<UNNUMBERED preamble: role distribution / состав отчёта>
1 ЦЕЛЬ РАБОТЫ
2 ПОСТАНОВКА ЗАДАЧИ
…
N ЗАКЛЮЧЕНИЕ
Приложение А …
```

Keep prose in the body and tabular data in pipe tables. Attribute parts to
their authors with a short italic line under the heading when the report is a
group effort.
