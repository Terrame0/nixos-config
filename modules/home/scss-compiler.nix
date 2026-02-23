{pkgs,...}:{
  config.scss-compiler = 
    {src-file}:
      let 
        name = builtins.basename src-file;
      in
      pkgs.runCommand 
        { buildInputs = with pkgs; [sassc]; }
        ''
          basename="${name}"
          sassc ${src-file} "${src-file}.css"
        '';

}