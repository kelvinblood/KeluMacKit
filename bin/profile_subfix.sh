#!/bin/bash

. install.sh

echo "-- wget htop iftop install -----------------------------------------------------"
brew install wget htop iftop pstree

echo "-- bashrc inputrc install ------------------------------------------------------"
if [ -s $HOME/.bashrc ]; then
  mv $HOME/.bashrc $HOME/.bashrc.local
fi

cp $RESOURCE/.bashrc $HOME
. $HOME/.bashrc

cp $RESOURCE/.inputrc $HOME
