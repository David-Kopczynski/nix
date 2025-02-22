{ pkgs, ... }:

let
  ansible-update = pkgs.writeShellApplication {

    name = "ansible-update";
    text = ''
      # Execute playbook
      export ANSIBLE_CONFIG=${../resources/ansible}/ansible.cfg
      ansible-playbook ${../resources/ansible}/playbook.yml
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
