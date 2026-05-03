{...}: {
  virtualisation.incus.enable = true;
  networking.nftables = {
    enable = true;
    flushRuleset = false;
  };

  networking.firewall.trustedInterfaces = ["incusbr0"];

  users.users.echo.extraGroups = ["incus-admin"];
}
