{ hmUsers, ... }:
{
  # https://nixos.org/manual/nixos/stable/index.html#sec-user-management
  users.users.kyle = {
    hashedPassword = "$6$EYmGWgdTVpt.RB2o$/PCpdAUq2Cb9gX/5Jannu2Qhp1WUK.NRflqvWy9jtgJd4dJCp9sbyGUJjywrsyr/S4MlQQFz/kUYY/th3i420.";
    description = "kyle";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
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
    };
  };
}
