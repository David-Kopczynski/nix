{ ... }:

{
  services.pipewire.wireplumber.enable = true;
  services.pipewire.wireplumber.extraConfig = {

    "disable-unused-audio"."monitor.alsa.rules" = [
      {
        actions.update-props."device.disabled" = true;
        matches = [
          { "device.nick" = "Logi 4K Stream Edition"; } # Webcam
          { "device.nick" = "HDA Intel PCH"; } # OnBoard Sound
        ];
      }
    ];
  };
}
