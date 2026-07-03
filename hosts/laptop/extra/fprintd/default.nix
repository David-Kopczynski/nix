{ ... }:

{
  sops.secrets."laptop/fprint.right-index" = {

    sopsFile = ./fprint.right-index;
    format = "binary";
    path = "/var/lib/fprint/user/goodixmoc/UID742C7B57_XXXX_MOC_B0/7";
  };
}
