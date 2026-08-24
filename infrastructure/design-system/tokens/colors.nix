{
  types,
  tokens,
  ...
}:
with tokens.colors; {
  base = {
    black = types.color "#1d1f21ff";
    dark-gray = types.color "#282a2eff";
    dim-gray = types.color "#373b41ff";
    gray = types.color "#4d5057ff";
    light-gray = types.color "#969896ff";
    white = types.color "#c5c8c6ff";
    red = types.color "#d54e53ff";
    orange = types.color "#e78c45ff";
    yellow = types.color "#e7c547ff";
    green = types.color "#b9ca4aff";
    aqua = types.color "#70c0b1ff";
    blue = types.color "#7aa6daff";
    purple = types.color "#c397d8ff";
  };

  accent = {
    primary = base.blue;
    secondary = base.aqua;
    tertiary = base.purple;
  };

  status = {
    info = base.aqua;
    success = base.green;
    warning = base.yellow;
    alert = base.orange;
    critical = base.red;
  };

  surface = {
    canvas = base.black;
    panel = base.dark-gray;
    raised = base.dim-gray;
    accent = accent.primary;
  };

  foreground = {
    primary = base.white;
    secondary = base.light-gray;
    inverse = base.black;
    accent = accent.primary;
    link = accent.primary;
    critical = status.critical;
  };

  border = {
    default = base.dark-gray;
    strong = base.dim-gray;
    focus = accent.primary;
    critical = status.critical;
  };
}
