{pkgs, ...}: {
  # Bootloader.
  boot = {
    loader = {
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
      initrd = {
        enable = true;
        verbose = false;
      };
      efi = {
        efiSysMountPoint = "/boot/efi";
        canTouchEfiVariables = true;
      };
    };
    plymouth = {
      enable = true;
      font = "${pkgs.jetbrains-mono}/share/fonts/truetype/JetBrainsMono-Regular.ttf";
      themePackages = [pkgs.catppuccin-plymouth];
      theme = "catppuccin-macchiato";
    };

    kernelParams = [
      "video=1920x1080"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "udev.log_priority=3"
    ];
  };
}
