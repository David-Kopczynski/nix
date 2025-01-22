{ pkgs, ... }:

let
  ansible-update = pkgs.writeShellScriptBin "ansible-update" ''

    # Execute playbook
    export ANSIBLE_CONFIG=${../resources/ansible/ansible.cfg}
    ansible-playbook ${../resources/ansible/playbook.yml}

  '';

  packages = with pkgs; [
    ansible
    ansible-lint
  ];
in
{
  environment.systemPackages = packages ++ [ ansible-update ];
}
