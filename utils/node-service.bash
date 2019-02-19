#!/bin/bash
set -e

export NVM_DIR=$HOME/.nvm;
source $HOME/.nvm/nvm.sh;

cd /var/www/node
npx pm2 start ecosystem.config.js --no-daemon