#!/bin/bash

echo "######################################################################################"
echo "# This is a script to input all the required variables to connect to an s3 endpoint  #"
echo "#                                                                                    #"
echo "# Phil Bendeck | VMware Staff Solutions Architect 2022                               #"
echo "#                                                                                    #"
echo "######################################################################################"
echo

while true
do
read -r -p "--> Would you like to add an AWS credentials to ./aws/credentials [Yes or No]: " input

case $input in
     [yY][eE][sS]|[yY])
echo "--> The option Yes has been selected by $USER"
read -p "--> Enter the profile alias to store under $HOME/.aws/credentials: " alias_cred
echo "--> Alias Profile = [$alias_cred]"
echo "[$alias_cred]" >> $HOME/.aws/credentials

#AWS Access Key ID
read -p "--> Enter the AWS Access Key ID: " aws_access_key_id
echo "aws_access_key_id = ${aws_access_key_id}" >> $HOME/.aws/credentials
echo "--> AWS Access Key ID = $aws_access_key_id"

#AWS Secret Access Key ID
read -p "--> Enter the AWS Secret Access Key ID: " aws_secret_access_key
echo "aws_secret_access_key = ${aws_secret_access_key}" >> $HOME/.aws/credentials
break
;;
     [nN][oO]|[nN])
echo "No"
break
        ;;
     *)
echo "Invalid input..."
 ;;
esac
done

# Functions
BASH(){
echo "--> The option Yes has been selected by $USER ($UID)"
read -p "--> Please input the bash alias for the aws s3 profile: " alias_bash
read -p "--> Please input the FQDN S3 Endpoint [https://s3-nuc.iphilsanity.com]: " fqdn
fqdn=${fqdn:-https://s3-nuc.iphilsanity.com}
echo "--> Creating 'aws --profile=$alias_cred --no-verify-ssl --endpoint-url=$fqdn s3'"
echo "alias $alias_bash='aws --profile=$alias_cred --no-verify-ssl --endpoint-url=$fqdn s3'" >> $HOME/.bash_profile
grep $alias_bash $HOME/.bash_profile
}

ZSH(){
echo "--> The option Yes has been selected by $USER ($UID)"
read -p "--> Please input the zsh alias for the aws s3 profile: " alias_zsh
read -p "--> Please input the FQDN S3 Endpoint [https://s3-nuc.iphilsanity.com]: " fqdn
fqdn=${fqdn:-https://s3-nuc.iphilsanity.com}
echo "--> Creating 'aws --profile=$alias_zsh --no-verify-ssl --endpoint-url=$fqdn s3'"
echo "alias $alias_zsh='aws --profile=$alias_cred --no-verify-ssl --endpoint-url=$fqdn s3'" >> $HOME/.zshrc
grep $alias_zsh $HOME/.zshrc
}

while true
do
read -r -p "--> Would you like to create an S3 profile under $HOME/.bash_profile for $alias [Yes or No]: " input

case $input in
     [yY][eE][sS]|[yY])

# Find out the shell the end user to input the executable S3 alias
MYSHELL=$(echo $SHELL)

if [ "$MYSHELL" == "/bin/bash" ]
then
    echo "--> $USER on $HOSTNAME is running $MYSHELL"
    echo "--> Running the aws cli /bin/bash function"
    # Run BASH function
    BASH
else
    echo "--> $USER on $HOSTNAME is running $MYSHELL"
    # Run ZSH function
    echo "--> Running the aws cli /bin/zsh function"
    ZSH
fi

break
;;
     [nN][oO]|[nN])
echo "No"
break
        ;;
     *)
echo "Invalid input..."
 ;;
esac
done
