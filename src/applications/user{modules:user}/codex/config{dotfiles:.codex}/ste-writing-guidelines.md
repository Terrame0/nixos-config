# Simplified Technical English (STE) — Condensed Writing Guidelines

Condensed operational rule set derived from ASD-STE100, Issue 9 (published 15 January 2025):
**53 writing rules in 9 sections, plus 8 general recommendations (GR-1 … GR-8).** All 53 are
covered below and the original rule numbers are kept for traceability. Use as system
instructions for generating or rewriting technical documentation in English.

*Status: this is an independent paraphrase written for machine use, not a copy or an
authorised extract of the standard. ASD-STE100 is © ASD (Brussels) and is a trademark; the
official document is available free of charge from asd-ste100.org. This digest does not
replace it, and it deliberately omits the controlled dictionary (see §12).*

---

## 0. Scope and core principles

STE has two parts: **writing rules** (below) and a **controlled dictionary** of approved
words (see §12 — you must be supplied with it separately; it is not reproduced here).

Two text types, with different rules:

- **Procedural writing** — instructions/work steps. Imperative form. Max 20 words/sentence.
- **Descriptive writing** — explanation of what something is, how it works. No imperative.
  Max 25 words/sentence.

Governing objective: the reader understands each sentence **on first reading**. Prefer the
plain, repetitive, unambiguous formulation over the elegant one. Never introduce stylistic
variation for its own sake.

---

## 1. Words

| Rule | Requirement |
|---|---|
| 1.1 | Use only: (a) words approved in the STE dictionary, (b) technical nouns, (c) technical verbs. |
| 1.2 | Use an approved word only as its approved part of speech. |
| 1.3 | Use an approved word only with its approved meaning. |
| 1.4 | Use only the approved forms of verbs and adjectives. |
| 1.5–1.6 | A word outside the dictionary is allowed only if it qualifies as a technical noun (or part of one). |
| 1.7 | Do not use a technical noun as a verb. |
| 1.8 | Technical nouns must come from the company glossary / terminology database / subject field. |
| 1.9 | Where there is a choice, pick the shortest, clearest technical noun. |
| 1.10 | No regional, slang, or jargon words. |
| 1.11 | One item = one name. Never two different technical nouns for the same item. |
| 1.12–1.13 | Technical verbs are allowed by category; do not use a technical verb as a noun. |
| 1.14 | American English spelling (Merriam-Webster), unless official directives say otherwise. |

**Technical noun** = a noun term for a specific concept in a subject field. Admissible
categories include: official parts information; vehicles/machines and locations on them;
tools and support equipment; materials, consumables, contaminants; facilities and logistics;
systems, circuits, functions, configurations, positions and modes; math/science/engineering
terms and formulas; navigation and geographic terms; numbers, units, time; quoted text on
placards, labels, signs and displays; roles, persons, organizations, geopolitical entities;
body parts; personal effects, food, beverages; medical terms; official documents and their
parts.

**Word-for-word replacement first.** If an unapproved word has an approved alternative of the
same part of speech, swap it. If the alternative has a different part of speech, or if the
swap changes the meaning, restructure the sentence instead (rule 9.1).

Examples:
- `A value of 2 mm is acceptable.` → `A value of 2 mm is permitted.`
- `Make sure that the valve is operable.` → `Make sure that the valve can operate.`
- `Test the system for leaks.` → `Do a test for leaks in the system.` (*test* = noun only)
- `Dim the lights.` → `Set the lights to the dim position.` (*dim* = adjective only)
- `Follow the safety instructions.` → `Obey the safety instructions.` (*follow* = "come after" only)

---

## 2. Multi-word nouns

- **2.1** Maximum **three words** in a multi-word noun.
- **2.2** If the established technical term is longer, write it in full once, then either
  define a shorter form or hyphenate the words that act as one unit.

Break long noun strings with prepositions (`of`, `on`, `in`, `for`):

- `Runway light connection resistance calibration` (5) →
  `Calibration of the resistance of the runway light connection.`
- `Install the forward turbine overheat thermocouple terminal tags.` (6) →
  `Install the terminal tags on the forward overheat thermocouple of the turbine.`

---

## 3. Verbs

