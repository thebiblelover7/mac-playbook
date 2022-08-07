#!/bin/bash

set -xe

git_url="https://github.com/thebiblelover7/mac-playbook"

cd /tmp

set +e
# Install command-line utilities
xcode-select --install

# Wait for installation to finish
echo "Press enter when xcode command line utilities are installed:"
read ready

set -e
# Upgrade pip and install ansible
sudo pip3 install --upgrade pip
pip3 install ansible

# Adding python and homebrew bin paths to $PATH
export PATH="$HOME/Library/Python/3.8/bin:/opt/homebrew/bin:$PATH"

# Clone git repo with the playbook
set +e
rm -r mac-playbook
set -e
git clone $git_url mac-playbook
cd mac-playbook

# Pre-playbook things
mkdir -p $HOME/.config

# Install deps and run the playbook
ansible-galaxy install -r requirements.yml
set +e
ansible-playbook main.yml --ask-become-pass

echo 'run this command: "ansible-playbook main.yml --ask-become-pass"'
zsh
