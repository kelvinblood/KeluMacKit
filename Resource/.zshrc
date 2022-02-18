source /etc/profile
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL=""
HOSTNAME=$(hostname)

alias vi='vim'
alias dudir='du --max-depth=1 -ah 2> /dev/null | sort -hr | head '
alias p='netstat -antup | grep "ESTABLISHED"'
alias ppp='netstat -antup'
alias pp='pstree -a'
alias pk='pkill -kill -t'
alias rm0='find / -type f -name "0" | xargs -i  rm -fr "{}"'
alias rmapt='rm -rf /var/lib/apt/lists/*;apt-get clean'
alias grepall='grep -D skip -nRe'
alias dr='docker restart'
alias dclear='docker system prune -a'
alias sour='source ~/.zshrc;source /etc/profile.d/kelu.sh'
alias kubeall='kubectl get all --all-namespaces; kubectl get nodes -owide'
alias pyweb='python -m SimpleHTTPServer'
# alias checkip="curl --max-time 2 -s http://whatismyip.akamai.com"
alias k="kelumail"
alias cat="bat"
alias ga="git add ."
alias f="/root/docker/flannel/5.ls-old-network.sh"
alias fd="/root/docker/flannel/7.rm-old-network.sh"
alias fn="/root/docker/flannel/6.new-network.sh"
alias reboot="systemctl stop docker && reboot"
alias ts='echo -e "\033[25h"'
alias gs="git status"
alias gm="git commit -m"
alias gd="git diff --cached"
alias gl="git log --stat"
alias gpush='ssh-agent bash -c "ssh-add $HOME/.ssh/admin@kelu.org;git push"'
alias gp='ssh-agent bash -c "ssh-add $HOME/.ssh/admin@kelu.org;git pull"'
alias ipl="iptables --line-numbers -nvL "
alias syne="/usr/bin/synergyc -f --daemon --no-tray --debug FATAL --name gx1 192.168.1.101:24800"
alias gshot="gnome-screenshot -a -c"
alias bl="/var/local/cron/day/blog_rebuild.sh"
alias pn="png2jpg"
alias setapp="vim /root/confd/app.sh; /root/confd/app.sh; /root/confd/boot.sh"
alias sethost="vim /etc/hosts_original; /root/confd/bin/setHost.sh;"
alias setnode="vim /root/confd/etcdinit.sh;/root/confd/etcdinit.sh; /root/confd/boot.sh"
alias setcron="vim /root/confd/bin/cron.sh; /root/confd/bin/cron.sh; /root/confd/boot.sh"
alias apt-get="apt-get -o Acquire::ForceIPv4=true"
alias setproxy="export ALL_PROXY=socks5://127.0.0.1:31080"
alias setgitproxy="git config --global http.https://github.com.proxy 'socks5://10.102.1.1:11082'"
alias setgitcaihproxy="git config --global http.https://bitbucket.caih.local.proxy 'socks5://127.0.0.1:21081'"
alias unproxy="unset ALL_PROXY"
alias unsetgitproxy="git config --global --unset https.proxy;git config --global --unset http.proxy"
alias checkip="curl -s http://myip.ipip.net"
alias wgreset="wg-quick down wg0 && mv tmp wg0.conf && wg-quick up wg0"
alias wgup="wg-quick up wg0"
alias wgdown="wg-quick down wg0"
# alias yukari="docker exec phpfpm php artisan mail:send"
alias cc="calicoctl"
alias ectl="etcdctl --ca-file=/var/local/etcd/ssl/ca.pem --cert-file=/var/local/etcd/ssl/peer.pem --key-file=/var/local/etcd/ssl/peer-key.pem --endpoints=https://49.232.142.58:2379,https://94.191.84.201:2379,https://116.85.40.15:2379"
alias pign="ping"
alias cfgctl='confd -onetime -backend etcd -client-ca-keys /var/local/etcd/ssl/ca.pem -client-cert /var/local/etcd/ssl/peer.pem -client-key /var/local/etcd/ssl/peer-key.pem -node https://49.232.142.58:2379'

ssk() {
  if [ "$2"x = x ]; then
    ssh-keygen -f "/root/.ssh/known_hosts" -R $1
  else
    ssh-keygen -f "/root/.ssh/known_hosts" -R \[$1\]:$2
  fi
}

