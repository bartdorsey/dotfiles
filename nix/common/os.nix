{pkgs, ...}: {
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;

  networking.search = [
    "home"
    "heronshaven.online"
    "tail7974e.ts.net"
  ];

  # Fixes Windows and Linux clock problems
  time.hardwareClockInLocalTime = true;

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

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };

  programs.dconf.enable = true;

  virtualisation.docker.enable = true;

  # documentation.man.generateCaches = true;

  services.tailscale.enable = false;

  security.pam.services.sshd.allowNullPassword = true;
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = true;
      PermitEmptyPasswords = "yes";
    };
  };
}
