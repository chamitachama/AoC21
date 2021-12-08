{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell({
	buildInputs = [
		pkgs.python39
		pkgs.poetry
		pkgs.python39Packages.pytest
		pkgs.python39Packages.ipython
	];
})
