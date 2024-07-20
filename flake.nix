{
  description = "Frink as a Nix Flake.";

  inputs = { utils.url = "github:numtide/flake-utils"; };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages."${system}";
        inherit (pkgs) dos2unix jre mkShell rlwrap stdenv;
        frink = stdenv.mkDerivation {
          name = "frink";
          buildInputs = [ dos2unix jre rlwrap ];
          buildPhase = ''
            dos2unix ./frink-cli.sh
            chmod +x ./frink-cli.sh
            substituteInPlace ./frink-cli.sh \
                --replace 'jar=/home/eliasen/prog/frinknew/jar/frink.jar' \
                          "jar=$out/bin/frink.jar" \
                --replace 'java=/etc/alternatives/java' "java=${jre}/bin/java" \
                --replace '/home/eliasen/prog/frink/jar' "$out" \
                --replace '/usr/bin/rlwrap' "${rlwrap}/bin/rlwrap"
          '';
          installPhase = ''
            mkdir -p $out/bin
            cp ./frink-cli.sh $out/bin/
            cp ./frink.jar $out/bin/
            cp ./unitnames.txt $out/bin/
            cp ./functionnames.txt $out/bin/
          '';
          src = ./.;
          passthru = { exePath = "/bin/frink-cli.sh"; };

          system = system;
        };

        frinkApp = utils.lib.mkApp { drv = frink; };
      in {
        # `nix build`
        packages.frink = frink;
        packages.default = frink;

        # `nix run`
        apps.frink = frinkApp;
        apps.default = frinkApp;

        # `nix develop`
        devShells.default =
          mkShell { nativeBuildInputs = with pkgs; [ jre rlwrap frink ]; };
      });
}
