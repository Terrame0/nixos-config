import fs from "node:fs";
import path from "node:path";

const ROOT = process.cwd();
const GRAMMAR = path.join(ROOT, "syntaxes", "nix-inline-injection.tmLanguage.json");
const INTERPOLATION_GRAMMAR = path.join(ROOT, "syntaxes", "nix-inline-interpolation.tmLanguage.json");
const LANGUAGES = path.join(ROOT, "languages.json");
const PACKAGE = path.join(ROOT, "package.json");

const HINT = "meta.embedded.hint.nix";
const RE_META_ESCAPE = /[.*+?^${}()|[\]\\]/g;
const escapeRegex = (s) => s.replace(RE_META_ESCAPE, "\\$&");
const triggerAlt = (triggers) =>
  triggers.length === 1 ? escapeRegex(triggers[0]) : `(?:${triggers.map(escapeRegex).join("|")})`;

const grammar = JSON.parse(fs.readFileSync(GRAMMAR, "utf8"));
const languages = JSON.parse(fs.readFileSync(LANGUAGES, "utf8"));

// highlight the existing `/* lang */` marker comments with the hint scope
for (const rule of Object.values(grammar.repository ?? {})) {
  const capture = rule.beginCaptures && rule.beginCaptures["1"];
  if (!capture || !capture.name) continue;
  const scopes = capture.name.split(/\s+/);
  if (scopes.includes("comment.block.nix") && !scopes.includes(HINT)) {
    capture.name = `${capture.name} ${HINT}`;
  }
}

// `${...}` inside a block is Nix, not the embedded language. Kept both as an
// inline pattern (wins for languages whose own `$` rule is short) and as a
// separate injection grammar below (wins for languages whose rule spans the
// `$`, e.g. a CSS selector over several lines). The inline one alone cannot
// cover shell, and the injection alone may be skipped by a host that does not
// load a second injected grammar, so both are emitted.
const interpolation = {
  begin: "(?<!'')\\$\\{",
  beginCaptures: { 0: { name: "punctuation.section.embedded.begin.nix" } },
  end: "\\}",
  endCaptures: { 0: { name: "punctuation.section.embedded.end.nix" } },
  contentName: "meta.embedded.expression.nix",
  patterns: [{ include: "source.nix" }],
};

// `# -<lang>-` on its own line between the function call and the string opener.
// The opener is alone on its line, so it must be claimed by the nested rule
// (patterns win ties via applyEndPatternLast); the closing `''` carries a
// trailing token, so the outer end takes it.
// The delimiters stay plain comment scopes (grey); only the language name gets
// the hint scope so it renders yellow.
for (const lang of languages) {
  grammar.patterns.push({
    begin: `(#\\s*-<\\s*)(${triggerAlt(lang.triggers)})(\\s*>-\\s*)$`,
    beginCaptures: {
      1: { name: "comment.line.number-sign.nix" },
      2: { name: `comment.line.number-sign.nix ${HINT}` },
      3: { name: "comment.line.number-sign.nix" },
    },
    end: "^\\s*''(?!')",
    endCaptures: { 0: { name: "punctuation.definition.string.end.nix" } },
    applyEndPatternLast: true,
    patterns: [
      {
        begin: "^\\s*''(?=\\s*$)",
        beginCaptures: { 0: { name: "punctuation.definition.string.begin.nix" } },
        end: "(?=^\\s*''(?!'))",
        contentName: `meta.embedded.block.${lang.key}`,
        patterns: [interpolation, { include: lang.scope }],
      },
    ],
  });
}

fs.writeFileSync(GRAMMAR, JSON.stringify(grammar, null, 2) + "\n");
console.log(`patched ${path.relative(ROOT, GRAMMAR)}`);

// The injection half of the `${...}` handling. It is evaluated alongside
// whichever rule is on top of the stack, so it wins even when a long language
// rule swallowed the `$` (e.g. a multi-line CSS selector), which the inline
// pattern cannot do.
const interpolationGrammar = {
  $schema: "https://raw.githubusercontent.com/martinring/tmlanguage/master/tmlanguage.json",
  scopeName: "nix.inline-interpolation",
  injectionSelector: "L:source.nix meta.embedded.block",
  patterns: [interpolation],
  repository: {},
};
fs.writeFileSync(INTERPOLATION_GRAMMAR, JSON.stringify(interpolationGrammar, null, 2) + "\n");
console.log(`wrote ${path.relative(ROOT, INTERPOLATION_GRAMMAR)}`);

const pkg = JSON.parse(fs.readFileSync(PACKAGE, "utf8"));
const grammars = (pkg.contributes && pkg.contributes.grammars) || [];
const interpolationGrammarContribution = {
  scopeName: "nix.inline-interpolation",
  path: "./syntaxes/nix-inline-interpolation.tmLanguage.json",
  injectTo: ["source.nix"],
};
const existing = grammars.findIndex((g) => g.scopeName === "nix.inline-interpolation");
if (existing === -1) {
  grammars.push(interpolationGrammarContribution);
} else {
  grammars[existing] = interpolationGrammarContribution;
}
pkg.contributes.grammars = grammars;
fs.writeFileSync(PACKAGE, JSON.stringify(pkg, null, 2) + "\n");
console.log(`updated ${path.relative(ROOT, PACKAGE)} (nix.inline-interpolation)`);
