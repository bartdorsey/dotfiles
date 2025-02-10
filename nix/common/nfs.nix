{...}: {
  services.rpcbind.enable = true; # needed for NFS
  systemd.mounts = [
    {
      type = "nfs";
      what = "10.0.0.192:/volume1/Media";
      where = "/mnt/Media";
    }
  ];
  systemd.automounts = [
    {
      wantedBy = ["multi-user.target"];
      automountConfig = {
        TimeoutIdleSec = "600";
      };
      where = "/mnt/Media";
    }
  ];
}
