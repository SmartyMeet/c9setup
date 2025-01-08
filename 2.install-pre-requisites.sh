#!/bin/bash -x

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

. /home/ec2-user/.nvm/nvm.sh

# AL2023 ships with AWS CLI version 2, while AL2 continues to ship with version 1 of the AWS CLI.

# # Uninstall aws cli v1 and Install aws cli
# sudo pip2 uninstall awscli -y

# echo "Installing aws cli version-2.3.0"
# curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.3.0.zip" -o "awscliv2.zip"
# unzip awscliv2.zip
# sudo ./aws/install
# rm awscliv2.zip
# rm -rf aws 

# Install sam cli version 1.132.0 
echo "Installing sam cli version 1.132.0"
wget https://github.com/aws/aws-sam-cli/releases/download/v1.132.0/aws-sam-cli-linux-x86_64.zip
unzip aws-sam-cli-linux-x86_64.zip -d sam-installation
sudo ./sam-installation/install
if [ $? -ne 0 ]; then
	echo "Sam cli is already present, so deleting existing version"
	sudo rm /usr/local/bin/sam
	sudo rm -rf /usr/local/aws-sam-cli
	echo "Now installing sam cli version 1.132.0"
	sudo ./sam-installation/install
fi
rm aws-sam-cli-linux-x86_64.zip
rm -rf sam-installation

# Install git-remote-codecommit version 1.17
echo "Installing git-remote-codecommit version 1.17"
curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user
rm get-pip.py

python3 -m pip install git-remote-codecommit==1.17

# Install node v22.12.0
echo "Installing node v22.12.0"
nvm deactivate
nvm uninstall node
nvm install v22.12.0
nvm use v22.12.0
nvm alias default v22.12.0

# Install cdk cli version 2.174.1
echo "Installing cdk cli version 2.174.1"
npm uninstall -g aws-cdk
npm install -g aws-cdk@2.174.1

# Install yarn version 1.22.22
echo "Installing yarn version 1.22.22"
curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version 1.22.22 
# Reload the bash profile
source ~/.bash_profile

#Install jq version 1.5
sudo yum -y install jq-1.5

#Install pylint version 3.1.0
python3 -m pip install pylint==3.1.0

#Install cfn-lint version 1.22.3
python3 -m pip install cfn-lint==1.22.3

#Install yamllint version 1.35.1
python3 -m pip install yamllint==1.35.1

# install swagger-cli globally using npm
npm install -g swagger-cli

# install the OpenAPI Generator CLI
yarn global add @openapitools/openapi-generator-cli

#Get User Data
C9_USER_ID=$(aws sts get-caller-identity | jq -r '.UserId')
echo "Cloud9 UserId: ${C9_USER_ID}"

C9_USER_ARN=$(aws sts get-caller-identity | jq -r '.Arn')
echo "Cloud9 UserArn: ${C9_USER_ARN}"

C9_USER_EMAIL=${C9_USER_ID#*:}
echo "Cloud9 UserEmail: ${C9_USER_EMAIL}"

C9_USER_NAME=${C9_USER_EMAIL%@*}
echo "Cloud9 UserName: ${C9_USER_NAME}"

#Git Config
echo "Configure git"
git config --global user.name $C9_USER_NAME
git config --global user.email $C9_USER_EMAIL
# git config --global credential.helper '!aws codecommit credential-helper $@'
# git config --global credential.UseHttpPath true
