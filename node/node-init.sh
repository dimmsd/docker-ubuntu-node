#!/bin/sh
set -e

if [ ! -z "$TIMEZONE" ]
then
    # set system timezone
    rm /etc/localtime
    ln -s /usr/share/zoneinfo/$TIMEZONE /etc/localtime
fi

# create user
if [ ! -z "$OWN_GID" ] && [ ! -z "$OWN_UID" ] && [ ! -z "$OWN_USER" ]; then
if ! id -u $OWN_GID > /dev/null 2>&1; then
    groupadd -g ${OWN_GID} ${OWN_USER}
fi
if ! id -u $OWN_UID > /dev/null 2>&1; then
    useradd -ms /bin/bash -g ${OWN_GID} -u ${OWN_UID} ${OWN_USER}
    gpasswd -a ${OWN_USER} www-data
fi
if [ ! -e /home/$OWN_USER/.profile ]
then
    cp -f /tmp/user_template/.profile /home/$OWN_USER/
    cp -f /tmp/user_template/.bashrc /home/$OWN_USER/
    cp -f /tmp/user_template/.bash_logout /home/$OWN_USER/
    chown -R ${OWN_USER}:${OWN_USER} /home/$OWN_USER/
fi
fi

if [ ! -z "$NO_DAEMON" ]
then
    exec /bin/bash
else
    sudo -i -u $OWN_USER /tmp/utils/node-service.bash
fi

