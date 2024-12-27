{pkgs, ...}: {
  programs.zsh.enable = true;

  users.users.echo = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Bart Dorsey";
    extraGroups = ["networkmanager" "wheel" "docker"];
  };

  users.groups.echo = {
    name = "echo";
    members = ["echo"];
    gid = 1000;
  };
}
