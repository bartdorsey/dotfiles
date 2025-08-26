# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{...}: {
  imports = [
    # Include the results of the hardware scan
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader = {
    grub = {
      enable = true;
      useOSProber = true;
      efiSupport = true;
      device = "nodev";
      gfxmodeEfi = "1920x1080";
      gfxmodeBios = "1920x1080";
      default = "saved";
      # extraEntries = ''
      #   menuentry "Bazzite" {
      #       search --set=root --fs-uuid 01BE-9670
      #       chainloader /EFI/fedora/grubx64.efi
      #   }
      # '';
    };
    efi = {
      efiSysMountPoint = "/boot/efi";
      canTouchEfiVariables = true;
    };
  };

  security.polkit.enable = true;

  boot.kernelParams = [
    "video=1920x1080"
    "splash"
    "boot.shell_on_fail"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "udev.log_priority=3"
  ];

  networking.hostName = "nzxt"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "nix-2.16.2"
  ];

  # environment.variables.WLR_NO_HARDWARE_CURSORS = "1";
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.streamdeck-ui = {
    enable = true;
    autoStart = true; # optional
  };

  services.mpd = {
    enable = true;
    user = "echo";
    musicDirectory = "/mnt/Music/";
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

  services.goxlr-utility = {
    enable = true;
    autoStart.xdg = true;
  };
  # List services that you want to enable:

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

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;
}
