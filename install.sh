#!/bin/bash

set -x

git_url="https://github.com/thebiblelover7/mac-playbook"

cd /tmp

# Install command-line utilities
xcode-select --install

# Adding python bin paths to $PATH
ls -1 $HOME/Library/Python/ | while read python_bins
do
    export PATH="$HOME/Library/Python/$python_bins/bin:$PATH"
done

# Add homebrew bin path to $PATH
export PATH="/opt/homebrew/bin:$PATH"

# Upgrade pip and install ansible
sudo pip3 install --upgrade pip
pip3 install ansible

# Clone git repo with the playbook
git clone $git_url mac-playbook
cd mac-playbook

# Install deps and run the playbook
ansible-galaxy install -r requirements.yml
ansible-playbook main.yml --ask-become-pass
