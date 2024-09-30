{ ... }:

{
  # User configuration
  users.users.user = {
    isNormalUser = true;
    description = "David Kopczynski";
    extraGroups = [ "wheel" ];
  };
}
