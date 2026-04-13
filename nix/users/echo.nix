{
  pkgs,
  pkgs-unstable,
  ...
}: {
  programs.zsh.enable = true;

  programs.vim = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = pkgs-unstable.neovim-unwrapped;
  };

  users.groups.echo = {
    gid = 1000;
  };

  users.users.echo = {
    group = "echo";
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Bart Dorsey";
    extraGroups = ["users" "networkmanager" "wheel" "podman" "storage"];
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIQ13RJl+pe6gTRnmQmK6X0FRPjfereo4rc8oAivFA4A"];
    linger = true;
  };
}
