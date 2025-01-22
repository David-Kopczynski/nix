{ lib, pkgs, ... }:

let
  ansible-source = lib.fileset.toSource {
    root = ../resources/ansible;
    fileset = ../resources/ansible;
  };

  ansible-update = pkgs.writeShellApplication {

    name = "ansible-update";
    text = ''
      # Execute playbook
      export ANSIBLE_CONFIG=${ansible-source}/ansible.cfg
      ansible-playbook ${ansible-source}/playbook.yml
    '';
  };

  packages = with pkgs; [
    ansible
    ansible-lint
  ];
in
{
  environment.systemPackages = packages ++ [ ansible-update ];
}
