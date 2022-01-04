{ config, pkgs, ... }:
{
  home.username = "spin";
  home.homeDirectory = "/home/spin";
  home.stateVersion = "22.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    rnix-lsp
    tldr
    neovim
  ];
}
