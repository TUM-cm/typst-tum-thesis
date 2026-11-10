{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

  outputs =
    { nixpkgs, ... }:
    {
      packages = builtins.mapAttrs (system: pkgs: {
        default = pkgs.stdenvNoCC.mkDerivation {
          name = "thesis";
          src = pkgs.lib.cleanSource ./.;
          nativeBuildInputs = [ pkgs.typst ];
          env.TYPST_FONT_PATHS = pkgs.newcomputermodern;
          installPhase = ''
            install -Dm644 thesis.pdf $out/thesis.pdf
          '';
        };
      }) nixpkgs.legacyPackages;
    };
}
