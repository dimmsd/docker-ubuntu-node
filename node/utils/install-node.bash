#!/bin/bash
set -e

export NVM_DIR=$HOME/.nvm;
source $HOME/.nvm/nvm.sh;

if [ ! -z "$NODE_VERSION" ]
then
    nvm install $NODE_VERSION
    nvm alias default $NODE_VERSION
    nvm use default
else
    echo "Install latest version..."
    nvm install node
    nvm alias default node
    nvm use default
fi
