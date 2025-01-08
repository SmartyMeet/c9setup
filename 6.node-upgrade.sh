# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash


# Install node v22.12.0
echo "Installing node v22.12.0"
nvm deactivate
nvm uninstall node
nvm install v22.12.0
nvm use v22.12.0
nvm alias default v22.12.0