
# bash aliases 

# monitor control 

function brt () {
  if [[ ! -z $2 ]]; then
    brt-one $1 $2
    return 0
  fi 
  if [[ -z $1 ]]; then
    printf "Usage:\nbrt-all brightness[0-100]\n"
    ddcutil --display 1 getvcp 10
    return 1
  fi
  local brightness=${1:-50}
  local monitors=$( ddcutil detect | grep -Po "Display \d" | wc -l )
  for i in $(seq 1 $monitors );do 
    echo "ddcutil --display $i setvcp 10 $brightness"
    echo "Current brightness:"
    ddcutil --display $i setvcp 10 $brightness >/dev/null
  done
}

function brt-one () {
  local monitor=$1
  local brightness=$2
  if [[ -z "$2"  ]] || [[ -z "$1" ]]; then 
    printf "Usage:\nbrt monitor[1-9] brightness[0-100]\n"
    printf "monitors: \n$( ddcutil detect | grep -Po "Display \d")\n"
    printf "Current brightness:\n"
    ddcutil --display "${1:-1}" getvcp 10
    return 1
  fi 
  echo "ddcutil --display $monitor setvcp 10 $brightness"
  ddcutil --display $monitor setvcp 10 $brightness
}

function contrast() {
  if [[ -z $1 ]]; then
    printf "Usage:\n$0 contrast[0-100]\n"
    ddcutil --display 1 getvcp 12
    return 1
  fi
  local cont=${1:-50}
  local monitors=$( ddcutil detect | grep -Po "Display \d" | wc -l )
  for i in $(seq 1 $monitors );do
    echo "ddcutil --display $i setvcp 12 $cont"
    echo "Current Contrast: "
    ddcutil --display $i setvcp 12 $cont
  done
}

function monitor-input-switch () {
  local monitor=$1
  local source=$2
  local vcp_code="60"
  if  [[ -z $1 ]]; then
    printf "Usage: \n$0 monitor[0-9] source['HDMI', 'DP']\n"
    return 1
  fi 
  case $source in 
    "HDMI"|"hdmi"|"hd")
       source="0x11" ;;
    "DP"|"dp")
       source="0x0f" ;;
    "off") 
       vcp_code="D6"
       source="4"    ;;
    "on")
       vcp_code="D6"
       source="1"    ;;
    *)
       source="0x0f" ;;
  esac
  ddcutil --display $monitor setvcp $vcp_code $source
}

alias monitor-work="monitor-input-switch 1 hdmi; monitor-input-switch 2 hdmi"
alias monitor-left-work="monitor-input-switch 1 hd; monitor-input-switch 2 dp"
alias monitor-home="monitor-input-switch 1 dp; monitor-input-switch 2 dp"


# git 
alias gs="git status"
alias gp="git push"
alias gcm="git commit -m"
alias gpf="git push -f"
alias gco="git checkout"
alias gcb="git checkout -b"
alias grc="git rebase --continue"
alias gra="git rebase --abort"
alias gfa="git fetch --all"
alias gpl="git pull"
alias gca="git commit --amend"
alias gcaa="git commit --amend --no-edit"
alias ga="git add"
alias gaa="git add --update"
alias gr="git restore"
alias grs="git restore --staged"

# docker 
alias d="docker"
alias dc="docker compose"
alias dci="docker images -a"
alias dps="docker ps -a"

## ======================
## python 
# activate python virtual environment in current directory, or asks to create one if doesnt already exist
function activ-py () {
  if [[ -f ".venv/bin/activate" ]]; then
    source .venv/bin/activate
  else
    echo "Could not find dir .venv, Create? [y/n]"
    read -r CREATE
    if [[ $CREATE == "y" ]]; then 
      python3 -m venv .venv
      source .venv/bin/activate
    fi
  fi
}

alias py="python3"

# linux audio 
alias pipewire-restart="systemctl --user restart pipewire pipewire-pulse"

# mosh 
alias msh='mosh --no-init --ssh="ssh -p 22"'