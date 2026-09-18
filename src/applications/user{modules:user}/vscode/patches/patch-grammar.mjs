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
        patterns: [{ include: lang.scope }],
      },
    ],
  });
}

fs.writeFileSync(GRAMMAR, JSON.stringify(grammar, null, 2) + "\n");
console.log(`patched ${path.relative(ROOT, GRAMMAR)}`);

// `${...}` inside an embedded block must be highlighted as Nix, not as the
// embedded language. The language grammar regularly runs long rules which
// swallow the `$` (e.g. a CSS selector spanning several lines), and an outer
// rule's `end` is not consulted while such a rule is on top of the stack. A
// separate injection grammar is evaluated alongside whichever rule is active,
// so its `${` wins the tie.
const interpolationGrammar = {
  $schema: "https://raw.githubusercontent.com/martinring/tmlanguage/master/tmlanguage.json",
  scopeName: "nix.inline-interpolation",
  injectionSelector: "L:source.nix meta.embedded.block",
  patterns: [
    {
      begin: "(?<!'')\\$\\{",
      beginCaptures: { 0: { name: "punctuation.section.embedded.begin.nix" } },
      end: "\\}",
      endCaptures: { 0: { name: "punctuation.section.embedded.end.nix" } },
      contentName: "meta.embedded.expression.nix",
      patterns: [{ include: "source.nix" }],
    },
  ],
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
