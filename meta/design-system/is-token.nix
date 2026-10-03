{
  sundry,
  lib,
  ...
}: path: attrs:
attrs ? to
&& attrs ? native
&& attrs ? type
&& lib.isString attrs.type
&& lib.all (sundry.not lib.isAttrs) (lib.attrValues attrs.to)
