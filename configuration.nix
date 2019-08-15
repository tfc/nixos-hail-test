{ config, pkgs, ... }:

{
  imports = [ <nixpkgs/nixos/modules/installer/virtualbox-demo.nix> ];
  documentation.nixos.enable = false;

  programs.command-not-found.enable = false;

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  services.openssh = {
    enable = true;
    ports = [ 22 2222 ];
    openFirewall = true;
  }

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
