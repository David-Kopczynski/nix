{ ... }:

{
  services.howdy.enable = true;
  services.howdy = {

    # General
    control = "sufficient";
  };

  # Hardware support
  services.linux-enable-ir-emitter.enable = true;

  # Secrets
  sops.secrets."workstation/howdy/user.dat" = {

    sopsFile = ./user.dat;
    format = "binary";
    path = "/var/lib/howdy/models/user.dat";
  };
}
