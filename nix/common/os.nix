{pkgs, ...}: {
  system.autoUpgrade.allowReboot = false;

  networking.search = [
    "home"
    "heronshaven.online"
    "tail7974e.ts.net"
  ];

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

  programs.neovim = {
    enable = true;
    vimAlias = true;
  };

  programs.starship = {
    enable = true;
    presets = ["plain-text-symbols"];
  };

  services.mpd = {
    enable = true;
    user = "echo";
    musicDirectory = "/mnt/Music/iTunes Old/iTunes Music/Music/";
    extraConfig = ''
      audio_output {
          type "pipewire"
          name "Pipewire Output" # this can be whatever you want
      }
    '';
  };
  systemd.services.mpd.environment = {
    XDG_RUNTIME_DIR = "/run/user/1000";
  };

  virtualisation.docker.enable = true;

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
