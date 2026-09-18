import fs from "node:fs";
import path from "node:path";

const ROOT = process.cwd();
const GRAMMAR = path.join(ROOT, "syntaxes", "nix-inline-injection.tmLanguage.json");
const LANGUAGES = path.join(ROOT, "languages.json");

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
for (const lang of languages) {
  grammar.patterns.push({
    begin: `(#\\s*-<\\s*${triggerAlt(lang.triggers)}\\s*>-\\s*)$`,
    beginCaptures: { 1: { name: `comment.line.number-sign.nix ${HINT}` } },
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
