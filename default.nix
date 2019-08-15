{
  nixpkgs ? <nixpkgs>,
  nixos ? <nixpkgs/nixos>,
  pkgs ? import nixpkgs {}
}:

rec {
  config = import nixos { configuration = ./configuration.nix; };
  activator = pkgs.writeScriptBin "activate" ''
      exec -a systemd-run ${pkgs.systemd}/bin/systemd-run \
        --description "Hail: Activate new configuration" \
        -E PATH=$PATH \
        -E LOCALE_ARCHIVE=$LOCALE_ARCHIVE \
        ${config.system}/bin/switch-to-configuration switch
    '';
}
