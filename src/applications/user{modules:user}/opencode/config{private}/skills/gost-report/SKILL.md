---
name: gost-report
description: Use when writing, formatting, or converting a Russian university report — отчёт по лабораторной работе, курсовая, ВКР, ГОСТ 7.32 — into a .docx with Times New Roman 14, 1.5 spacing, margins 25/10/20/20 mm, uppercase numbered sections, titled tables and figures. Covers the pandoc markdown→docx pipeline and PlantUML / IDEF0 diagram rendering, with helper scripts for the formatting that pandoc cannot express.
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
| Figure | caption below, centred, 12 pt, `Рисунок N — Название` |
| Table | `Таблица N — Название` above, 9-12 pt body |
| Code listing | monospace 11 pt, single spacing, flush left, no indent |
| Lists | dash `—` or `а)`, `б)`, `в)` |

A headline must not be the last line on a page; keep it with at least three
lines of the following text.

## Pipeline

```
report.md ──pandoc + reference_gost.docx──▶ out.docx ──gost_postprocess──▶ report.docx
diagrams/*.puml  ──plantuml──▶ diagrams/*.png              (referenced from the markdown)
diagrams/*.idef0 ──schematic──▶ *.svg ──resvg──▶ *.png     (referenced from the markdown)
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

   ```nu
   scripts/render_diagrams.nu diagrams
   ```

   The script handles two source types, one figure each:

   - **`.puml` → `.png`** via PlantUML. Structural diagrams (component, use case)
     start with `left to right direction`; activity diagrams (`start`/`stop`)
     must not — that keyword makes plantuml reject the file. Renders at
     `PLANTUML_DPI` (default 300) because plantuml's native PNG is ~89 DPI and
     pixelates once scaled to the page width; set `PLANTUML_DPI=600` for a
     larger image.
   - **`.idef0` → `.svg` + `.png`** via `schematic` (IDEF0-SVG-GOST-wrapped),
     then `resvg`. Renders at `IDEF0_DPI` (default 300). The `.svg` is kept next
     to the model so the PNG can be re-rendered at another DPI without re-running
     `schematic`. The model itself is a small DSL, one statement per line:

     ```
     Управление хостелом receives Заявки гостей
     Управление хостелом respects Правила хостела
     Управление хостелом requires Персонал хостела
     Управление хостелом produces Размещённые гости
     ```

     Predicates are `receives` (input, left), `respects` (control, top),
     `requires` (mechanism, bottom), `produces` (output, right), and
     `is composed of` (sub-function).

   Embed the PNG in the markdown with the caption as the alt text (pandoc turns
   it into a centred caption under the image):

   ```markdown
   ![Рисунок 1 — Организационная структура объекта](diagrams/org.png){ width=15cm }
   ```

   A wide landscape figure such as an IDEF0 context diagram needs a larger
   width than the default; 17 cm is a good starting point. Do **not** add a
   separate `Рисунок …` paragraph after the image — it duplicates the caption.

3. Title tables with pandoc's native caption syntax — a `Table:` line directly
   above the pipe table. Pandoc emits a centred `TableCaption` paragraph, and
   the post-processor keeps it with the table:

   ```markdown
   Table: Таблица 1 — Кадровая структура объекта

   | Сотрудник | Деятельность |
   |---|---|
   ```

   Number table titles by hand (`Таблица N — …`), the same way figures are
   numbered. A `::: {custom-style="Caption"}` div renders the same style, but
   the native form marks the paragraph as a table caption and is preferred. Do
   **not** add a separate caption paragraph after the table — the title goes
   above it.

4. Build the `.docx`:

   ```nu
   scripts/build.nu report.md
   scripts/build.nu report.md out.docx --titlepage titlepages/kamchatgtu-blank.docx
   ```

   The script fetches pandoc's default reference, rewrites its styles and page
   setup to the rules above, runs pandoc, then post-processes heading case,
   page breaks and page numbers. Output defaults to `report.docx` (same stem as
   the input).

   The title page is a separate file passed with `--titlepage`. Two kinds are
   accepted:

   - a `.docx` — its paragraphs are spliced in **verbatim** after pandoc, with
     the source document's section (margins), default table style, and paragraph
     spacing merged in. This reproduces the source one-to-one and is the
     reliable option; the university's blank form is kept at
     `~/documents/titlepages/kamchatgtu-blank.docx`. Crop a title out of a real
     report with
     `scripts/extract_titlepage.py src.docx out.docx --until "Задание 1."`.
   - a `.md` — a markdown fragment with `custom-style` divs, concatenated in
     front of the report before pandoc. Handy for a quick title, but exact
     line breaks and spacing are not guaranteed. Ready fragments live next to
     the blank form in `~/documents/titlepages/` (`kamchatgtu-lab.md`,
     `kamchatgtu-it-eu.md`) and can be copied into the project and filled in.

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

   To force a table (or any block) onto a fresh page when page-flow heuristics
   let it split, drop a `PageBreak` paragraph in front of it:

   ```markdown
   ::: {custom-style="PageBreak"}
   &#160;
   :::
   ```

   This is a hard `pageBreakBefore`, honored by every renderer — unlike the
   automatic row-keeping below.

## What the scripts do

- `scripts/gost_reference.py` — takes pandoc's default `reference.docx` and
  rewrites `word/styles.xml` (Normal, BodyText, FirstParagraph, Compact,
  Heading1-3, Caption, TableCaption, TableText, SourceCode/Verbatim,
  TitleCenter/TitleLeft/TitleRight, PageBreak, Title/Author/Date) plus
  `word/sectPr` page setup. Tables get `tblBorders`; the document and Normal
  style are pinned to `ru-RU` so spell-check does not flag every word. Called
  by `build.nu`; call directly only to produce a reusable `reference_gost.docx`.
- `scripts/gost_postprocess.py` — after pandoc: strips the literal number from
  `Heading1`-`Heading3`, adds a `numPr` pointing at a heading numbering
  definition it appends to `word/numbering.xml`, uppercases `Heading1`, puts
  `<w:pageBreakBefore/>` on every section heading (skipped for the first one
  when a title page is present), switches table cell paragraphs from `Compact`
  to `TableText`, forces code paragraphs (`SourceCode`/`Verbatim`) to flush
  left with single spacing, keeps table rows from splitting and a table up to
  `KEEP_TABLE_MAX_ROWS` rows together with its caption, adds a centred
  page-number footer to the body section, and — with `--titlepage <file.docx>` —
  splices in the title page's body, section properties and styles.
- `scripts/extract_titlepage.py` — crops the leading body of a report `.docx`
  into a standalone title-page `.docx` (`--until <text>` or `--count <n>`).
- `scripts/build.nu` — end-to-end `.md → .docx`.
- `scripts/render_diagrams.nu` — `diagrams/*.puml → *.png` at `PLANTUML_DPI`
  (default 300), and `diagrams/*.idef0 → *.svg + *.png` at `IDEF0_DPI`
  (default 300) via `schematic` then `resvg`.

All scripts pull `pandoc`, `python3`, `plantuml`, `graphviz`, `resvg`, and the
`schematic` binary through `nix shell` when the tools are missing, so they work
on a bare NixOS host. `schematic` comes from the
[IDEF0-SVG-GOST-wrapped](https://github.com/Terrame0/IDEF0-SVG-GOST-wrapped)
flake, not nixpkgs.

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
- **PlantUML's default PNG is ~89 DPI and pixelates at page width.**
  `render_diagrams.nu` passes `-Sdpi=300`; the `scale` directive does not help
  because it only applies to SVG output. Raise `PLANTUML_DPI` if a figure is
  still soft.
- **IDEF0 box numbers follow model order, not the picture.** `schematic` numbers
  children `A1`, `A2`, … by their order in the `.idef0` file, but the layout
  engine reorders boxes to reduce line crossings, so `A2` can appear left of
  `A1`. Only the single-process context diagram (exactly one box, `A0`) is
  unaffected — which is the common report case.
- **`Times New Roman` is not installed on Linux.** The figure's font stack falls
  back to `Liberation Serif`, which is metric-compatible and covers Cyrillic.
  `resvg` resolves this through system fonts, so the diagram inherits the
  desktop's font configuration.
- **Do not reach for PlantUML, Graphviz, or d2 for IDEF0.** None can put ports
  on all four sides of the box. IDEF0-SVG is the only CLI renderer that does;
  `schematic` is the entry point for it.
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
- **A `.md` title page gets no section break of its own.** Unlike the `.docx`
  form, the fragment is just concatenated, so the title is separated only by
  the `pageBreakBefore` on the report's first `Heading1`. If the body starts
  with plain prose instead, the prose lands on the title page. End the fragment
  with a `PageBreak` div (`&#160;` inside) only when the body does **not**
  start with a heading: with one, the div's break and the heading's own stack
  and leave a blank page between.
- **A table that does not fit the remaining space is moved whole to the next
  page, not split.** The post-processor stamps `<w:cantSplit/>` on every row
  and `<w:keepNext/>` on all but the last row of a table when it has at most
  `KEEP_TABLE_MAX_ROWS` (15) rows, and keeps the caption paragraph with the
  table. A longer table is allowed to split, and pandoc's header row repeats on
  each page. Raise or lower the constant to change the cutoff.
- **`cantSplit` on a row does not keep the whole table together.** It only
  stops a single row from breaking mid-height. Whole-table retention needs
  `keepNext` on the preceding rows as well.
- **OnlyOffice does not honor `keepNext` on table cells.** Rows still split
  across pages there while Word and LibreOffice keep them together — ONLYOFFICE
  issue #3641, a confirmed bug (fix not merged). When a table must not split and
  the output will be opened in OnlyOffice, put a `PageBreak` paragraph in front
  of it instead of trusting the automatic keep. The `keepNext`/`cantSplit`
  stamps are still worth adding for Word and LibreOffice.
- **`<w:pPr>` children must stay in schema order** — `pStyle`, then `keepNext`,
  then `keepLines`, `pageBreakBefore`, `numPr`, `spacing`, `ind`, `jc`. Word
  and OnlyOffice silently drop out-of-order properties, so a `keepNext` inserted
  before `pStyle` looks right in LibreOffice (lenient) but does nothing in Word.
  Insert `keepNext` right after `pStyle`, not at the start of `pPr`.
- **An empty `custom-style` div vanishes before the docx is written.** For a
  blank line in a markdown title page, put `&#160;` inside the div rather than
  leaving the body empty; pandoc drops a div whose only content is whitespace.
- **A document left in `en-US` gets every Russian word underlined by
  spell-check.** Pandoc's default `docDefaults` declares `en-US`; Word and
  OnlyOffice then flag the whole report, which looks like an error in a
  printed screenshot. `gost_reference.py` sets `<w:lang w:val="ru-RU">` in both
  `docDefaults` and `Normal`; do not drop it.
- **Page numbers live in a footer part, not in `document.xml`.** The
  post-processor adds `word/footer1.xml`, its relationship and content type,
  and a `<w:footerReference>` on the last section only. Because the title-page
  section keeps none, the title is counted but not printed. The reference must
  be the **first** child of `<w:sectPr>` — before `pgSz` — or Word ignores it.
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
