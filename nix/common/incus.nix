{...}: {
  virtualisation.incus.enable = true;
  networking.nftables.enable = true;

  networking.firewall.trustedInterfaces = ["incusbr0"];
  networking.nftables.flushRuleset = false;

  users.users.echo.extraGroups = ["incus-admin"];
}
