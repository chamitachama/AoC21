{ pkgs ? import <nixpkgs> {} }:
let
  integrationsDBApp = pkgs.poetry2nix.mkPoetryEnv {
    python = pkgs.python39;
    projectDir = /home/mcoll/capchase/code/integrations-db/.;
    editablePackageSources = {
      integrations-db = /home/mcoll/capchase/code/integrations-db/.;
    };

    overrides = pkgs.poetry2nix.overrides.withDefaults (self: super: {
	typing-extensions = super.typing-extensions.overridePythonAttrs (
		old: {
			buildInputs = (old.buildInputs or [ ]) ++ [ self.flit-core ];
		}
	);

	ddtrace = super.ddtrace.overridePythonAttrs (
		old: {
			buildInputs = (old.buildInputs or [ ]) ++ [ self.setuptools-scm ];
			postPatch = ''
				substituteInPlace setup.py --replace 'setuptools_scm[toml]>=4,<6.1' 'setuptools-scm'
				substituteInPlace pyproject.toml --replace 'setuptools_scm[toml] >=4,<6.1' 'setuptools-scm'
			'';
		}
	);
    });
  };
in integrationsDBApp.env.overrideAttrs (oldAttrs: {
	buildInputs = [
		pkgs.python39
		pkgs.poetry
		pkgs.python39Packages.pytest
		pkgs.python39Packages.ipython
	];
})
