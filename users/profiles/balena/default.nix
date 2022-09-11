{ pkgs, self, ... }:

let
  ekslogin = pkgs.writeShellScriptBin "ekslogin" ''
    unset AWS_PROFILE
    ${pkgs.aws-google-auth}/bin/aws-google-auth -p "''${1}" -r "''${2}"
    export AWS_PROFILE="''${1}"
  '';

  balena-production = pkgs.writeShellScriptBin "balena-production" ''
    ${ekslogin}/bin/ekslogin balena-production arn:aws:iam::491725000532:role/federated-admin
    ${pkgs.awscli2}/bin/aws --profile balena-production eks --region us-east-1 update-kubeconfig --name production-eks --alias production-eks
  '';

  balena-staging = pkgs.writeShellScriptBin "balena-staging" ''
    ${ekslogin}/bin/ekslogin balena-staging arn:aws:iam::567579488761:role/federated-admin
    ${pkgs.awscli2}/bin/aws --profile balena-staging eks --region us-east-1 update-kubeconfig --name staging-eks --alias staging-eks
  '';

  balena-playground = pkgs.writeShellScriptBin "balena-playground" ''
    ${ekslogin}/bin/ekslogin balena-playground arn:aws:iam::240706700173:role/federated-admin
    ${pkgs.awscli2}/bin/aws --profile balena-playground eks --region us-east-1 update-kubeconfig --name playground-eks --alias playground-eks
  '';

in
{
  home.packages = with pkgs; [
    balena-cli
    balena-production
    balena-staging
    balena-playground
    k9s
    kubectl
    saml2aws
  ];
}
