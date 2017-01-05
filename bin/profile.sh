#!/bin/bash

. install.sh

# Check if user is root
if [ $(id -u) != "0" ]; then
  echo "Warning: You should be root to run this script, you can run bin/kelu_setup_mac_root.sh yourself later"
else
cat >> /etc/profile << EOF

# Add by keluMacKit
if [ "\${BASH-no}" != "no" ]; then
  [ -r $HOME/.bashrc ] && . $HOME/.bashrc
fi
EOF
fi