- **3.1** Use only the verb forms listed in the dictionary.
- **3.2** Permitted forms only: infinitive; imperative; simple present; simple past; simple
  future; past participle **used as an adjective**.
  Not permitted: present perfect (*has adjusted*), past perfect (*had adjusted*),
  progressive (*is adjusting*), and any other complex construction.
- **3.3** The past participle as an adjective goes before a noun, or after *be / become / stay*:
  `Examine the disassembled unit.` / `When the unit is fully disassembled, clean all parts.`
- **3.4** No auxiliary verbs for complex constructions.
  - `The volume control can be adjusted.` → `You can adjust the volume control.`
  - `The temperature must be adjusted.` → `Adjust the temperature.`
  - `The seat is to be installed before you install the cushion.` → `Before you install the cushion, install the seat.`
- **3.5** The `-ing` form only as a technical noun (`Cleaning`, `Troubleshooting`, `Packaging`)
  or as a modifier inside a technical noun (`degreasing agent`, `switching relay`,
  `welding torch`). Never as a progressive verb or a participial clause.
  - `When you are doing this procedure, obey all precautions.` → `When you do this procedure, obey all precautions.`
- **3.6** **Active voice.** Passive is permitted only in descriptive writing and only when the
  agent is genuinely unknown (`During transmission, the data was corrupted.`).
  Conversion methods: promote the agent to subject; replace the empty verb with the real
  action verb; switch to imperative in procedures; use `you` (the reader) or `we` (the
  organization) as subject.
- **3.7** Express an action with an approved **verb**, not a nominalization.
  - `The ohmmeter gives an indication of 450 ohms.` → `The ohmmeter shows 450 ohms.`
  - `Before the removal of the unit, …` → `Before you remove the unit, …`
  - `Check the laptop battery.` → `Do a check of the laptop battery.` (*check* = noun only)

---

## 4. Sentences (both text types)

- **4.1** Short, concrete sentences. One topic per sentence. No abstract statements.
  - `No leaks are permitted.` → `Make sure that there are no leaks.`
  - `Different temperatures will change the cure time.` → `When the temperature increases, the cure time decreases.`
- **4.2** Do not omit words and do not use contractions.
  - `Rotary switch to INPUT.` → `Set the rotary switch to INPUT.`
  - `If installed, remove the shims.` → `If shims are installed, remove them.`
- **4.3** Use a **vertical list** for complex content (multiple conditions, parts, parallel steps).
  - Do not mix procedural and descriptive items in one list.
  - Each item must connect grammatically to the stem before the colon.
  - Avoid nested lists — flatten them, or put the sub-items in parentheses.
  - In safety instructions, repeat the negative command in each item
    (`- DO NOT put your feet on the APU line.`), not once above the list.
  - If items are not full sentences, no period except at the end of the last item.
- **4.4** Connect related sentences with approved connectors: `and`, `but`, `then`, `thus`,
  `as a result`, `at the same time`, and with demonstratives (`This method …`,
  `This precaution …`).
- **4.5** Use articles and demonstratives; do not drop them to shorten text.
  - `Turn shaft assembly.` → `Turn the shaft assembly.`
  - No article in general/abstract statements: `Solvents can cause damage to paint.`
  - Series: `Discard the O-rings (3), gaskets (4), seals (7), and washers (9).`
    Repeating the article changes the scope of an adjective —
    `the new O-rings (15), spacers (14), nut (13)` (all new) vs
    `the new O-rings (15), the spacers (14), the nut (13)` (only the O-rings are new).
  - No definite article before a noun followed by an alphanumeric identifier:
    `Tag circuit breaker 36L7.`

---

## 5. Procedural writing

- **5.1** Maximum **20 words** per sentence (safety instructions included).
- **5.2** One instruction per sentence. Two sentences in one step only when the actions are
  simultaneous, or when the second gives the immediate result/limit of the first.
- **5.3** Imperative form. Do not use `must` before an imperative except in safety
  instructions or an important condition.
  - `Before you remove the clamp, you must disconnect the hose.` → `Before you remove the clamp, disconnect the hose.`
- **5.4** Condition first, then a comma, then the command.
  - `Set the switch to NORMAL when the light comes on.` → `When the light comes on, set the switch to NORMAL.`
  - Comma placement changes meaning — check it.
