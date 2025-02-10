{...}: {
  services.rpcbind.enable = true; # needed for NFS
  systemd.mounts = let
    commonMountOptions = {
      type = "nfs";
    };
  in [
    (commonMountOptions
      // {
        what = "10.0.0.192:/volume1/Media";
        where = "/mnt/Media";
      })

    (commonMountOptions
      // {
        what = "10.0.0.192:/volume2/echo";
        where = "/mnt/echo";
      })
    (commonMountOptions
      // {
        what = "10.0.0.192:/volume2/Developer";
        where = "/mnt/Developer";
      })
    (commonMountOptions
      // {
        what = "10.0.0.192:/volume1/Backups";
        where = "/mnt/Backups";
      })
    (commonMountOptions
      // {
        what = "10.0.0.192:/volume2/WSLBackups";
        where = "/mnt/WSLBackups";
      })
  ];

  systemd.automounts = let
    commonAutoMountOptions = {
      wantedBy = ["multi-user.target"];
      automountConfig = {
        TimeoutIdleSec = "600";
      };
    };
  in [
    (commonAutoMountOptions // {where = "/mnt/Media";})
    (commonAutoMountOptions // {where = "/mnt/echo";})
    (commonAutoMountOptions // {where = "/mnt/Developer";})
    (commonAutoMountOptions // {where = "/mnt/Backups";})
    (commonAutoMountOptions // {where = "/mnt/WSLBackups";})
  ];
}
