{
  pkgs,
  pkgs-unstable,
  ...
}: {
  users.users.guest = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Guest";
    extraGroups = ["networkmanager" "wheel" "docker"];
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIQ13RJl+pe6gTRnmQmK6X0FRPjfereo4rc8oAivFA4A"];
  };

  users.groups.guest = {
    name = "guest";
    members = ["guest"];
  };
}
