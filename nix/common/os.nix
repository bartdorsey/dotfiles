{pkgs, ...}: {
  system.autoUpgrade.allowReboot = false;

  networking.search = [
    "home"
    "heronshaven.online"
    "tail7974e.ts.net"
  ];

  # Enable udisks2 service (required for mounting)
  services.udisks2.enable = true;

  users.groups.storage = {};

  # Allow users in storage group to mount internal drives
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if ((action.id == "org.freedesktop.udisks2.filesystem-mount-system" ||
           action.id == "org.freedesktop.udisks2.filesystem-mount") &&
          subject.isInGroup("storage")) {
        return polkit.Result.YES;
      }
    });
  '';

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # allow unfree packages
  nixpkgs.config.allowunfree = true;

  # ZSH
  programs.zsh = {
    enable = true;
    histFile = "$XDG_STATE_HOME/zsh/history";
    shellInit = ''
      ZDOTDIR=$HOME/.config/zsh
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld;
  };

  programs.dconf.enable = true;

  programs.neovim = {
    enable = true;
  };

  programs.starship = {
    enable = true;
    presets = ["plain-text-symbols"];
  };

  virtualisation.docker = {
    autoPrune.enable = true;
    enable = true;
  };

  services.tailscale.enable = false;

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PermitRootLogin = "no";
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitEmptyPasswords = "no";
    };
  };

  # Setup XDG vars by default
  environment.sessionVariables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    XDG_CACHE_HOME = "$HOME/.cache";
  };

  nix.settings.trusted-users = [
    "@wheel"
  ];

  services.udev.packages = [pkgs.yubikey-personalization];

  security.pam = {
    u2f = {
      enable = true;
      settings.cue = true;
    };
    services = {
      login.u2fAuth = true;
      sudo.u2fAuth = true;
    };
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };
}
