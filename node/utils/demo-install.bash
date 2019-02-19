#!/bin/bash
set -e

export NVM_DIR=$HOME/.nvm;
source $HOME/.nvm/nvm.sh;

cd /var/www/node
rm -rf ./node_modules
rm -rf package.json
rm -rf package-lock.json
cp -f  package.json.origin package.json
npm install --save-prod express
npm install --save-prod pm2
npm install