- **5.5** **Notes give information only.** No instructions, no imperative, no requirements,
  no limits, no tolerances. Max 25 words per sentence in a note.
  - A note that carries a risk of injury or damage must be rewritten as a WARNING or CAUTION.
  - A note that carries a limit must be merged into the work step:
    `Measure the leakage from the outlet port. The leakage must not be more than 0.5 cc/minute.`
  - Test: remove all notes — the procedure must still be executable.

---

## 6. Descriptive writing

- **6.1** Release information gradually; one subject per sentence.
- **6.2** Build cohesion by repeating **key words and key phrases**, not by varying them.
- **6.3** Maximum **25 words** per sentence.
- **6.4** Each paragraph starts with a **topic sentence**; the rest of the paragraph develops it.
- **6.5** One topic per paragraph. (The set of topic sentences should read as a valid outline.)
- **6.6** Maximum **six sentences** per paragraph.

---

## 7. Safety instructions

- **7.1** Label the risk level with a word or symbol.
  **WARNING** = risk of injury or death. **CAUTION** = risk of damage to objects.
  (If your domain uses other labels, the content must still obey 7.1–7.3.)
- **7.2** Open with a clear command or the governing condition:
  `DO NOT SWALLOW THE SOLVENT.` / `WHILE YOU USE THE SPRAY PAINT, POINT THE SPRAY AWAY FROM YOUR FACE.`
- **7.3** State the risk or consequence explicitly:
  `SOLVENTS ARE POISONOUS AND CAN CAUSE INJURY OR DEATH.` /
  `THESE CLEANING AGENTS CAN CAUSE CORROSION.`

Structure: **[condition] + command → consequence.** Never abstract ("Be careful"), always
specific. Escalate to WARNING whenever injury or death is possible. Sentence limit: 20 words.

---

## 8. Punctuation and word count

- **8.1** All standard punctuation except the **semicolon** — split into two sentences instead.
- **8.2** Hyphens connect directly related words: compound adjectives before a noun
  (`high-pressure chamber`, `quick-release fastener`), two-word numbers (`forty-seven`),
  letter/number + noun shapes (`O-ring`, `L-shaped bracket`, `3-prong connector`),
  compound verbs (`heat-treat`, `short-circuit`), prefix + vowel-initial root (`de-icing`, `pre-amplifier`).
- **8.3** Parentheses are allowed for: references to figures/text; item callout numbers;
  step identifiers; abbreviations; singular/plural at once (`the test(s)`); short
  explanations; alternatives (`the left (right) panel`).

**Word count rules** (they define whether the 20/25-word limit is met):

- **8.4** In a vertical list, the colon acts as a period. The stem obeys the limit; each item
  is counted as a separate sentence.
- **8.5** Text in parentheses counts as **one word** in the host sentence — but is also
  counted separately as its own sentence.
- **8.6** Each of these counts as one word: a number; a number with its unit (`10 °C`);
  an abbreviation/acronym/initialism; an alphanumeric identifier (`No. 1`, `36L7`);
  quoted text and formulas; titles, headings, placard and label text; proper nouns of
  persons, organizations, and geopolitical entities. Step/paragraph numbers are not counted.
- **8.7** A hyphenated group counts as one word (`a soap-and-water solution` = 7 words).

---

## 9. Writing practices

- **9.1** When a word-for-word swap does not work, change the sentence construction.
  - `The oil level on the sight gauge must be visible during the test.` →
    `During the test, make sure that you can see the oil level on the sight gauge.`
- **9.2** Respect the restricted meaning of approved words.
  - `Wear protective clothing.` → `Put on protective clothing.` (*wear* = damage by friction)
  - `This regulation extends to all units.` → `This regulation is applicable to all units.`
  - `The indicator turns green.` → `The color of the indicator changes to green.`
  - `Do not let the pressure go below 20 psi.` → `Do not let the pressure become less than 20 psi.`
    (*above/below* = physical position, not limits)
  - `Move the tube to see if the connection is tight.` → `… to make sure that the connection is tight.`
- **9.3** **No phrasal verbs** built from approved words.
  - `put out the fire` → `extinguish the fire`; `give off fumes` → `release fumes`.
  - Only a few phrasal verbs are approved (e.g. `put on`, `come on`) with restricted meanings.
