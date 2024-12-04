{ ... }:

{
  # Fetch hardware config from nixos-hardware
  imports = [ <nixos-hardware/framework/13-inch/13th-gen-intel> ];

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Graphic card drivers
  hardware.graphics.enable = true;

  # Remap keyboard keys
  services.keyd = {
    enable = true;

    keyboards.default = {
      ids = [ "*" ];

      # Open terminal with FK12
      settings.main.media = "C-A-t";
    };
  };

  # Better battery life
  powerManagement.powertop.enable = true;

  # Enable firmware updates
  services.fwupd.enable = true;
}
