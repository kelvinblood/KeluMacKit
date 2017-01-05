#!/bin/bash

. install.sh

cd $BASEPATH
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh

echo "-- maximum-awesome install -----------------------------------------------------"
cd $BASEPATH
if [ ! -e maximum-awesome ]; then
  git clone https://github.com/square/maximum-awesome.git
fi
cd maximum-awesome && rake
cp $RESOURCE/maximum-awesome/tmux.conf $BASEPATH/maximum-awesome
cp $RESOURCE/maximum-awesome/.tmux.conf.local $HOME

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
# hide iTerm2 icon in dock
# /usr/libexec/PlistBuddy  -c "Add :LSUIElement bool true" /Applications/iTerm.app/Contents/Info.plist


cat >> $HOME/.zshrc<< EOF
alias vi='vim'
alias dd='df -h'
alias dudir='du --max-depth=1 -ah 2> /dev/null | sort -hr | head '
alias p='netstat -antp'
alias pp='pstree -a'
alias rm0='find / -type f -name "0" | xargs -i  rm -fr "{}"'
alias grepall='grep -D skip -nRe'
alias sour='source ~/.zshrc'

alias tn='tmux new -s'
alias tll='tmux ls'
alias tt='tmux attach -t'
alias tk='tmux kill-session -t'
EOF

