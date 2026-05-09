{
  description = "Unified NixOS bootstrap flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = (
          {
            lib,
            pkgs,
            ...
          }:
          {
            imports = [
              /etc/nixos/hardware-configuration.nix
              #/home/cai/nixos/configuration.nix
            ];
            networking.hostName = lib.mkDefault "nixos";

            users.users.cai = {
              isNormalUser = true;
              description = "cai";
              extraGroups = [
                "wheel"
                "networkmanager"
                "nixos-editor"
              ];
              initialHashedPassword = "$y$j9T$vlXPN.XcTYwj4Lr/Vg7Uc/$8tBD4vY7qz/hYLgdpRHVV7xWFZctbpZdvpxEVnDCKI2";
              openssh.authorizedKeys.keys = [
                "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAvzJX7U5XdXJhf3+WhrI/3ZNCEMNS5N/ZQ/d9atFtS6lLFEi90mGNDV5k+yKhIyR7NRygl+4GC1rJ9DBckK9Rw6ZinRoj8TcGVpSzbE1zDlUl8yXbAuuK5Z3+GDFkMBQgnnwEO0WkbBaQmoaSgqjZo5fZg31B/b3tXnvsPZIrvtC2xkhXpSOcOdbMuvPjzzb98+nTVG2ke7CkYgqBXIwY6uPiJOrP9wkOQMcsBgdhZFOOhR/N+Dk7XgHCRzfEJ/RvH0naYKF8rjvTIN64UY4EjCOtU8GNJxB1S065P9MHplvk8Tey+562tG1aOUf5aRmQz+6Y8wk4dr5AE4L8oSdaBw=="
              ];
              shell = pkgs.fish;
            };

            users.defaultUserShell = pkgs.fish;
            users.groups."nixos-editor".gid = 67;

            programs.fish.enable = true;

            environment.systemPackages = with pkgs; [
              git
              btop
            ];

            # Keep the active flake materialized at /etc/nixos.
            systemd.tmpfiles.rules = [ "L+ /home/cai/nixos - - - - /etc/nixos" ];
            environment.etc."nixos".gid = 67;

            services.openssh.enable = true;

            system.autoUpgrade = {
              enable = true;
              allowReboot = true;
              dates = "03:00";
              randomizedDelaySec = "0";
            };
            nix.gc.automatic = true;
          }
        );
      };
    };
}
