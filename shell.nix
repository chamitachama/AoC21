{ pkgs ? import <nixpkgs> {} }:
let
  integrationsDBApp = pkgs.poetry2nix.mkPoetryEnv {
    python = pkgs.python39;
    projectDir = /home/mcoll/capchase/code/integrations-db/.;
  };
in integrationsDBApp.env.overrideAttrs (oldAttrs: {
	buildInputs = [
		pkgs.python39
		pkgs.poetry
		pkgs.python39Packages.pytest
		pkgs.python39Packages.ipython
	];
})