pkall() {
  pkill -kill -t pts/1
  pkill -kill -t pts/2
  pkill -kill -t pts/3
  pkill -kill -t pts/4
  pkill -kill -t pts/5
  pkill -kill -t pts/6
  pkill -kill -t pts/7
  pkill -kill -t pts/8
  pkill -kill -t pts/9
  pkill -kill -t pts/10
  pkill -kill -t pts/11
  pkill -kill -t pts/12
}

alias lsdir="ls -l | grep ^d | awk '{print $NF}'"
alias lsfil="ls -l | grep ^- | awk '{print $NF}'"

alias wifi="nmcli dev wifi"
wificonn() {
  nmcli dev wifi connect $1 password $2
}
alias wifiup="nmcli conn up"

fil() {
  sed -i "$2d" $1 
}

#alias de="docker exec -it $1 /bin/"
#
alias dl='docker logs -f --tail 100'
alias dockerus='docker -H unix:///var/local/dockerd/docker_us/docker.socket'
alias dockerhk='docker -H unix:///var/local/dockerd/docker_hk/docker.socket'
de() {
  docker exec -it $1 /bin/sh
}

denter() {
  nsenter --target $(docker inspect --format '{{.State.Pid}}' $1) -n /bin/bash
}

ds() {
  if [ "$1"x = x ]; then
    docker ps -a;
  else
    docker ps -a | grep $1
  fi
}

t() {
  if [ "$1"x = x ]; then
    tree -L 2
  else
    tree -L $1
  fi
}

pc() {
  netstat -antup | grep $1 | wc -l
}


iperf() {
  if [ "$2"x = x ]; then
    docker run --rm --dns="10.100.1.1" --name=iperf-client networkstatic/iperf3 -c iperf-server.$1.local -p 5201
  else
    docker run --rm --dns="10.100.1.1" --name=iperf-client networkstatic/iperf3 -c iperf-server.$1.local -p 5201 -R
  fi
}

iperf2() {
  if [ "$2"x = x ]; then
    docker run --rm --name=iperf-client networkstatic/iperf3 -c $1 -p 65201
  else
    docker run --rm --name=iperf-client networkstatic/iperf3 -c $1 -p 65201 -R
  fi
}

dip() {
for s in `docker ps -q`; 
do 
  echo `docker inspect -f "{{.Name}}" $s` is "\t\t" `docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $s`; 
done
}

dpid() {
for s in `docker ps -q`; 
do 
  echo `docker inspect -f "{{.Name}}" $s` is "\t\t" `docker inspect -f '{{.State.Pid}}' $s`; 
done
}

dh() {
echo ds="docker ps -a"
echo dc="docker-compose"
echo dg="docker logs -f --tail 30"
echo dr="docker restart"
echo dip="docker get ip"
echo de="docker exec -it \$1 /bin/sh"
}

tcreset(){
  tc qdisc add dev $KELU_IFACE root sfq perturb 5
}

tcls(){
  tc -s qdisc ls dev $KELU_IFACE
}

ifp(){
  iftop -i $KELU_IFACE -BP -f tcp
}

ifm(){
  ifconfig | more
}



checkMedia(){
  bash <(curl -sSL "https://git.io/JswGm")
}


ipt() {
  iptables -F;
  iptables-restore < /etc/iptables.test.rules;
  iptables-save > /etc/iptables.up.rules;
  iptables -L;
}

ipa() {
  ipg $1 | cut -d " " -f 1 | sort -r | xargs -n 1 bash -c 'iptables -D KELU-SS-INPUT "$0"'
  iptables -I KELU-SS-INPUT -p tcp --dport $1 -j DROP
  iptables -I KELU-SS-INPUT -p tcp --dport $1 -m limit --limit 40/s --limit-burst 4000 -j ACCEPT
  iptables -nvL KELU-SS-INPUT --line-numbers | grep $1;
}

ipa0() {
  ipg $1 | cut -d " " -f 1 | sort -r | xargs -n 1 bash -c 'iptables -D KELU-SS-INPUT "$0"'
  iptables -I KELU-SS-INPUT -p tcp --dport $1 -j DROP
  iptables -I KELU-SS-INPUT -p tcp --dport $1 -m limit --limit 9/s --limit-burst 100 -j ACCEPT
  iptables -nvL KELU-SS-INPUT --line-numbers | grep $1;
}

