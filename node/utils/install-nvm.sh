#!/bin/sh
set -e

cd /tmp
curl -sL https://raw.githubusercontent.com/creationix/nvm/v$NVM_VERSION/install.sh -o install_nvm.sh
bash install_nvm.sh