- **9.4** **Consistency is mandatory.** Same item → same noun every time. Same type of action →
  same wording every time. Do not alternate between `torque` and `torque-tighten`, or between
  `body`, `main body`, and `body assembly`.

**General recommendations (not rules, but apply them):**

- **GR-1** Keep the conjunction `that`: `Make sure that the valve is open.`
- **GR-2** `with` is ambiguous (association / instrument / accompaniment). Re-read every
  sentence containing it; restructure if more than one reading is possible. Keep the primary
  action verb: `Seal the opening with tool TS9867.` (not `Use tool TS9867 to seal…`)
- **GR-3** Use only approved pronouns. If a pronoun could refer to more than one noun,
  repeat the noun.
- **GR-4** `this` must have an unambiguous referent; otherwise restate the context.
- **GR-5** Beware false friends (non-native writers).
- **GR-6** No Latin abbreviations: `e.g.` → `for example`; `i.e.` → `that is`; drop `etc.`
- **GR-7** Gender-neutral language. `he`/`she` are not permitted; `man`/`woman` only where
  contextually necessary (e.g. medical text).
- **GR-8** The possessive `'s` is permitted but avoid it if you are not certain it is correct.

---

## 10. Frequent substitutions (illustrative)

These are among the most common errors. The full set lives in the dictionary.

| Not approved | Use instead |
|---|---|
| ensure (v) | make sure (v) |
| avoid (v) | prevent (v) |
| perform (v) | do (v) |
| follow (v, "comply") | obey (v) |
| fit (v) | install (v) |
| press (v) | push (v) |
| rotate (v) | turn (v) |
| may (v) | can (v) |
| shall / should (v) | must (v) |
| however (adv) | but (conj) |
| therefore (adv) | thus (adv), as a result |
| since (conj, "because") | because (conj) |
| main (adj) | primary (adj) |
| acceptable (adj) | permitted (adj) |
| people (n) | person (n), personnel (n) |
| check / test / damage / cover (v) | use as nouns: *do a check of…*, *cause damage to…* |

---

## 11. Output self-check

Before returning text, verify:

1. Text type identified (procedure vs description) and rules applied accordingly.
2. Sentence length: ≤20 words (procedures, safety) / ≤25 words (descriptions, notes),
   counted per §8.4–8.7.
3. Active voice; approved verb forms only; no `-ing` verbs; no phrasal verbs.
4. Imperative in every work step; one instruction per step; conditions placed first.
5. Multi-word nouns ≤3 words.
6. No semicolons, no contractions, no omitted articles/subjects/verbs, no Latin abbreviations.
7. Notes contain information only.
8. Safety instructions: level + command/condition + consequence.
9. Paragraphs ≤6 sentences, one topic, topic sentence first.
10. Terminology and phrasing identical across the whole document.
11. Every word is either dictionary-approved, or a defensible technical noun/verb.

---

## 12. Dictionary access protocol

This file contains the **writing rules only**. STE equally depends on the controlled
dictionary (Issue 9: 875 approved words with restricted meanings and approved forms, plus
1274 unapproved words with approved alternatives). No summary substitutes for it: its value
is exactly its completeness.

**If a dictionary lookup is available** (retrieval index, tool call, or attached term base):

- Check every content word — noun, verb, adjective, adverb — before output.
- Check three things, not one: the word is approved; the intended part of speech matches;
  the intended meaning matches the approved meaning.
- On a miss, first try a same-part-of-speech alternative; if none fits, restructure (rule 9.1).
- Do not check function words, technical nouns, or technical verbs against the dictionary —
  they are governed by rules 1.5–1.13 and by the local glossary.

**If no dictionary lookup is available:**

- Apply rules 1–9 in full — they are deterministic and do not depend on the dictionary.
- Treat vocabulary as best-effort: prefer the shortest, most common, most concrete word;
  prefer a verb from the small closed set of everyday technical verbs; never introduce a
  synonym for a word already used elsewhere in the document.
- Mark uncertain lexical choices for human review rather than asserting compliance.
- State plainly that the output is **rule-compliant but not dictionary-verified**. Never
  claim STE compliance without dictionary verification.
