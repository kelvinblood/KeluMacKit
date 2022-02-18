#!/bin/bash
. /etc/profile

KELUMACKIT=$(pwd)
NOWTIME=$(date)
BASEPATH="$KELUMACKIT/Download"
DOWNLOAD="$KELUMACKIT/Download"
RESOURCE="$KELUMACKIT/Resource"
USER=`whoami`

export ALL_PROXY=http://127.0.0.1:1087

mkdir -p Download

echo "-- wget htop iftop install -----------------------------------------------------"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install wget htop iftop pstree

echo "-- bashrc inputrc install ------------------------------------------------------"
cp $RESOURCE/.inputrc $HOME

cd $BASEPATH
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh

echo "download java first: https://www.java.com/en/download/mac_download.jsp"
echo "-- maximum-awesome install -----------------------------------------------------"
cd $BASEPATH
if [ ! -e maximum-awesome ]; then
  git clone https://github.com/square/maximum-awesome.git
fi
cd maximum-awesome && rake
sudo cp $RESOURCE/maximum-awesome/tmux.conf $BASEPATH/maximum-awesome
sudo cp $RESOURCE/maximum-awesome/.tmux.conf.local $HOME

echo "-- tmux-powerline install -----------------------------------------------------"
cd $BASEPATH
if [ ! -e tmux-powerline ]; then
  git clone https://github.com/erikw/tmux-powerline.git
fi
cat >> $BASEPATH/maximum-awesome/tmux.conf<< EOF

set-option -g status-left "#($BASEPATH/tmux-powerline/powerline.sh left)"
set-option -g status-right "#($BASEPATH/tmux-powerline/powerline.sh right)"
source-file ~/.tmux.conf.local
EOF
cp $RESOURCE/tmux-powerline/default.sh $BASEPATH/tmux-powerline/themes/

chsh -s /bin/zsh
/bin/cat $RESOURCE/.zshrc >> ~/.zshrc
# hide iTerm2 icon in dock
# /usr/libexec/PlistBuddy  -c "Add :LSUIElement bool true" /Applications/iTerm.app/Contents/Info.plist

/usr/libexec/PlistBuddy  -c "Add :LSUIElement bool true" /Applications/iTerm.app/Contents/Info.plist
