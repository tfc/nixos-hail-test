{
  nixpkgs ? <nixpkgs>,
  nixos ? <nixpkgs/nixos>,
  pkgs ? import nixpkgs {}
}:

let
  configBuilder = import nixos;
  config = configBuilder { configuration = ./configuration.nix; };
in
  pkgs.writeScriptBin "activate" ''
    exec -a systemd-run ${pkgs.systemd}/bin/systemd-run \
      --description "Hail: Activate new configuration" \
      -E PATH=$PATH \
      -E LOCALE_ARCHIVE=$LOCALE_ARCHIVE \
      ${config.system}/bin/switch-to-configuration switch
  ''
