# globals
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
USER=`whoami`
BASEDIR=~/dotfiles
DOTDIR=~/dotfiles/dotfiles
ZSHDIR=~/.oh-my-zsh
TMUXINATORDIR=~/.tmuxinator


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# aliases
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
alias vim='nvim'
alias vpc='vim +PluginClean'
alias vpi='vim +PluginInstall'
alias rdb='envd ./manage.py drop_test_database --noinput'
alias vgs='vagrant global-status'
alias tv='tmuxinator vdrome'
alias tg='tmuxinator ghc'
alias etg='vim $TMUXINATORDIR/ghc.yml'
alias cenv='python -m venv .venv'
alias aenv='. .venv/bin/activate'
alias ppjson="python -m json.tool"
alias pyclean='killpyc && killpycache'
alias killpyc='find . -name \*.pyc -delete'
alias killpycache='find . -name __pycache__ -delete'
alias termupd='sudo update-alternatives --config x-terminal-emulator'
alias rem='remind ~/.reminders'
alias djm='./manage.py migrate'
alias djmm='./manage.py makemigrations'
alias djs='./manage.py shell_plus'
alias djr='./manage.py runserver'
alias whereis2='dpkg -L'
alias df='df -aH .'
alias p8='ping 8.8.8.8'
alias la='ls -FCA --color=tty'
alias s='ls'
alias rm='rm -I'
alias rmr='rm -rI'
alias e='exit'
alias g='grep'
alias gi='grep -i'
alias gr='grep -R'
alias gir='grep -iR'
alias mv='mv -i'
alias v='vim'
alias mk='mkdir'
alias x='extract'
alias ssheval='eval `ssh-agent -s`'
alias nx='PATH=$(npm bin):$PATH'
alias irssi='TERM=screen-256color irssi'
alias dall='dpkg --get-selections'
alias geml='gem list --local'
alias vssh='vagrant ssh'
alias vup='vagrant up'
alias -g L='| less'
alias -g H='| head'
alias -g S='| sort'
alias -g T='| tail'
alias -g SO='1> /dev/null'
alias -g SE='2> /dev/null'
alias aptar='sudo apt-get -y autoremove'
alias aptcl='sudo apt-get -y autoclean && sudo apt-get -y clean'
alias aptup='sudo apt-get update'
alias aptin='sudo apt-get -y install'
alias aptr='sudo apt-get -y remove'
alias aptp='sudo apt-get -y purge'
alias apti='sudo apt-get -y install'
alias aptupg='sudo apt-get -y upgrade'
alias apts='apt-cache search'
alias aptsh='apt-cache show'
alias epp='echo $PYTHONPATH'
alias dotf='cd $DOTDIR/..'
alias ev='vim ~/.nvimrc'
alias et='vim ~/.tmux.conf'
alias ei='vim ~/.irssi/config'
alias ez='vim ~/.zshrc'
alias ea='vim $DOTDIR/alias.zsh'
alias sz='source ~/.zshrc'
alias grm='git rebase master'
alias grc='git rebase --continue'
alias gdel='git status -s | cut -c4- | xargs rm -r $1'
alias gcf='git commit --fixup'
alias graq='git rebase -i --autosquash'
alias gfu='git push -f'
alias gi='git init'
alias gst='git status'
alias gs='git status -sb'
alias gla="git log --all --graph \
           --pretty=format:'%Cred%h%Creset \
           -%C(yellow)%d%Creset %s %Cgreen(%cr) \
           %C(bold blue)<%an>%Creset' \
           --abbrev-commit --date=relative"
alias ga='git add'
alias gb='git branch'
alias gow='git show'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gbr='git branch -r'
alias gba='git branch -a'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gd='git diff'
alias go='git checkout'
alias gob='git checkout -b'
alias gh='git hist'
alias gcl='git clone'
alias gra='git remote add'
alias grr='git remote rm'
alias gms='git merge --squash'
alias gr='git remote'
alias grv='git remote -v'
alias gp='git push'
alias gpu='git push -h'
alias gp='git push'
alias gpo='git push origin master'
alias gher='git push heroku master'
alias gpu='git pull upstream master'
alias gpl='git pull --rebase'
alias gplu='git pull -u --rebase'
alias gam='git commit --amend'
alias gamm='git commit --amend -m'
alias gl='git log'
alias gcv='git cherry -v'
alias gcp='git cherry-pick'
alias gundo='git reset --soft HEAD'
alias gundoh='git reset --hard HEAD'
alias gun='git ls-files --others --exclude-standard'
alias gcn='git shortlog -s -n'
alias .a='git add . --all'
alias .c='git add --all && git commit -v'
alias tmux='tmux -2'
alias ta='tmux attach -t'
alias tnew='tmux new -s'
alias tls='tmux ls'
alias tkill='tmux kill-session -t'
alias eT='vim $HOME/todo.md'

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# functions
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
f(){
    # quick find. Takes one parameter - the search term
    echo "find . -iname \"*$1*\""
    sudo find . -iname "*$1*"
}

extract (){
    # never forget how to run a tar xyz command again
    # alias to 'x' for even more tastyness
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1;;
            *.tar.gz)    tar xzf $1;;
            *.bz2)       bunzip2 $1;;
            *.rar)       rar x $1;;
            *.gz)        gunzip $1;;
            *.tar)       tar xf $1;;
            *.tbz2)      tar xjf $1;;
            *.tgz)       tar xzf $1;;
            *.zip)       unzip $1;;
            *.Z)         uncompress $1;;
            *.7z)        7z x $1;;
            *.xz)        tar xf $1;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# get public ip
# souce: https://github.com/jleclanche/dotfiles/blob/master/.zshrc#L281
function myip {
    local api
    case "$1" in
        "-4")
            api="http://v4.ipv6-test.com/api/myip.php"
            ;;
        "-6")
            api="http://v6.ipv6-test.com/api/myip.php"
            ;;
        *)
            api="http://ipv6-test.com/api/myip.php"
            ;;
    esac
    curl -s "$api"
    echo # Newline.
}

function getpr() {
    # quickly pull down a pull request, create a branch and check it out
    git fetch upstream pull/$1/head:"pr_$1" && git checkout "pr_$1"
}

function docker-cleanup() {
    # kill all docker images/containers
    docker rmi $(docker ps -qa)
    docker rmi $(docker images -qa)
}

function gri() {
    # fire up an interactive rebase back $1 commits
    git rebase -i HEAD~$1
}


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# lock8 aliases and functions
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
function testlogs(){
    awslogs get --watch docker/test | awk '$2 = substr($2, 1, 12)'
}

function prodlogs(){
    awslogs get --watch docker/prod | awk '$2 = substr($2, 1, 12)'
}

alias ssht1='ssh ubuntu@52.16.11.86'
alias ssht2='ssh ubuntu@52.18.79.179'
alias sshsm='ssh ubuntu@saltmaster.lock8.me'
alias sshpw='ssh ubuntu@54.154.235.63'
alias sshp1='ssh ubuntu@52.48.103.144'
alias tmn='envd ptw velodrome -- --testmon -s -p no:sugar'
alias etv='vim $TMUXINATORDIR/vdrome.yml'
alias pxv='envd py.test -x -vv'
alias px='envd py.test -x'
alias pxs='envd py.test -xs'
alias pks='envd py.test -sk'
alias envd='envdir envdir/'
