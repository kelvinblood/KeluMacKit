#!/bin/bash
set -e

# Check if user is root
if [ $(id -u) != "0" ]; then
  echo "Warning: You should be root to run this script, you can run bin/kelu_setup_mac_root.sh yourself later"
else
cat >> /etc/profile << EOF
# Add by keluMacKit $NOWTIME
if [ "\${BASH-no}" != "no" ]; then
  [ -r $HOME/.bashrc ] && . $HOME/.bashrc
fi
EOF
fi
