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

# Adding python bin paths to $PATH
ls -1 $HOME/Library/Python/ | while read python_bins
do
    export PATH="$HOME/Library/Python/$python_bins/bin:$PATH"
done

# Add homebrew bin path to $PATH
export PATH="/opt/homebrew/bin:$PATH"

# Clone git repo with the playbook
git clone $git_url mac-playbook
cd mac-playbook

# Install deps and run the playbook
ansible-galaxy install -r requirements.yml
ansible-playbook main.yml --ask-become-pass
