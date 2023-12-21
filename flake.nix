{
  description = "A Swiss Army knife for your Ecto schemas";

  inputs = {
    nixpkgs.url = "flake:nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
  };

  outputs = {
    nixpkgs,
    systems,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import systems;
      perSystem = {
        self',
        pkgs,
        ...
      }: {
        devShells.default = with pkgs; let
          inherit (pkgs.beam.packages) erlangR24;
        in
          mkShell {
            packages =
              [erlangR24.elixir_1_12]
              ++ lib.optionals pkgs.stdenv.isDarwin [
                darwin.apple_sdk.frameworks.CoreFoundation
                darwin.apple_sdk.frameworks.CoreServices
              ];
          };
      };
    };
}
