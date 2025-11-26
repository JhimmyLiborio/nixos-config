{ config, pkgs, ... }:

let
  gpakTmux = pkgs.fetchFromGitHub {
    owner = "gpakosz";
    repo = ".tmux";
    #rev = "824671603d6d03f0f7193b2a373e215f9b49b386";
    rev = "master";
    sha256 = "sha256-sHW0tU5zU5gEu6oX+ERCcZ7rxAgRp3PmMe9gvEHzlcE=";    
  };
in
{
  home.stateVersion = "25.05";

  #-----------------------------
  # Programas
  #-----------------------------
  programs.home-manager.enable = true;
  #-----------------------------
  # Tmux gpakosz
  #----------------------------
  programs.tmux = {
    enable = true;
    clock24 = true;
    mouse = true;
    terminal = "screen-256color";
  };
  
  home.file.".tmux".source = gpakTmux;

  # faz um link do arquivo tmux.conf no home
  home.file.".tmux.conf".source = "${gpakTmux}/.tmux.conf";
  
  # personalização no arquivo conf.local
  home.file.".tmux.conf.local".text = ''
    set -g mouse on
    set -g status-interval 1
  '';

  #home.packages = with pkgs; [
  #  anki
  #];

  
  #---------------------------
  # Git
  #--------------------------
  programs.git = {
    enable = true;
    userName = "Joel Jhimmy Ramos Libório";
    userEmail = "joeljhimmy@ufam.edu.br";

    aliases = {
      st = "status";
      co = "checkout";
      br = "branch";
      cm = "commit -m";
      lg = "log --graph --decorate --all --oneline";
    };

    extraConfig = {
      init.defaultBranch = "main";
      color.ui = "auto";
      pull.rebase = true;
      push.default = "current";
      core.editor = "nvim";
      core.autocrlf = "input";
    };

    ignores = [
      ".env"
      ".DS_Store"
      "node_modules"
    ];
  };
}

