{ ... }:

{
  services.howdy.enable = true;
  services.howdy = {

    # General
    control = "sufficient";
  };

  # Hardware support
  services.linux-enable-ir-emitter.enable = true;
}
