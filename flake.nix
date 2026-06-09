{
  description = "Terraform Cloud and GitHub Actions secrets integration — fetches Akeyless dynamic secrets via JWT auth and provisions them as GitHub Actions secrets";

  inputs = {
    nixpkgs.follows = "substrate/nixpkgs";
    substrate = {
      url = "github:pleme-io/substrate";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs:
    (import "${inputs.substrate}/lib/repo-flake.nix" {
      inherit (inputs) nixpkgs flake-utils;
    }) {
      self = inputs.self;
      language = "terraform";
      builder = "check";
      pname = "terraform-cloud-gha-secrets";
      description = "Terraform Cloud and GitHub Actions secrets integration — fetches Akeyless dynamic secrets via JWT auth and provisions them as GitHub Actions secrets";
    };
}
