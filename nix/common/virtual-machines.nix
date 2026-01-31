{pkgs, ...}: {
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["echo"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
}
