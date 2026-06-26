{ user }:

{
  # Allow connection to keyboard
  users.users.${user}.extraGroups = [ "input" ];
}
