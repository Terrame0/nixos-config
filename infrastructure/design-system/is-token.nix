{
  sundry,
  lib,
  ...
}: path: attrs:
attrs ? to
&& attrs ? value
&& lib.all (sundry.not lib.isAttrs) (lib.attrValues attrs.to)
&& sundry.not lib.isAttrs attrs.value
