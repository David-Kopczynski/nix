{ ... }:

{
  sops.secrets."workstation/howdy/user.dat" = {

    sopsFile = ./user.dat;
    format = "binary";
    path = "/var/lib/howdy/models/user.dat";
  };
}
