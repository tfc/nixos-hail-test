{ config, pkgs, ... }:

{
  imports = [ <nixpkgs/nixos/modules/installer/virtualbox-demo.nix> ];
  documentation.nixos.enable = false;

  networking.firewall.allowedTCPPorts = [ 22 2222 ];

  programs.command-not-found.enable = false;

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  services.openssh = {
    enable = true;
    ports = [ 22 2222 ];
    openFirewall = true;
  };

  services.hail = {
    enable = true;
    hydraJobUri = https://hydra.kosmosgame.com/job/github/nixos-hail-test/activator;
    package = pkgs.haskellPackages.hail.overrideAttrs (old: {
      patches = [ ./hail.patch ];
      meta.broken = false;
    });
  };

  system.stateVersion = "19.03";

  users.extraUsers = {
    demo = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      initialPassword = "foobar";
    };

    demo2 = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      initialPassword = "foobar";
    };
  };
}
