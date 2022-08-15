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

  # Determines whether to check for release version mismatch between Home Manager
  # and Nixpkgs. Using mismatched versions is likely to cause errors and unexpected
  # behavior. It is therefore highly recommended to use a release of Home Manager
  # than corresponds with your chosen release of Nixpkgs.
  home.enableNixpkgsReleaseCheck = true;

  home.sessionVariables = {
    EDITOR = "nano";
    TERMINAL = "elementary-terminal";
    TERM = "xterm-256color";
  };

  home.file.".npmrc" = {
    text = "prefix=${config.home.homeDirectory}/.npm-global";
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    hadolint
    shellcheck
    thefuck
    yadm
    jq
    yq-go
    htop
    brave
    vscode
    logseq
    signal-desktop
    balena-cli
    awscli2
    saml2aws
    aws-google-auth
    k9s
    kubectl
    binutils
    gnutls
    gnumake
    gcc
    xdg-utils
    unzip
    wget
    curl
    bind
    mkpasswd
    spotify
    zoom-us
    home-manager
    openssl
    pinentry-gtk2
    docker-compose
    neofetch
    vlc
  ];

  # This option should only be used to manage simple aliases that are compatible
  # across all shells. If you need to use a shell specific feature then make sure
  # to use a shell specific option, for example programs.bash.shellAliases for Bash.
  home.shellAliases = {
    ll = "ls -l";
    update = "sudo nixos-rebuild switch";
    # ".." = "cd ..";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Enable bash as some applications expect it
  programs.bash.enable = true;

  programs.zsh = {
    enable = true;

    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    autocd = true;

    initExtra = ''

      balena-production () {
        balena-login balena-production arn:aws:iam::491725000532:role/federated-admin
        aws --profile balena-production eks --region us-east-1 update-kubeconfig --name production-eks --alias production-eks
      }

      balena-staging () {
        balena-login balena-staging arn:aws:iam::567579488761:role/federated-admin
        aws --profile balena-staging eks --region us-east-1 update-kubeconfig --name staging-eks --alias staging-eks
      }

      balena-playground () {
        balena-login balena-playground arn:aws:iam::240706700173:role/federated-admin
        aws --profile balena-playground eks --region us-east-1 update-kubeconfig --name playground-eks --alias playground-eks
      }

      balena-login () {
        unset AWS_PROFILE
        #docker run --rm -it -v $(readlink -f $HOME/.aws/config):/root/.aws/config:ro cevoaustralia/aws-google-auth -p $1 -r $2
        aws-google-auth -p $1 -r $2
        export AWS_PROFILE="$1" 
      }
    
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck"];
      theme = "robbyrussell";
    };
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
        autoSetupRemote = true;
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

  # https://github.com/nix-community/home-manager/blob/master/modules/services/syncthing.nix
  # doesn't work ???
  # services.syncthing = {
  #   enable = true;
  # };

}
