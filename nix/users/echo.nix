{pkgs, ...}: {
  programs.zsh.enable = true;

  users.users.echo = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Bart Dorsey";
    extraGroups = ["networkmanager" "wheel" "docker"];
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIQ13RJl+pe6gTRnmQmK6X0FRPjfereo4rc8oAivFA4A"];
  };

  users.groups.echo = {
    name = "echo";
    members = ["echo"];
    gid = 1000;
  };
}
