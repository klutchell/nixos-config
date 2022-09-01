# https://github.com/divnix/digga/blob/main/doc/secrets.md
let
  # set ssh public keys here for your systems and users
  user1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICzLUZyHJY2j/hIwnCPdn3yRvUyYYXYnMf+E3m3Dz9Wd kyle@jupiter";
  user2 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILI6jSq53F/3hEmSs+oq9L4TwOo1PrDMAgcA1uo1CCV/";
  users = [ user1 user2 ];

  system1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICdmHg6mPdyKegPkWekdYKwEER8qgHjFNqx5Sgqf3YbT root@jupiter";
  system2 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKzxQgondgEYcLpcPdJLrTdNgZ2gznOHCAxMdaceTUT1";
  systems = [ system1 system2 ];
in
{
  "secret1.age".publicKeys = [ user1 system1 ];
  "secret2.age".publicKeys = users ++ systems;

  "balena-aws-config.age".publicKeys = users ++ systems;
}
