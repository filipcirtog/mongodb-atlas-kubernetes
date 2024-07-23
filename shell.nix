{ pkgs ? import <nixpkgs> { } }:
let
  golangci-lint-private = pkgs.buildGoModule rec {
    pname = "golangci-lint";
    version = "1.54.0";

    src = pkgs.fetchFromGitHub {
      owner = "golangci";
      repo = "golangci-lint";
      rev = "v${version}";
      sha256 = "1d5jqm21jvb6lqx2aizv28fqdx747sa8i98hpkpgsdjjvn07jwsi";
    };

    vendorHash = "sha256-jUlK/A0HxBrIby2C0zYFtnxQX1bgKVyypI3QdH4u/rg=";

    subPackages = [ "cmd/golangci-lint" ];
  };
in
pkgs.mkShell {
  buildInputs = [
    golangci-lint-private
    pkgs.yq
    pkgs.jq
    pkgs.gettext
    pkgs.bashInteractive
    pkgs.go
    pkgs.kubectl
    pkgs.kubernetes-controller-tools
    pkgs.kustomize
    pkgs.git
    pkgs.envsubst
    pkgs.wget
    pkgs.cosign
    pkgs.govulncheck
    pkgs.gotools
    pkgs.go-licenses
  ];

  shellHook = ''
    export PATH=$PATH:${pkgs.go}/bin
    export PATH=$PATH:${pkgs.cosign}/bin
    export PATH=$PATH:${pkgs.go-licenses}/bin
    export PATH=$PATH:${pkgs.yq}/bin
    export PATH=$PATH:${pkgs.wget}/bin
    export PATH=$PATH:${pkgs.envsubst}/bin
    export PATH=$PATH:${pkgs.git}/bin
    export PATH=$PATH:${pkgs.jq}/bin
    export PATH=$PATH:${pkgs.gettext}/bin
    export PATH=$PATH:${pkgs.bashInteractive}/bin
    export PATH=$PATH:${pkgs.kubernetes-controller-tools}/bin
    export PATH=$PATH:${pkgs.kubectl}/bin
    export PATH=$PATH:${pkgs.kustomize}/bin
    export PATH=$PATH:${pkgs.govulncheck}/bin
    export PATH=$PATH:${pkgs.gotools}/bin
  '';
}
