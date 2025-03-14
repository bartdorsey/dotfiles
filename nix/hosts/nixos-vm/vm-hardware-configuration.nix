# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{lib, ...}: {
  imports = [];

  boot.initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "ehci_pci" "ahci" "vmw_pvscsi" "sd_mod" "sr_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  services.udev.extraRules = ''
    # Grant access to GoXLRMin device over USB
    SUBSYSTEM=="usb", ATTR{idVendor}=="1220", ATTR{idProduct}=="8fe4", MODE="0660", GROUP="audio"
  '';

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/af6f9f3e-d501-4a0b-a4a3-519ec4260ad2";
    fsType = "ext4";
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/4fb3ab6c-cbd9-4042-996a-5662a956e1a2";}
  ];

  services.xserver.videoDrivers = ["vmware"];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.ens33.useDHCP = lib.mkDefault true;
  virtualisation.vmware.guest.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
