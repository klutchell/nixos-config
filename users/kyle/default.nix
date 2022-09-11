{ hmUsers, self, config, ... }:
{
  age.secrets.passwordfile-kyle = {
    file = "${self}/secrets/passwordfile-kyle.age";
  };

  # https://github.com/ryantm/agenix/blob/main/modules/age.nix
  age.secrets.balena-aws-config = {
    file = "${self}/secrets/balena-aws-config.age";
    path = "/home/kyle/.aws/config";
    owner = "kyle";
  };

  # https://nixos.org/manual/nixos/stable/index.html#sec-user-management
  users.users.kyle = {
    # passwordFile = config.age.secrets.passwordfile-kyle.path;
    hashedPassword = "$6$EYmGWgdTVpt.RB2o$/PCpdAUq2Cb9gX/5Jannu2Qhp1WUK.NRflqvWy9jtgJd4dJCp9sbyGUJjywrsyr/S4MlQQFz/kUYY/th3i420.";
    description = "kyle";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
      "syncthing"
    ];
  };

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  home-manager.users.kyle = hmArgs: {

    imports = [
      hmUsers.kyle
    ];

    programs.git = {

      userName = "Kyle Harding";
      userEmail = "kyle@balena.io";
      signing.signByDefault = true;
      signing.key = "FD3EB16D2161895A";

      extraConfig = {
        core = {
          editor = "nano";
        };
        color = {
          ui = true;
        };
        push = {
          default = "current";
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
    };
  };

  # https://nixos.wiki/wiki/Syncthing
  # https://search.nixos.org/options?channel=22.05&from=0&size=50&sort=relevance&type=packages&query=syncthing
  services.syncthing = {
    enable = true;
    user = "kyle";
    dataDir = "/home/kyle/Syncthing"; # Default folder for new synced folders
    configDir = "/home/kyle/.config/syncthing"; # Folder for Syncthing's settings and keys
    openDefaultPorts = true;
  };
}
