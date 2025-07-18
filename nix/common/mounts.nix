{...}: {
  services.rpcbind.enable = false; # needed for NFS
  systemd.mounts = let
    commonNFSMountOptions = {
      type = "nfs";
    };
    commonSMBMountOptions = {
      type = "cifs";
      options = "credentials=/etc/nixos/smb-credentials,uid=1000,gid=1000";
    };
  in [
    (commonNFSMountOptions
      // {
        what = "10.0.0.192:/volume1/Media";
        where = "/mnt/Media";
      })
    (commonNFSMountOptions
      // {
        what = "10.0.0.192:/volume2/Music";
        where = "/mnt/Music";
      })
    (commonNFSMountOptions
      // {
        what = "10.0.0.192:/volume2/echo";
        where = "/mnt/echo";
      })
    (commonNFSMountOptions
      // {
        what = "10.0.0.192:/volume2/Developer";
        where = "/mnt/Developer";
      })
    (commonNFSMountOptions
      // {
        what = "10.0.0.192:/volume1/Backups";
        where = "/mnt/Backups";
      })
    (commonNFSMountOptions
      // {
        what = "10.0.0.192:/volume2/WSLBackups";
        where = "/mnt/WSLBackups";
      })
    (
      commonSMBMountOptions
      // {
        what = "//10.0.0.67/config";
        where = "/mnt/homeassistant";
      }
    )
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
    (commonAutoMountOptions // {where = "/mnt/Music";})
    (commonAutoMountOptions // {where = "/mnt/echo";})
    (commonAutoMountOptions // {where = "/mnt/Developer";})
    (commonAutoMountOptions // {where = "/mnt/Backups";})
    (commonAutoMountOptions // {where = "/mnt/WSLBackups";})
    (commonAutoMountOptions // {where = "/mnt/homeassistant";})
  ];
}
