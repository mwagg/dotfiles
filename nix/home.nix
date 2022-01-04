{ config, pkgs, ... }:
{
  home.username = "mike";
  home.homeDirectory = "/Users/mike";
  home.stateVersion = "22.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    rnix-lsp
    tldr
    nodePackages.typescript-language-server
  ];
}
