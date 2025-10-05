{pkgs, ...}: {
  # console font
  console.font = "Lat2-Terminus16";

  # Bootloader.
  boot = {
    consoleLogLevel = 3;
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
      efi = {
        efiSysMountPoint = "/boot/efi";
        canTouchEfiVariables = true;
      };
    };
    initrd = {
      enable = true;
      verbose = false;
    };
    plymouth = {
      enable = true;
      font = "${pkgs.jetbrains-mono}/share/fonts/truetype/JetBrainsMono-Regular.ttf";
    };

    kernelParams = [
      "video=1920x1080"
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "systemd.show_status=auto"
      "rd.udev.log_priority=3"
      "fbcon=nodefer"
      "usbcore.autosuspend=-1"
      "video4linux"
    ];
  };
}
