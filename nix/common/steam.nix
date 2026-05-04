{pkgs, ...}: {
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.steam = {
    gamescopeSession.enable = true;
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraPackages = with pkgs; [
      gamescope
      mangohud
    ];
  };
}
