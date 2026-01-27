(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.${builtins.head (builtins.attrNames (builtins.getFlake (builtins.toString ./.)).nixosConfigurations)}.options
(builtins.getFlake (builtins.toString ./.)).homeConfigurations.${builtins.head (builtins.attrNames (builtins.getFlake (builtins.toString ./.)).homeConfigurations)}.options
