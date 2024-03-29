{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = { self, nixpkgs, poetry2nix }:
    with import nixpkgs { system = "x86_64-linux"; };
    let pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      devShell.x86_64-linux = pkgs.mkShell {
        buildInputs = [ pkgs.python310 pkgs.python310Packages.poetry ];
        shellHook = ''
          LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [stdenv.cc.cc]}
        '';
      };
      formatter.x86_64-linux = pkgs.nixpkgs-fmt;
    };
}
