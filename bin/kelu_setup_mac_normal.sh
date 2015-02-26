#!/bin/bash
set -e

clear
# Check if user is root
if [ $(id -u) = "0" ]; then
  echo "Warning: You should not be a root to run this script if you are not a root"
fi

KELUMACKIT=$(pwd)
NOWTIME=$(date)
# GITHUBNAME='kelvinblood'
# GITHUBEMAIL='kelvinbloodzz@gmail.com'
DOWNLOAD="$KELUMACKIT/Download"
RESOURCE="$KELUMACKIT/Resource"

if [ ! -e Download ]; then
  mkdir Download
fi

echo "========================================================================="
echo "KeluMacKit V0.1 for Mac OSX Yosemit"
echo "KeluMacKit will install in this path: $KELUMACKIT"
echo "A tool to install & config for git, maximum-awesome, macvim, iTerm 2, Mou, etc."
echo "Note that you have to install xcode before you run keluMacKit, "
echo "http://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12"
echo "For more information please visit http://project.kelu.org/kelumackit"
echo "========================================================================="

echo "-- maximum-awesome install -----------------------------------------------------"
echo "include Homebrew,Homebrew Cask,the_silver_searcher,iTerm2"
echo "reattach-to-user-namespace,tmux,openssl,libevent,MacVim with plenty plugin of vim "
cd $DOWNLOAD
if [ ! -e maximum-awesome ]; then
  git clone https://github.com/square/maximum-awesome.git
fi
cd maximum-awesoe && rake
cp $RESOURCE/maximum-awesome/tmux.conf $DOWNLOAD/maximum-awesome
cp $RESOURCE/maximum-awesome/.tmux.conf.local $HOME

echo "-- tmux-powerline install -----------------------------------------------------"
cd $DOWNLOAD
if [ ! -e tmux-powerline ]; then
  git clone https://github.com/erikw/tmux-powerline.git
fi
cat >> $DOWNLOAD/maximum-awesome/tmux.conf<< EOF

set-option -g status-left "#($DOWNLOAD/tmux-powerline/powerline.sh left)"
set-option -g status-right "#($DOWNLOAD/tmux-powerline/powerline.sh right)"
source-file ~/.tmux.conf.local
EOF
cp $RESOURCE/tmux-powerline/default.sh $DOWNLOAD/tmux-powerline/theme/


echo "-- wget htop iftop install -----------------------------------------------------"
brew install wget htop iftop pstree

echo "-- bashrc inputrc install ------------------------------------------------------"
if [ -s $HOME/.bashrc ]; then
  mv $HOME/.bashrc $HOME/.bashrc.local
fi
cp $RESOURCE/.bashrc $HOME
. $HOME/.bashrc

cp $RESOURCE/.inputrc $HOME

# Mou
cd $DOWNLOAD
if [ ! -e Mou.zip ]; then
  wget http://25.io/mou/download/Mou.zip
fi
unzip Mou.zip
mv Mou.app /Applications

# echo "-- github install ------------------------------------------------------"
# git config --global user.name "$GITHUBNAME"
# git config --global user.email "$GITHUBEMAIL"

cd $HOME/Downloads
wget http://s1.music.126.net/download/osx/NeteaseMusic_1.1.1.320.dmg


echo "Install KeluMacKit 0.1 completed! enjoy it."
echo "But still, you need to follow these steps with manual work."
echo "1. edit your iTerm2 profile, e.g. http://blog.kelu.org/mac/2015/01/25/iterm2-2.html. "
echo "  It will help you a wonderful sightseeing of iTerms."
echo "2. adding plugin: Supertab neocomplcache. seeing more about how to manage plugin by Bundle"
echo "3. some useful tools, e.g. [github.app](https://mac.github.com) "

# -- solarized dark or light -----------------------------------------------------

#  You're almost done! Inside of the maximum-awesome-linux directory, do:
#     rake install:solarized['dark']
#          or
#             rake install:solarized['light']
#              You may need to close your terminal and re-open it for it to take effect.
#              root@li740-56:~/KeluLinuxKit#
