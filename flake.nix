{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    tinyshell.url = "git+https://tangled.org/csw.im/tinyshell";
    nixhooks = {
      url = "git+https://tangled.org/poacher.dev/nixhooks";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    systems,
    tinyshell,
    nixhooks,
    ...
  }: let
    eachSystem = f:
      nixpkgs.lib.genAttrs (import systems) (
        system: let
          pkgs = import nixpkgs {inherit system;};
        in
          f system pkgs pkgs.lib
      );
  in
    nixhooks.lib.withHooks {
      hooks = eachSystem (system: pkgs: lib: let
        inherit (nixhooks.lib.${system}) presets;
      in {
        inherit (presets) alejandra typos;
        markdownlint-cli2 = {
          entry = lib.getExe pkgs.markdownlint-cli2;
          files = "\\.md$";
          serial = false;
        };
      });

      devShells = eachSystem (
        _: pkgs: _: {
          default = (tinyshell.lib pkgs).mkTinyShell {
            packages = with pkgs; [
              # keep-sorted start
              act
              alejandra
              markdownlint-cli2
              python3
              typos
              uv
              # keep-sorted end
            ];

            setDataDir = false;

            UV_PYTHON_PREFERENCE = "only-system";
            UV_PYTHON_DOWNLOADS = "never";

            shellHook = ''
              uv sync --locked
              source .venv/bin/activate
            '';
          };
        }
      );
    };
}
