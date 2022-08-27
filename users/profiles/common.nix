{ config, pkgs, ... }:

{
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Enable bash as some applications expect it
  programs.bash.enable = true;
}