ipa1() {
  ipg $1 | cut -d " " -f 1 | sort -r | xargs -n 1 bash -c 'iptables -D KELU-SS-INPUT "$0"'
  iptables -I KELU-SS-INPUT -p tcp --dport $1 -j DROP
  iptables -I KELU-SS-INPUT -p tcp --dport $1 -m limit --limit 10/s --limit-burst 1000 -j ACCEPT
  iptables -nvL KELU-SS-INPUT --line-numbers | grep $1;
}
ipa2() {
  ipg $1 | cut -d " " -f 1 | sort -r | xargs -n 1 bash -c 'iptables -D KELU-SS-INPUT "$0"'
  iptables -I KELU-SS-INPUT -p tcp --dport $1 -j DROP
  iptables -I KELU-SS-INPUT -p tcp --dport $1 -m limit --limit 20/s --limit-burst 1000 -j ACCEPT
  iptables -nvL KELU-SS-INPUT --line-numbers | grep $1;
}
ipa2() {
  ipg $1 | cut -d " " -f 1 | sort -r | xargs -n 1 bash -c 'iptables -D KELU-SS-INPUT "$0"'
  iptables -I KELU-SS-INPUT -p tcp --dport $1 -j DROP
  iptables -I KELU-SS-INPUT -p tcp --dport $1 -m limit --limit 20/s --limit-burst 2000 -j ACCEPT
  iptables -nvL KELU-SS-INPUT --line-numbers | grep $1;
}


ipa8() {
  ipg $1 | cut -d " " -f 1 | sort -r | xargs -n 1 bash -c 'iptables -D KELU-SS-INPUT "$0"'
  iptables -I KELU-SS-INPUT -p tcp --dport $1 -j DROP
  iptables -I KELU-SS-INPUT -p tcp --dport $1 -m limit --limit 80/s --limit-burst 8000 -j ACCEPT
  iptables -nvL KELU-SS-INPUT --line-numbers | grep $1;
}


ipg() {
  iptables -nvL KELU-SS-INPUT --line-numbers | grep $1;
}

ipd() {
  if [ "$1"x = x ]; then
    iptables -D KELU-SS-INPUT 1
    iptables -D KELU-SS-INPUT 1
    iptables -nvL KELU-SS-INPUT --line-numbers | head;
  else
    iptables -nvL KELU-SS-INPUT --line-numbers | head;
    iptables -D KELU-SS-INPUT $1
  fi
}

ipd2() {
  iptables -D KELU-SS-INPUT 1
  iptables -D KELU-SS-INPUT 1
  iptables -D KELU-SS-INPUT 1
  iptables -D KELU-SS-INPUT 1
  iptables -D KELU-SS-INPUT 1
  iptables -D KELU-SS-INPUT 1
  iptables -D KELU-SS-INPUT 1
  iptables -D KELU-SS-INPUT 1
  iptables -D KELU-SS-INPUT 1
  iptables -D KELU-SS-INPUT 1
  iptables -nvL KELU-SS-INPUT --line-numbers | head;
}

ipaddr() {
  iptables -I INPUT -s $1/32 -j DROP
  iptables -I INPUT -d $1/32 -j DROP
  iptables -I OUTPUT -s $1/32 -j DROP
  iptables -I OUTPUT -d $1/32 -j DROP
}

ipademo() {
  iptables -I INPUT -s $1/32 -p tcp --dport $2 -j ACCEPT
}

ipaddr0() {
  ipg $1 | cut -d " " -f 1 | sort -r | xargs -n 1 bash -c 'iptables -D KELU-SS-INPUT "$0"'
  iptables -I KELU-SS-INPUT -s $1/32 -j DROP
  iptables -I KELU-SS-INPUT -s $1/32 -m limit --limit 10/s --limit-burst 2000 -j ACCEPT
}


ipareset() {
  ipg "30/sec" | cut -d ":" -f 2 | cut -d " " -f 1 | xargs -n 1 bash -c 'source /root/.zshrc && ipa "$0"'
  ipg "20/sec" | cut -d ":" -f 2 | cut -d " " -f 1 | xargs -n 1 bash -c 'source /root/.zshrc && ipa2 "$0"'
  ipg "10/sec" | cut -d ":" -f 2 | cut -d " " -f 1 | xargs -n 1 bash -c 'source /root/.zshrc && ipa1 "$0"'
}

tdump(){
  tcpdump -i $1 port $2 -s 0 -nn -S  -w tcpdump_`hostname`_`date '+%Y-%m-%d_%H:%M'`.cap
}

