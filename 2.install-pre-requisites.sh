#!/bin/bash -x
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

# Install sam cli version 1.131.0 
echo "Installing sam cli version 1.131.0"
wget https://github.com/aws/aws-sam-cli/releases/download/v1.131.0/aws-sam-cli-linux-x86_64.zip
unzip aws-sam-cli-linux-x86_64.zip -d sam-installation
sudo ./sam-installation/install
if [ $? -ne 0 ]; then
	echo "Sam cli is already present, so deleting existing version"
	sudo rm /usr/local/bin/sam
	sudo rm -rf /usr/local/aws-sam-cli
	echo "Now installing sam cli version 1.131.0"
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

# Install node v18.20.0
echo "Installing node v18.20.0"
nvm deactivate
nvm uninstall node
nvm install v18.20.0
nvm use v18.20.0
nvm alias default v18.20.0

# Install cdk cli version 2.133.0
echo "Installing cdk cli version 2.133.0"
npm uninstall -g aws-cdk
npm install -g aws-cdk@2.133.0

# Install yarn version 1.22.19
echo "Installing yarn version 1.22.19"
curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version 1.22.19 
# Reload the bash profile
source ~/.bash_profile

#Install jq version 1.5
sudo yum -y install jq-1.5

#Install pylint version 3.1.0
python3 -m pip install pylint==3.1.0

#Install cfn-lint version 0.86.0
python3 -m pip install cfn-lint==0.87.4

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
