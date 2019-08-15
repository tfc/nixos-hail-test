{
  nixpkgs ? <nixpkgs>,
  pkgs ? import nixpkgs {}
}:

rec {
  config = (pkgs.nixos ./configuration.nix).toplevel;
  activator = pkgs.writeScriptBin "activate" ''
      exec -a systemd-run ${pkgs.systemd}/bin/systemd-run \
        --description "Hail: Activate new configuration" \
        ${config}/bin/switch-to-configuration switch
    '';
}
