{settings, ...}: let
  inherit (settings) palette;
in {
  "editor.tokenColorCustomizations" = {
    textMateRules = [
      # -- light-gray (punctuation / comments)
      {
        scope = [
          "punctuation" # punctuation
          "meta.property-list.scss" # scss property lists
          "punctuation.definition.entity.css" # css entity punctuation
          "meta.at-rule.include.scss" # scss include
          "keyword.operator" # operators
          "comment" # comments
          "punctuation.definition.comment" # comment markers
          "string.comment" # embedded comments
        ];
        settings.foreground = palette.light-gray;
      }

      # -- white (variables / attributes / language fallbacks)
      {
        scope = [
          "variable.other.object" # object vars
          "variable" # general vars
          "variable.parameter" # function params
          "variable.other.readwrite" # mutable vars
          "variable.scss" # scss vars
          "variable.other.object.property" # object properties
          "variable.other.property" # properties
          "entity.other.attribute-name" # attributes
          "entity.name.tag" # html tags
          "meta" # fallback meta
          "source.cpp" # cpp fallback
          "source.css" # css fallback
          "source.css.scss" # scss fallback
        ];
        settings.foreground = palette.white;
      }
      {
        scope = "markup.bold";
        settings = {
          foreground = palette.white;
          fontStyle = "bold";
        };
      }
      {
        scope = "markup.italic";
        settings = {
          foreground = palette.white;
          fontStyle = "italic";
        };
      }

      # -- purple (keywords / numbers / constants / language literals)
      {
        scope = [
          "keyword" # keywords
          "keyword.control" # control flow
          "keyword.other" # misc keywords
          "keyword.other.operator" # operator keywords
          "keyword.other.using" # using/import
          "keyword.other.unit" # units
          "constant.numeric.float.suffix" # float suffix
          "constant.numeric" # numbers
          "keyword.other.unit.suffix.floating-point" # float units
          "constant.language" # true/false/null
          "support.constant.property-value.css" # css constants
          "constant" # generic constants
          "constant.other" # other constants
          "constant.other.option" # option constants
          "entity.name.constant" # named constants
          "variable.other.constant" # const vars
          "variable.other.enummember" # enum members
          "variable.language" # this / self / super
          "support.constant" # built-in constants
          "support.constant.math" # Math.*
          "support.constant.dom" # DOM constants
          "support.constant.json" # json constants
        ];
        settings.foreground = palette.purple;
      }
      {
        scope = "meta.diff.range";
        settings = {
          foreground = palette.purple;
          fontStyle = "bold";
        };
      }

      # -- blue (types / classes / storage / keys / diff & markdown headers)
      {
        scope = [
          "support.type.property-name.css" # css property names
          "entity.name.type" # types
          "storage.type" # type keywords
          "support.type" # built-in types
          "storage.modifier" # modifiers (const, static)
          "storage" # storage keywords
          "support.class" # built-in classes
          "support.class.component" # framework components
          "entity.name.class" # class names
          "entity.other.inherited-class" # base classes
          "meta.type.cast.expr" # cast types
          "meta.type.new.expr" # new-expr types
          "meta.object-literal.key" # object keys
          "support.type.property-name.json" # json keys
          "support.type.property-name" # property names
          "meta.property-name" # css/less property names
          "meta.structure.dictionary.key.python" # python dict keys
          "constant.other.reference.link" # markdown links
          "string.other.link" # link targets
          "meta.diff.header" # diff header
          "meta.separator" # diff separator
          "meta.output" # diff output
        ];
        settings.foreground = palette.blue;
      }
      {
        scope = ["markup.heading" "markup.heading entity.name"];
        settings = {
          foreground = palette.blue;
          fontStyle = "bold";
        };
      }

      # -- orange (functions / strings / regexp bodies)
      {
        scope = [
          "meta.function" # function meta
          "entity.name.function" # function names
          "support.function" # built-in functions
          "entity.name.function.preprocessor" # preprocessor macros
          "storage.type.struct" # struct
          "storage.type.class" # class
          "string" # strings
          "string.quoted" # quoted strings
          "string.template" # template strings
          "string.interpolated" # interpolated strings
          "string.regexp" # regexp literals
          "source.regexp" # regexp source
          "constant.regexp" # regexp constants
          "markup.inline.raw" # inline code
        ];
        settings.foreground = palette.orange;
      }

      # -- aqua (namespaces / css selectors / quotes)
      {
        scope = [
          "entity.name.scope-resolution" # ::
          "entity.name.namespace" # namespaces
          "entity.other.attribute-name.pseudo-class.css" # :hover
          "entity.other.attribute-name.class.css" # .class
          "markup.quote" # blockquotes
        ];
        settings.foreground = palette.aqua;
      }

      # -- red (special operators / escapes / invalid / errors / deletions)
      {
        scope = [
          "keyword.operator.delete" # delete
          "keyword.operator.new" # new
          "storage.type.template" # templates / generics
          "entity.name.tag.wildcard.scss" # *
          "entity.name.tag.reference.scss" # references
          "meta.property-name.scss" # scss props
          "entity.name.tag.css" # css tags
          "source.css.scss" # scss root
          "constant.character.escape" # \n \t etc
          "string.regexp constant.character.escape" # regexp escapes
          "keyword.control.anchor.regexp" # ^ $ anchors
          "keyword.operator.or.regexp" # regexp alternation
          "invalid" # invalid
          "invalid.broken" # broken
          "invalid.deprecated" # deprecated
          "invalid.illegal" # illegal
          "invalid.unimplemented" # unimplemented
          "message.error" # error messages
          "brackethighlighter.unmatched" # unmatched brackets
          "markup.deleted" # removed lines
          "meta.diff.header.from-file" # diff from-file
        ];
        settings.foreground = palette.red;
      }

      # -- green (insertions)
      {
        scope = ["markup.inserted" "meta.diff.header.to-file"];
        settings.foreground = palette.green;
      }

      # -- yellow (changes)
      {
        scope = ["markup.changed" "punctuation.definition.changed"];
        settings.foreground = palette.yellow;
      }

      # -- log tokens (output / debug console)
      {
        scope = "token.info-token";
        settings.foreground = palette.blue;
      }
      {
        scope = "token.warn-token";
        settings.foreground = palette.yellow;
      }
      {
        scope = "token.error-token";
        settings.foreground = palette.red;
      }
      {
        scope = "token.debug-token";
        settings.foreground = palette.purple;
      }
    ];
  };
}
