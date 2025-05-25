{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    devshell.url = "github:numtide/devshell";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = with inputs; [
            devshell.overlays.default
          ];
        };
        lib = pkgs.lib;
      in
      {
        devShells.default = pkgs.devshell.mkShell {
          devshell = {
            name = "Galaxy Policies";
            startup = {
              install-uv-dependencies.text = "uv sync --all-groups --locked";
              source-venv = {
                text = "source .venv/bin/activate";
                deps = [ "install-uv-dependencies" ];
              };
              ensure-data-dir-exists.text = ''mkdir -p "$PRJ_DATA_DIR"'';
              init-pre-commit = {
                text = ''
                  flag_file="$PRJ_DATA_DIR/.pre-commit-enabled"

                  if [ ! -f "$flag_file" ]; then
                    echo "It looks like you haven't configured pre-commit hooks yet."
                    read -r -p "Do you want to install them now? (y/n): " response
                    case "$response" in
                      [yY][eE][sS]|[yY])
                        echo "true" > "$flag_file"
                        pre-commit install --install-hooks
                        ;;
                      *)
                        echo "false" > "$flag_file"
                        echo "Skipping pre-commit hook installation."
                        ;;
                      esac
                  else
                    if ${lib.getExe' pkgs.gnugrep "grep"} -q '^true$' "$flag_file"; then
                      pre-commit install --install-hooks
                    else
                      echo "Skipping pre-commit hook installation."
                    fi
                  fi
                '';
                deps = [
                  "source-venv"
                  "ensure-data-dir-exists"
                ];
              };
            };
          };

          commands = with pkgs; [
            { package = uv; }
            {
              name = "mkdocs";
              command = ''mkdocs "$@"'';
              help = "Project documentation with Markdown / static website generator";
            }
            {
              package = act;
            }
            {
              name = "reset-pre-commit-flag";
              command = ''rm -v "$PRJ_DATA_DIR/.pre-commit-enabled" && pre-commit uninstall && direnv reload'';
              help = "Reset the flag for pre-commit installation.";
              category = "scripts";
            }
          ];

          packages = with pkgs; [
            stdenv.cc.cc
            python3
            # Material for MkDocs dependencies
            cairo
            pngquant
          ];

          env = [
            {
              name = "CPPFLAGS";
              eval = "-I$DEVSHELL_DIR/include";
            }
            {
              name = "LDFLAGS";
              eval = "-L$DEVSHELL_DIR/lib";
            }
            {
              name = "LD_LIBRARY_PATH";
              eval = "$DEVSHELL_DIR/lib:$LD_LIBRARY_PATH";
            }
            {
              name = "UV_PYTHON_PREFERENCE";
              value = "only-system";
            }
            {
              name = "UV_PYTHON_DOWNLOADS";
              value = "never";
            }
          ];

          motd = ''
            {33}🔨 Welcome to the {208}Galaxy Policies{33} Devshell!{reset}
            $(type -p menu &>/dev/null && menu)
          '';
        };
      }
    );
}
