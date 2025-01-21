{ ... }:

{
  users.users."user" = {

    # User configuration
    isNormalUser = true;
    description = "David Kopczynski";
    extraGroups = [ "wheel" ];
  };
}
