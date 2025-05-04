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
      device = "/dev/sda";
    };
  };

  networking = {
    hostname = "media.home";
    interfaces = {
      eth0.ipv4.addresses = [
        {
          address = "10.0.0.200";
          prefixLength = 24;
        }
      ];
    };
    defaultGateway = {
      address = "10.0.0.1";
      interface = "eth0";
    };
    nameservers = ["10.0.0.3" "10.0.0.4"];
  };

  time.timeZone = "US/Central";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "us";
  };

  time.hardwareClockInLocalTime = true;
  security.polkit.enable = true;

  system.stateVersion = "24.11"; # Did you read the comment?

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;
}
