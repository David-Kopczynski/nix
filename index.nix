{
    imports = [

        # Envorinment variables
        ./.env.nix

        # Default system configuration
        ./hosts/default/index.nix

        # Packages, programs and services
        ./packages/index.nix
        ./programs/index.nix
        ./services/index.nix
    ];
}
