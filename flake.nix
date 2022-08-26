{
  description = "slock - simple screen locker";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-22.05;

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.default =
      # Notice the reference to nixpkgs here.
      let
        pkgs = import nixpkgs { system = "x86_64-linux"; };
      in
        pkgs.stdenv.mkDerivation {
          name = "slock";
          src = self;
          buildPhase = "make";
          installPhase = "mkdir -p $out/bin; install -t $out/bin slock";

          nativeBuildInputs = with pkgs.xorg; [ xorgproto libX11 libXext libXrandr ];

        };

  };
}
