{ config, pkgs, ... }:

{
services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };
   
#   displayManager.lightdm.greeters.slick.enable = true;

   # display manager
     displayManager.defaultSession = "none+i3";
     displayManager.gdm = {
       enable = true;
     };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        rofi #application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock #default i3 screen locker
        i3blocks #if you are planning on using i3blocks over i3status
     ];
    };
  };

}


