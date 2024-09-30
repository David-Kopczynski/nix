{ pkgs, ... }:

let
  ansible-update = pkgs.writeShellScriptBin "ansible-update" ''

  # Execute playbook
  export ANSIBLE_CONFIG=~/Documents/Ansible/ansible.cfg
  ansible-playbook ~/Documents/Ansible/playbook.yml

'';
in
{
  environment.systemPackages = [ ansible-update ] ++ [ pkgs.ansible pkgs.ansible-lint ];
}
