{...}: {
  services.rpcbind.enable = true; # needed for NFS
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
  ];
}
