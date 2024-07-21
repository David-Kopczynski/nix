{ config, pkgs, ... }:

pkgs.writeShellScriptBin "ansible-update" ''

  # Execute playbook
  export ANSIBLE_CONFIG=~/Documents/Ansible/ansible.cfg
  ansible-playbook ~/Documents/Ansible/playbook.yml

''
