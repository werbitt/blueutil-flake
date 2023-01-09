{
  description = "blueutil a CLI for bluetooth on OSX";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
          inherit system;
      };
    in {
      defaultPackage = pkgs.stdenv.mkDerivation {
          name = "blueutil";
          src = pkgs.fetchgit {
            url = "https://github.com/toy/blueutil";
            rev = "v2.9.0";
            sha256 = "vnIIdhgf0wY0wkl2aWn3KaEpSvDOr0oBkNQC9I6mvZc=";
            fetchSubmodules = true;
          };
          nativeBuildInputs = [
            # pkgs.xcbuild
            pkgs.cmake
            pkgs.clang

          ];
          buildInputs = [
            # pkgs.darwin.apple_sdk.frameworks.AppKit
            # pkgs.darwin.apple_sdk.frameworks.CoreVideo
            # pkgs.darwin.apple_sdk.frameworks.Metal
            # pkgs.darwin.apple_sdk.frameworks.Security
            # pkgs.darwin.apple_sdk.frameworks.CoreFoundation
            # pkgs.darwin.apple_sdk.frameworks.CoreServices
            pkgs.darwin.apple_sdk.frameworks.Foundation
            # pkgs.darwin.apple_sdk.frameworks.IOBluetooth
            # pkgs.darwin.apple_sdk.frameworks.Carbon

          ];
          dontConfigure = true;
          buildPhase = "make";
          # installPhase = "make install";
        };
    }
  );
}
