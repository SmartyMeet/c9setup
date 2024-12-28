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