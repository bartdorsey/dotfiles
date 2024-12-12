# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  pkgs-unstable,
  userPackages,
  systemPackages,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  services.udev.extraRules = ''
    # Grant access to GoXLRMin device over USB
    SUBSYSTEM=="usb", ATTR{idVendor}=="1220", ATTR{idProduct}=="8fe4", MODE="0660", GROUP="audio"
  '';

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  security.polkit.enable = true;

  boot.plymouth = {
    enable = true;
    theme = "rings";
    themePackages = with pkgs; [
      (adi1090x-plymouth-themes.override {
        selected_themes = ["rings"];
      })
    ];
  };

  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;

  boot.kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "udev.log_priority=3"
  ];

  networking.hostName = "nzxt"; # Define your hostname.

  # Fixes Windows and Linux clock problems
  time.hardwareClockInLocalTime = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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

  # Enable i3

  services.xserver.enable = true;

  services.xserver = {
    displayManager.setupCommands = "${pkgs.xorg.xrandr}/bin/xrandr --output DP-0 --mode 2560x1440 --pos 0x0 --rotate left --output HDMI-0 --mode 1920x1080 --pos 1440x1952 --rotate normal --output DP-4 --primary --mode 2560x1440 --pos 1440x512 --rotate normal";

    desktopManager = {
      xterm.enable = false;
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs-unstable.i3-rounded;
      extraPackages = with pkgs-unstable; [
        dmenu #application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock #default i3 screen locker
        i3blocks #if you are planning on using i3blocks over i3status
        polybarFull
        feh
        lxappearance
        networkmanagerapplet
        goxlr-utility
        dunst
        picom
        maim
        dex
        xss-lock
      ];
    };
  };

  # # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
    enable = true;
  };
  #
  services.desktopManager.plasma6.enable = false;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  # sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.echo = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Bart Dorsey";
    extraGroups = ["networkmanager" "wheel" "docker" "audio"];
    packages =
      userPackages
      ++ (with pkgs-unstable; [
        zoom-us
        dust
        nh
        nix-output-monitor
        nvd
        _1password-gui
        _1password-cli
        firefox
        firefoxpwa
        firefox-devedition
      ])
      ++ (with pkgs; [
        vieb
        vivaldi
        libsForQt5.lightly
        libsForQt5.xdg-desktop-portal-kde
        chromium
        flameshot
        obs-studio
        discord
        slack
        google-chrome
        gnome-tweaks
        gnomeExtensions.dash-to-panel
        vscode
        wezterm
        kitty
        vesktop
        darktable
        rofi
        microsoft-edge
      ]);
  };
  users.groups.echo = {
    name = "echo";
    members = ["echo"];
    gid = 1000;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "nix-2.16.2"
  ];

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };

  # Vivaldi stuff
  nixpkgs.config = {
    vivaldi = {
      proprietaryCodecs = true;
      enableWideView = true;
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = systemPackages;

  environment.variables.WLR_NO_HARDWARE_CURSORS = "1";

  programs.dconf.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.zsh = {
    enable = true;
  };

  programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.ksshaskpass.out}/bin/ksshaskpass";

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.hyprland.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  virtualisation.docker.enable = true;

  documentation.man.generateCaches = true;

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;

  # Default applications
  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [
        "wezterm.desktop"
      ];
    };
  };

  xdg.mime.defaultApplications = {
    "inode/directory" = "yazi.desktop";
    "inode/mount-point" = "yazi.desktop";
  };
}
