{ config, pkgs, ... }:

let
  ansible-update = pkgs.writeShellScriptBin "ansible-update" ''

    # Execute playbook
    export ANSIBLE_CONFIG=${config.root}/resources/ansible/ansible.cfg
    ansible-playbook ${config.root}/resources/ansible/playbook.yml

  '';

  packages = with pkgs; [
    ansible
    ansible-lint
  ];
in
{
  environment.systemPackages = packages ++ [ ansible-update ];
}
