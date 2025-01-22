{ ... }:

{
  services.pipewire.enable = true;
  services.pipewire = {

    # General configuration
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  security.rtkit.enable = true;
}
