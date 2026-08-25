{
  tokens,
  lib,
  sundry,
  is-token,
  ...
}:
lib.pipe tokens [
  (sundry.attrs.reform-until is-token (path: token: {
    path = [(sundry.str.join-with "-" path)];
    value = token.to.scss;
  }))
  (sundry.attrs.collapse
    (path: value: "\$${sundry.str.join path}: ${value};"))
  (sundry.str.join-with "\n")
  (sundry.vfs.file.from-text ["partial{include:sass}.scss"])
]
