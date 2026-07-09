{settings, ...}: let
  inherit (settings) palette;
in {
  "editor.tokenColorCustomizations" = {
    textMateRules = [
      # -- light-gray
      {
        scope = [
          "punctuation" # punctuation
          "meta.property-list.scss" # scss property lists
          "punctuation.definition.entity.css" # css entity punctuation
          "meta.at-rule.include.scss" # scss include
          "keyword.operator" # operators
          "comment" # comments
        ];
        settings.foreground = palette.light-gray;
      }

      # -- white
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

      # -- purple
      {
        scope = [
          "keyword" # keywordsoptions
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
        ];
        settings.foreground = palette.purple;
      }

      # -- blue
      {
        scope = [
          "support.type.property-name.css" # css property names
          "entity.name.type" # types
          "storage.type" # type keywords
          "support.type" # built-in types
          "storage.modifier" # modifiers (const, static)
        ];
        settings.foreground = palette.blue;
      }

      # -- orange
      {
        scope = [
          "meta.function" # function meta
          "entity.name.function" # function names
          "support.function" # built-in functions
          "storage.type.struct" # struct
          "storage.type.class" # class
          "string" # strings
          "string.quoted" # quoted strings
          "string.template" # template strings
          "string.interpolated" # interpolated strings
        ];
        settings.foreground = palette.orange;
      }

      # -- aqua
      {
        scope = [
          "entity.name.scope-resolution" # ::
          "entity.name.namespace" # namespaces
          "entity.other.attribute-name.pseudo-class.css" # :hover
          "entity.other.attribute-name.class.css" # .class
        ];
        settings.foreground = palette.aqua;
      }

      # -- red
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
        ];
        settings.foreground = palette.red;
      }

      # -- light-gray (comments beyond the base rule)
      {
        scope = [
          "punctuation.definition.comment" # comment markers
          "string.comment" # embedded comments
        ];
        settings.foreground = palette.light-gray;
      }

      # -- purple (constants / language literals)
      {
        scope = [
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

      # -- blue (types / classes / storage)
      {
        scope = [
          "storage" # storage keywords
          "support.class" # built-in classes
          "support.class.component" # framework components
          "entity.name.class" # class names
          "entity.other.inherited-class" # base classes
          "meta.type.cast.expr" # cast types
          "meta.type.new.expr" # new-expr types
        ];
        settings.foreground = palette.blue;
      }

      # -- blue (keys / property names — closer to Dark Modern defaults)
      {
        scope = [
          "meta.object-literal.key" # object keys
          "support.type.property-name.json" # json keys
          "support.type.property-name" # property names
          "meta.property-name" # css/less property names
          "meta.structure.dictionary.key.python" # python dict keys
        ];
        settings.foreground = palette.blue;
      }

      # -- orange (functions / strings / regexp bodies)
      {
        scope = [
          "support.function" # built-in functions
          "entity.name.function.preprocessor" # preprocessor macros
          "string.regexp" # regexp literals
          "source.regexp" # regexp source
          "constant.regexp" # regexp constants
        ];
        settings.foreground = palette.orange;
      }

      # -- red (escapes / invalid / errors)
      {
        scope = [
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
        ];
        settings.foreground = palette.red;
      }

      # -- markdown
      {
        scope = ["markup.heading" "markup.heading entity.name"];
        settings = {
          foreground = palette.blue;
          fontStyle = "bold";
        };
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
      {
        scope = "markup.quote";
        settings.foreground = palette.aqua;
      }
      {
        scope = "markup.inline.raw";
        settings.foreground = palette.orange;
      }
      {
        scope = ["markup.inserted" "meta.diff.header.to-file"];
        settings.foreground = palette.green;
      }
      {
        scope = ["markup.deleted" "meta.diff.header.from-file"];
        settings.foreground = palette.red;
      }
      {
        scope = ["markup.changed" "punctuation.definition.changed"];
        settings.foreground = palette.yellow;
      }
      {
        scope = ["constant.other.reference.link" "string.other.link"];
        settings.foreground = palette.blue;
      }
      {
        scope = "meta.diff.range";
        settings = {
          foreground = palette.purple;
          fontStyle = "bold";
        };
      }
      {
        scope = ["meta.diff.header" "meta.separator" "meta.output"];
        settings.foreground = palette.blue;
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
