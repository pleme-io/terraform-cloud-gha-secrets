{
  description = "Terraform Cloud and GitHub Actions secrets integration — fetches Akeyless dynamic secrets via JWT auth and provisions them as GitHub Actions secrets";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    substrate = {
      url = "github:pleme-io/substrate";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, substrate, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs { inherit system; };
      mkTerraformModuleCheck = (import "${substrate}/lib/terraform-module.nix").mkTerraformModuleCheck;
    in {
      checks.default = mkTerraformModuleCheck pkgs {
        pname = "terraform-cloud-gha-secrets";
        version = "0.0.0-dev";
        src = self;
        description = "Terraform Cloud and GitHub Actions secrets integration — fetches Akeyless dynamic secrets via JWT auth and provisions them as GitHub Actions secrets";
        homepage = "https://github.com/pleme-io/terraform-cloud-gha-secrets";
      };

      devShells.default = pkgs.mkShellNoCC {
        packages = with pkgs; [
          opentofu
          tflint
          terraform-docs
        ];
      };
    });
}