tardir() {
  dir=${PWD##*/}
  cd ..
  tar -czvf $dir.tgz $dir
  mv $dir.tgz $dir
  cd $dir
}


png2jpg() {
  ls -1 *.png | xargs -n 1 bash -c 'echo $0 && convert "$0" -background white -flatten -alpha off "${0%.png}.jpg"'
  rm -rf *.png
  echo ""
  echo "https://cdn.kelu.org/blog/2020/10/"
  echo ".jpg)"
}

png2jpg2() {
  ls -1 * | xargs -n 1 bash -c 'echo $0 && convert "$0" -background white -flatten -alpha off "${0%}.jpg"'
  mkdir -p ../tmp
  mv *.jpg ../tmp
  rm -rf *
  mv ../tmp/* ./
  rm -rf ../tmp
  echo ""
  echo "https://cdn.kelu.org/blog/2020/10/"
  echo ".jpg)"
}

mergeEmptyLine() {
  sed ':a;$!N;s/^\s*\n\s*$//;ta;P;D' $1 > tmp
  mv tmp $1
  # https://www.thinbug.com/q/24373492
}

pngAddExt() {
  ls |grep -v "\.jpg$" | xargs -n 1 bash -c 'echo $0 && mv "$0" "$0".png'
}
jpgChangeExt() {
  ls -1 *.JPG | xargs -n 1 bash -c 'convert "$0" "${0%.JPG}.jpg"'
}

webpAddExt() {
  ls |grep -v "\.jpg$" | xargs -n 1 bash -c 'mv "$0" "$0".webp'
}

webpRmExt() {
  ls -1 *.webp | xargs -n 1 bash -c 'mv "$0" "${0%.webp}"'
}

webp2png() {
  ls |grep -v "\.jpg$" | xargs -n 1 bash -c 'echo $0 && dwebp "$0" -o "$0".png && rm "$0"'
  # ls -l | grep -v '^d' | grep -v "\.jpg$" | sed '1d' | xargs -n 1 bash -c 'echo $0 && dwebp "$0" -o "$0".png'
}

px() {
  if [ "$1"x = x ]; then
    ps -ef
  else
    echo "UID        PID  PPID  C STIME TTY          TIME CMD"
    ps -ef | grep "$1" | grep -v 'grep'
  fi
}

ra() {
  ranger
}

alias tn='tmux new -s'
alias tll='tmux ls'
alias tt='tmux attach -t'
alias tk='tmux kill-session -t'

prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
  fi
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export SSH_KEY_PATH="~/.ssh/admin@kelu.org"

function collapse_pwd {
  echo $(pwd | sed -e "s,^$HOME,~,")
}

function prompt_char {
  git branch >/dev/null 2>/dev/null && echo '±' && return
  hg root >/dev/null 2>/dev/null && echo '?' && return
  echo 'YUKI.N >'
}

function battery_charge {
  echo `$BAT_CHARGE` 2>/dev/null
}

function virtualenv_info {
  [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function hg_prompt_info {
  hg prompt --angle-brackets "\
< on %{$fg[magenta]%}<branch>%{$reset_color%}>\
< at %{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
%{$fg[green]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
}

PROMPT='
%{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}%m%{$reset_color%} in %{$fg_bold[green]%}$(collapse_pwd)%{$reset_color%}$(hg_prompt_info)$(git_prompt_info)
$(virtualenv_info)$(prompt_char) '

RPROMPT='$(battery_charge)'

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

settrans(){
 TRANSPARENCY_HEX=$(printf 0x%x $((0xffffffff * 70 / 100)))
 if [ -n "$WINDOWID" ]; then
   xprop -id "$WINDOWID" -f _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY "$TRANSPARENCY_HEX"
 else
   windowid=$(xprop -root | grep "_NET_ACTIVE_WINDOW(WINDOW)" | cut -d ' ' -f 5)
   xprop -id "$windowid" -f _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY "$TRANSPARENCY_HEX"
 fi
}
untrans(){
 TRANSPARENCY_HEX=$(printf 0x%x $((0xffffffff * 100 / 100)))
 if [ -n "$WINDOWID" ]; then
   xprop -id "$WINDOWID" -f _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY "$TRANSPARENCY_HEX"
 else
   windowid=$(xprop -root | grep "_NET_ACTIVE_WINDOW(WINDOW)" | cut -d ' ' -f 5)
   xprop -id "$windowid" -f _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY "$TRANSPARENCY_HEX"
 fi
}
