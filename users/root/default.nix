{ self, config, pkgs, ... }:
{
  users.users.root.hashedPassword = "$6$7d6Xv9mJNhd.QE9O$aBBmtwSVF04TZDuG7gWZaE31nTYcW..DstCWwjShNWNIwXhvmBanZwzHEAHOPEI5YzpqYXy8r5Hu5BjwR48o41";

  users.users.root.openssh.authorizedKeys.keyFiles = [
    (pkgs.fetchurl {
      url = "https://github.com/klutchell.keys";
      sha256 = "sha256-lPUFhm8cpFqD4QZUoCridf7BDsGwGZI69GTgzAyoV9c=";
    })
  ];
}
