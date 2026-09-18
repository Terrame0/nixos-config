import fs from "node:fs";
import { FUNCTION_BINDINGS, LANGUAGES } from "./constants";
import { generateFiles } from "./generate";
import type { LanguagesMap } from "./injection-grammar";

const includePath = process.env.CUSTOM_LANGUAGES_JSON;
if (!includePath) {
  throw new Error("CUSTOM_LANGUAGES_JSON is not set");
}

const include = JSON.parse(fs.readFileSync(includePath, "utf8")) as LanguagesMap;
const allLanguages: LanguagesMap = { ...LANGUAGES, ...include };

const changed = generateFiles(allLanguages, FUNCTION_BINDINGS, {});
console.log(changed ? "grammar files updated" : "no changes needed");
