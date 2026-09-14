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
| Code listing | monospace 11 pt, single spacing, flush left, no indent |
| Lists | dash `–` or `а)`, `б)`, `в)` |

A headline must not be the last line on a page; keep it with at least three
lines of the following text.

## Pipeline

```
report.md ──pandoc + reference_gost.docx──▶ out.docx ──gost_postprocess──▶ report.docx
diagrams/*.puml ──plantuml──▶ diagrams/*.png  (referenced from the markdown)
```

1. Write the report as markdown (`#` = section, `##` = subsection). Prefix
   every numbered heading with its intended number (`# 1. Цель работы`,
   `## 4.1. Организационная структура`). The post-processor strips the literal
   number and installs a native Word numbered-list field, so deleting a section
   renumbers the rest automatically; level-1 headings are uppercased. A heading
   **without** a leading number (an appendix, a preamble, a title-page line) is
   left unnumbered. Do **not** number the title page or an unnumbered preamble —
   only real sections.

2. Render diagrams:

   ```bash
   scripts/render_diagrams.sh diagrams
   ```

   One `.puml` per figure. Structural diagrams (component, use case) start with
   `left to right direction`; activity diagrams (`start`/`stop`) must not — that
   keyword makes plantuml reject the file. Embed the PNG in the markdown with
   the caption as the alt text (pandoc turns it into a centred caption under the
   image):

   ```markdown
   ![Рисунок 1 – Организационная структура объекта](diagrams/org.png){ width=15cm }
   ```

   Do **not** add a separate `Рисунок …` paragraph after the image — it
   duplicates the caption.

3. Build the `.docx`:

   ```bash
   scripts/build.sh report.md
   scripts/build.sh report.md out.docx --titlepage titlepages/kamchatgtu-blank.docx
   ```

   The script fetches pandoc's default reference, rewrites its styles and page
   setup to the rules above, runs pandoc, then post-processes heading case and
   page breaks. Output defaults to `report.docx` (same stem as the input).

   The title page is a separate file passed with `--titlepage`. Two kinds are
   accepted:

   - a `.docx` — its paragraphs are spliced in **verbatim** after pandoc, with
     the source document's section (margins), default table style, and paragraph
     spacing merged in. This reproduces the source one-to-one and is the
     reliable option; the university's blank form is kept at
     `~/titlepages/kamchatgtu-blank.docx`. Crop a title out of a real report
     with `scripts/extract_titlepage.py src.docx out.docx --until "Задание 1."`.
   - a `.md` — a markdown fragment with `custom-style` divs, concatenated in
     front of the report before pandoc. Handy for a quick title, but exact
     line breaks and spacing are not guaranteed.

   For the markdown form, keep the fragment outside the read-only skill tree
   (a `titlepages/` directory in the project or in `~`) and write it with the
   dedicated paragraph styles so it centers without raw XML:

   ```markdown
   ::: {custom-style="TitleCenterBold"}
   «КАМЧАТСКИЙ ГОСУДАРСТВЕННЫЙ ТЕХНИЧЕСКИЙ УНИВЕРСИТЕТ»
   :::
   ```

   Available title styles: `TitleCenter`, `TitleCenterBold`, `TitleLeft`,
   `TitleRight`. Use `&#160;` on its own line inside a `TitleCenter` div for a
   blank line; an empty div disappears.

## What the scripts do

- `scripts/gost_reference.py` — takes pandoc's default `reference.docx` and
  rewrites `word/styles.xml` (Normal, BodyText, FirstParagraph, Compact,
  Heading1–3, Caption, TableText, SourceCode/Verbatim, TitleCenter/TitleLeft/
  TitleRight, Title/Author/Date) plus `word/sectPr` page setup. Tables get
  `tblBorders`. Called by `build.sh`; call directly only to produce a reusable
  `reference_gost.docx`.
- `scripts/gost_postprocess.py` — after pandoc: strips the literal number from
  `Heading1`–`Heading3`, adds a `numPr` pointing at a heading numbering
  definition it appends to `word/numbering.xml`, uppercases `Heading1`, puts
  `<w:pageBreakBefore/>` on every section heading (skipped for the first one
  when a title page is present), switches table cell paragraphs from `Compact`
  to `TableText`, forces code paragraphs (`SourceCode`/`Verbatim`) to flush
  left with single spacing, and — with `--titlepage <file.docx>` — splices in
  the title page's body, section properties and styles.
- `scripts/extract_titlepage.py` — crops the leading body of a report `.docx`
  into a standalone title-page `.docx` (`--until <text>` or `--count <n>`).
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
- **A `SourceCode` style in `reference.docx` is not enough to keep code flush
  left.** Pandoc's default `SourceCode` does not set `jc`, so once `Normal` is
  justified the code inherits `both` and stretches each line. The post-processor
  therefore injects the alignment directly into every code paragraph; do not
  remove that step in favour of the style alone.
- **Pandoc regenerates `word/numbering.xml` and discards the reference's
  copy.** Do not put the heading numbering definition in `gost_reference.py`;
  append it to the pandoc output in `gost_postprocess.py`, picking ids above
  the ones pandoc already used.
- **Only headings with a leading number get auto-numbering.** The
  post-processor keys off the literal prefix (`1`, `4.1`), so an appendix or a
  preamble heading written without one stays unnumbered — which is what you
  want, but also means a section you forget to prefix silently loses its
  number.
- **A page break must be `<w:pageBreakBefore/>` on the heading, not a
  `<w:br w:type="page"/>` run.** With auto-numbering the number is rendered
  before the runs, so a break run lands between the number and the heading text
  and sends them to different pages (and the number miscounts).
- **A `.docx` title page only renders faithfully if its styles come along.**
  The form's two-column "Выполнил / Принял" block is a layout table that needs
  the source's default table style, and its vertical rhythm comes from the
  source's `docDefaults` spacing. The post-processor merges the missing styles
  and bakes the source spacing into title paragraphs; without that the columns
  collapse and the title spills onto a second page.
- **An empty `custom-style` div vanishes before the docx is written.** For a
  blank line in a markdown title page, put `&#160;` inside the div rather than
  leaving the body empty; pandoc drops a div whose only content is whitespace.
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
