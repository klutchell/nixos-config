{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    autocd = true;

    initExtra = ''

      balena-production () {
        balena-login balena-production arn:aws:iam::491725000532:role/federated-admin
        aws --profile balena-production eks --region us-east-1 update-kubeconfig --name production-eks --alias production-eks
      }

      balena-staging () {
        balena-login balena-staging arn:aws:iam::567579488761:role/federated-admin
        aws --profile balena-staging eks --region us-east-1 update-kubeconfig --name staging-eks --alias staging-eks
      }

      balena-playground () {
        balena-login balena-playground arn:aws:iam::240706700173:role/federated-admin
        aws --profile balena-playground eks --region us-east-1 update-kubeconfig --name playground-eks --alias playground-eks
      }

      balena-login () {
        unset AWS_PROFILE
        #docker run --rm -it -v $(readlink -f $HOME/.aws/config):/root/.aws/config:ro cevoaustralia/aws-google-auth -p $1 -r $2
        aws-google-auth -p $1 -r $2
        export AWS_PROFILE="$1" 
      }
    
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck"];
      theme = "robbyrussell";
    };
  };
}