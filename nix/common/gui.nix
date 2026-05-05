{
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}: {
  # programs.uwsm = {
  #   enable = true;
  # };

  programs.streamcontroller.enable = true;

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  services.flatpak.enable = true;

  systemd.services.flatpak-repo = {
    wantedBy = ["multi-user.target"];
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  services.autorandr.enable = true;

  programs.zoom-us = {
    enable = false;
    package = pkgs-unstable.zoom-us;
  };

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  programs.kdeconnect.enable = true;

  # environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.xserver.upscaleDefaultCursor = true;

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };

  programs.chromium = {
    enable = true;
    initialPrefs = {
      "profile" = {
        "name" = "Personal";
      };
      "distribution" = {
        "skip_first_run_ui" = true;
        "import_bookmarks" = false;
        "import_history" = false;
        "import_home_page" = false;
        "import_search_engine" = false;
        "show_welcome_page" = false;
      };
    };

    # Enterprise policy settings (locked, can't be overridden)
    extraOpts = {
      "BlockThirdPartyCookies" = true;
      "DefaultNotificationsSetting" = 2;
      "DefaultGeolocationSetting" = 2;
      "DefaultCamerasSetting" = 2;
      "DefaultMicrophoneSetting" = 2;
      "DnsOverHttpsMode" = "automatic";
      "DnsOverHttpsTemplates" = "https://10.0.0.5/dns-query";
      "SyncDisabled" = true;
      "MetricsReportingEnabled" = false;
      "SafeBrowsingEnabled" = true;
      "HttpsOnlyMode" = "force_enabled";
      "SearchSuggestEnabled" = false;
      "UrlKeyedAnonymizedDataCollectionEnabled" = false;
      "SpellCheckServiceEnabled" = false;
      "AutofillAddressEnabled" = false;
      "AutofillCreditCardEnabled" = false;
      "PasswordManagerEnabled" = false;
      "ExtensionManifestV2Availability" = 2;
      "WebAppInstallForceList" = [
        {
          "url" = "https://www.youtube.com";
          "custom_name" = "YouTube";
          "default_launch_container" = "window";
          "create_desktop_shortcut" = true;
        }
      ];
    };
  };

  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        zen
      '';
      mode = "0755";
    };
  };

  programs._1password = {
    enable = true;
  };
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = ["echo"];
  };

  environment.systemPackages =
    [inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default]
    ++ (with pkgs-unstable; [
      davinci-resolve
      firefoxpwa
      zed-editor-fhs
      rustdesk-flutter
      prismlauncher
    ])
    ++ (with pkgs; [
      appimage-run
      bambu-studio
      cava
      (chromium.override
        {
          commandLineArgs = [
            "--disable-sync"
            "--no-default-browser-check"
            "--no-first-run"
            "--disable-breakpad"
          ];
        })
      cliphist
      clipman
      darktable
      desktop-file-utils
      dex
      discord
      dmenu #application launcher most people use
      dunst
      feh
      flameshot
      fontpreview
      ghostty
      gimp
      gnome-tweaks
      gparted
      grim
      grimblast
      gruvbox-dark-icons-gtk
      gruvbox-plus-icons
      hunspell
      hunspellDicts.th_TH
      hunspellDicts.uk_UA
      inkscape
      insomnia
      libnotify
      libreoffice-qt
      lora
      maim
      mpv
      neovide
      networkmanagerapplet
      nh
      nix-output-monitor
      nvd
      nwg-displays
      obs-studio
      obsidian
      onlyoffice-desktopeditors
      openscad
      orca-slicer
      pavucontrol
      plattenalbum
      playerctl
      plexamp
      podman-desktop
      qutebrowser
      rofi
      signal-desktop
      slack
      slurp
      syncthingtray
      telegram-desktop
      terminus_font_ttf
      thonny
      thunderbird
      v4l-utils
      vesktop
      vice
      # vivaldi
      vlc
      wayland-utils # Wayland utilities
      wl-clipboard # Command-line copy/paste utilities for Wayland
      wofi
      wttrbar
      wtype
      xorg.xhost
      xss-lock
    ])
    ++ (with pkgs.kdePackages; [
      calligra
    ]);

  # services.udev.packages = with pkgs; [
  #   gnome-settings-daemon
  #   gnome2.GConf
  # ];

  # Vivaldi stuff
  # nixpkgs.config = {
  #   vivaldi = {
  #     proprietaryCodecs = true;
  #     enableWideView = true;
  #   };
  # };

  programs.ssh = {
    askPassword = pkgs.lib.mkForce "${pkgs.kdePackages.ksshaskpass.out}/bin/ksshaskpass";
  };

  # https://github.com/mikeldev0/macos-font-rendering/tree/master
  environment.sessionVariables = {
    FREETYPE_PROPERTIES = "autofitter:no-stem-darkening=0 autofitter:darkening-parameters=500,0,1000,500,2500,500,4000,0 cff:no-stem-darkening=0 type1:no-stem-darkening=0 t1cid:no-stem-darkening=0";
    QT_NO_SYNTHESIZED_BOLD = 1;
  };

  fonts = {
    fontconfig = {
      antialias = true;
      hinting = {
        enable = true;
        autohint = false;
        style = "slight";
      };
      subpixel = {
        rgba = "none";
        lcdfilter = "default";
      };
      defaultFonts = {
        serif = ["Noto Serif"];
        sansSerif = ["DejaVu Sans"];
        monospace = ["DejaVu Sans Mono"];
      };
      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
        <fontconfig>
          <match target="font">
            <test name="pixelsize" compare="less">
              <double>14.0</double>
            </test>
           <edit name="embolden" mode="assign">
             <bool>true</bool>
           </edit>
         </match>
         <match target="font">
           <edit name="weight" mode="assign">
             <const>medium</const>
           </edit>
         </match>
         <match target="pattern">
           <edit name="dpi" mode="assign">
           <double>163</double>
           </edit>
         </match>
        </fontconfig>
      '';
    };
    enableDefaultPackages = true;
    packages = with pkgs; [
      liberation_ttf
      ubuntu-classic
      corefonts
      vista-fonts
      nerd-fonts.iosevka
      nerd-fonts.symbols-only
      inter
      adwaita-fonts
    ];
  };

  programs.firefox = {
    enable = true;
    package = pkgs-unstable.firefox-bin;
    nativeMessagingHosts.packages = [pkgs-unstable.firefoxpwa];
  };

  # Thunar
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
  programs.xfconf.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  # services.dbus.packages = with pkgs; [
  #   xfce.xfconf
  # ];

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = ["graphical-session.target"];
    wants = ["graphical-session.target"];
    after = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  nix.settings = {
    substituters = ["https://wezterm.cachix.org"];
    trusted-public-keys = ["wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="];
  };
}
