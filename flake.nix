{
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  inputs.aws-nitro-enclaves-cli.url = "github:aws/aws-nitro-enclaves-cli/v1.3.4";

  inputs.aws-nitro-enclaves-cli.flake = false;

  outputs = inputs:
    inputs.flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = inputs.nixpkgs.legacyPackages.${system};
      in {
        packages = {
          nitro-cli = pkgs.rustPlatform.buildRustPackage {
            buildInputs = [pkgs.openssl];
            cargoHash = "sha256-BK0MnlWea1dmnGDJsW2QfOSO22/EqpSitrgXF5hfRa0=";
            doCheck = false;
            nativeBuildInputs = [pkgs.pkg-config];
            pname = "nitro-cli";
            src = inputs.aws-nitro-enclaves-cli;
            version = "dummy";
          };
          vsock-proxy = pkgs.rustPlatform.buildRustPackage {
            buildInputs = [pkgs.openssl];
            cargoBuildFlags = "-p vsock-proxy";
            cargoHash = "sha256-XwrfabKAknC+pe3CCgjh8yQ55++mMP+qGffzL40YpRY=";
            doCheck = false;
            nativeBuildInputs = [pkgs.pkg-config];
            pname = "vsock-proxy";
            src = inputs.aws-nitro-enclaves-cli;
            version = "dummy";
          };
        };
      }
    );
}
