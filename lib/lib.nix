{...}: let
  overlay = final: prev: {
    lib = prev.lib // {
      palette = {
        background =  "#1d1f21";
        line =        "#282a2e";
        selection =   "#373b41";
        window =      "#4d5057";
        comment =     "#969896";
        foreground =  "#c5c8c6";
        red =         "#d54e53";
        orange =      "#e78c45";
        yellow =      "#e7c547";
        green =       "#b9ca4a";
        aqua =        "#70c0b1";
        blue =        "#7aa6da";
        purple =      "#c397d8";
      };
    };
  };
in {
  nixpkgs.overlays = [overlay];
}
