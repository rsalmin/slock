{
  description = "slock - simple screen locker";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-22.05;

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.slock =
      # Notice the reference to nixpkgs here.
      let
        pkgs = import nixpkgs { system = "x86_64-linux"; };
      in
        pkgs.stdenv.mkDerivation {
          pname = "slock";
          version = "1.4";
          src = self;
          buildPhase = "make";
          installPhase = "mkdir -p $out/bin; install -t $out/bin slock";

          nativeBuildInputs = with pkgs.xorg; [ xorgproto libX11 libXext libXrandr ];

        };

    packages.x86_64-linux.default = self.packages.x86_64-linux.slock;

    apps.x86_64-linux.default = {
      type = "app";
      program = "${self.packages.x86_64-linux.default}/bin/slock";
    };

  };
}
