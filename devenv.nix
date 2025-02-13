{ pkgs, lib, config, inputs, ... }:

{
  # https://devenv.sh/basics/
  env.GREET = "devenv";

  # https://devenv.sh/packages/
  packages = [
    pkgs.libyaml
    pkgs.openssl
  ];

  # https://devenv.sh/languages/
  languages.ruby.enable = true;
  languages.ruby.version = "3.4";

  # https://devenv.sh/processes/
  # processes.cargo-watch.exec = "cargo-watch";

  # https://devenv.sh/services/
  services.mysql.enable = true;
  services.mysql.settings = {
    mysqld = {
      ssl_ca = "/Users/paulo.casaretto/src/github.com/pcasaretto/ssl-connection-timeout-repro/ca.pem";
      ssl_cert = "/Users/paulo.casaretto/src/github.com/pcasaretto/ssl-connection-timeout-repro/server-cert.pem";
      ssl_key = "/Users/paulo.casaretto/src/github.com/pcasaretto/ssl-connection-timeout-repro/server-key.pem";
      require_secure_transport = "ON";
      connect_timeout = 100;
    };
  };

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo hello from $GREET
  '';

  enterShell = ''
    hello
    git --version
  '';

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  # https://devenv.sh/pre-commit-hooks/
  # pre-commit.hooks.shellcheck.enable = true;

  # See full reference at https://devenv.sh/reference/options/
}
