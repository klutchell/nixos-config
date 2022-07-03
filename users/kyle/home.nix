{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "kyle";
  home.homeDirectory = "/home/kyle";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # https://nix-community.github.io/home-manager/options.html#opt-home.sessionPath
  # https://nixos.wiki/wiki/Node.js
  home.sessionPath = [ "$HOME/.local/bin" "$HOME/.npm-global/bin"];
  home.file = {
    ".npmrc".text = "prefix=/home/kyle/.npm-global";
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    hadolint
    shellcheck
    thefuck
    yadm
    jq
    yq
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck"];
      theme = "robbyrussell";
    };
    plugins = [
      {
        # will source zsh-autosuggestions.plugin.zsh
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.4.0";
          sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
        };
      }
      {
        name = "enhancd";
        file = "init.sh";
        src = pkgs.fetchFromGitHub {
          owner = "b4b4r07";
          repo = "enhancd";
          rev = "v2.2.1";
          sha256 = "0iqa9j09fwm6nj5rpip87x3hnvbbz9w9ajgm6wkrd5fls8fn8i5g";
        };
      }
    ];
  };

  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "Kyle Harding";
    userEmail = "kyle@balena.io";
    signing.signByDefault = true;
    signing.key = "FD3EB16D2161895A";
    aliases = {
      prettylog = "...";
    };
    extraConfig = {
      core = {
        editor = "nano";
      };
      color = {
        ui = true;
      };
      push = {
        default = "simple";
      };
      pull = {
        ff = "only";
        rebase = true;
      };
      init = {
        defaultBranch = "main";
      };
      sendemail = {
        from = "Kyle Harding <kyle@balena.io>";
        chainreplyto = false;
        smtpencryption = "tls";
        smtpserver = "smtp.gmail.com";
        smtpserverport = 587;
        smtpuser = "kyle@balena.io";
      };
    };
    ignores = [
      ".DS_Store"
      "*.pyc"
      "node_modules/"
    ];
  };

  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };

  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
    pinentryFlavor = "gtk2";
  };

}