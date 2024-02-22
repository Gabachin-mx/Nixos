# { config, pkgs, ... }:

{ lib, ... }:

{
  services.xserver = {
    enable = true;
     displayManager.defaultSession = "none+i3";
     displayManager.sddm.sugarCandyNix = {
      enable = true; # This enables SDDM automatically and set its theme to
                     # "sddm-sugar-candy-nix"
      settings = {
        # Set your configuration options here.
        # Here is a simple example:
        Background = lib.cleanSource ./0033.jpg;
        ScreenWidth = 1920;
        ScreenHeight = 1080;
        FormPosition = "center";
        HaveFormBackground = true;
        HeaderText = "Hey Paulie";
        PartialBlur = true;
      };
    };
    windowManager.i3 = {
      enable = true;
    };
  };
}

