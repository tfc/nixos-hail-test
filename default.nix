{
  nixpkgs ? <nixpkgs>,
  pkgs ? import nixpkgs {}
}:

rec {
  config = pkgs.nixos ./configuration.nix;
  activator = pkgs.writeScriptBin "activate" ''
      exec -a systemd-run ${pkgs.systemd}/bin/systemd-run \
        --description "Hail: Activate new configuration" \
        -E PATH=$PATH \
        -E LOCALE_ARCHIVE=$LOCALE_ARCHIVE \
        ${config.toplevel}/bin/switch-to-configuration switch
    '';
}
