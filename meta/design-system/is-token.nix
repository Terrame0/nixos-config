{
  sundry,
  lib,
  ...
}: path: attrs:
attrs ? to
&& lib.isAttrs attrs.to
&& lib.all lib.isString (lib.attrValues attrs.to)
&& attrs ? native
&& attrs ? type
&& lib.isString attrs.type
