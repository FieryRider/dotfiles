
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

####### Alias definitions. #######
alias sudo='sudo '
alias ls='ls --color=auto'
alias ll='ls -hl'
alias la='ls -a'
alias lla='ls -ahl'
alias vi='vim'
alias bell='aplay ~/Music/chime.wav'
alias ffmpeg='ffmpeg -hide_banner'
alias ffprobe='ffprobe -hide_banner'
alias start-win10="systemctl --user restart synergys && virsh -c 'qemu:///system' start Windows10"
alias kdeshutdown='qdbus org.kde.ksmserver /KSMServer logout 0 2 1' # https://api.kde.org/4.x-api/kde-workspace-apidocs/plasma-workspace/html/namespaceKWorkSpace.html#a0c75f4db070a83b47f0bfc5026383aeb
alias kderestart='qdbus org.kde.ksmserver /KSMServer logout 0 1 1'

# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

if [ "$PS1" ]; then
  complete -cf sudo
fi

####### Exports #######
export EDITOR=vim
# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
##### End Exports #####

# append to the history file, don't overwrite it / combine histories from all terminal sessions
shopt -s histappend
# check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

if [ ! -v TERM_EMU ]; then
  TERM_EMU=$(ps -o comm= $(ps -o ppid= $$))
fi

####### Functions #######
[[ $(cat /etc/*-release | grep 'NAME') == *"Debian"* ]] && release_debian=true || release_debian=false
[[ $(cat /etc/*-release | grep 'NAME') == *"Ubuntu"* ]] && release_ubuntu=true || release_ubuntu=false
[[ $(cat /etc/*-release | grep 'NAME') == *"Arch Linux"* ]] && release_arch=true || release_arch=false

if $release_arch; then
  sdserver() {
    sudo umount -R /mnt/server/*;
    sudo umount -R /mnt/server;
    command ssh ivailo@server "sudo poweroff"
  }

  mount-encr() {
    sudo cryptsetup --type luks open /dev/sdb4 encr;
    sudo mount /dev/mapper/encr /mnt/encr/
  }

  umount-encr() {
    sudo umount /mnt/encr/;
    sudo cryptsetup close /dev/mapper/encr;
  }
fi

if $release_debian || $release_ubuntu ; then
  update() {
    if sudo apt update; then
      if sudo apt upgrade; then
        sudo apt full-upgrade
      fi
    fi
  }
fi

ssh() {
  local remote; local options; local ssh_command; local remote_added=false

  for arg in "$@"; do
    if [[ $arg = *"@"* ]]; then
      remote="$arg"
      remote_added=true
    else
      if [[ "$remote_added" = true ]]; then
        ssh_command="$arg"
      else
        if [[ "$arg" != "-t" ]]; then
          options+="$arg "
        fi
      fi
    fi
  done
  options+="-t"
  command ssh $options $remote 'bash -l -c "export TERM_EMU='$TERM_EMU'; bash $ssh_command"'
}

iptables-off() {
  sudo iptables -X
  sudo iptables -F
  sudo iptables -P FORWARD ACCEPT
  sudo iptables -P INPUT ACCEPT
  sudo iptables -P OUTPUT ACCEPT
}

gpp() {
  if g++ -o "${1%.*}.out" "$1"; then
    ./"${1%.*}.out"
  fi
}

mednafen() {
  args="${@:1:$(($#-1))}"
  file="${@: -1}"
  if [[ "$file" =~ .*\.7z ]]; then
    file_name=$(basename "$file")
    game_name=${file_name%*.7z}
    7z x -o/tmp/"$game_name" "$file"

    # If there isn't a .cue file, pick one from EU .cue files collection or create one
    if ! ls /tmp/"$game_name"/*.cue > /dev/null 2>&1; then
      cue_file=$(find $PSX_GAMES/ -name "$game_name.cue" -print -quit)
      if [[ -z "$cue_file" ]]; then
        cue_file=$(find $PSX_GAMES/ -iname "${game_name/(Europe)/(E)}"*.cue -print -quit)
      fi
      if [[ -z "$cue_file" ]]; then
        echo 'No .cue file available. Please specify a path to .cue file or leave black to create one (might not work)'
        read -r cue_file
      fi
      if [[ -e $cue_file ]]; then
        cp "$cue_file" /tmp/"$game_name"/"$game_name".cue
      fi

      # Create .cue file
      if [[ -z "$cue_file" ]]; then
        bin_file=''
        # If there are multiple bin files pick the one with the game (Track 1)
        if [[ $(ls -1 /tmp/"$game_name"/*.bin | wc -l) -gt 1 ]]; then
          for f in /tmp/"$game_name"/*.bin; do
            if [[ "$f" = *"(Track 1)"* ]]; then
              bin_file="$f"
              break
            fi
          done
        else
          bin_file=$(basename /tmp/"$game_name"/*.bin)
        fi
        cat > /tmp/"$game_name"/"$game_name".cue << EOF
FILE "$bin_file" BINARY
TRACK 01 MODE2/2352
INDEX 01 00:00:00
EOF
      fi
    fi

    command mednafen /tmp/"$game_name"/*.cue
    rm -r /tmp/"$game_name"
  elif [[ "$file"  =~ .*\.cue ]]; then
    command mednafen "$args" "$file"
  fi
}

backup-chromium() {
  local backups; local num_of_backups; local num_backups_to_delete

  for d in ~/bkp/chromium*; do
    backups+=($d)
  done
  num_of_backups=${#backups[@]}

  if [[ $num_of_backups -gt 7 ]]; then
    num_backups_to_delete=$(( $num_of_backups - 7 ))
    while [[ $num_backups_to_delete -gt 0 ]]; do
      rm -r "${backups[0]}"
      (( num_backups_to_delete-- ))
    done
  fi

  while pgrep chromium; do
    sleep 4
  done
  cp -a ~/.config/chromium ~/bkp/chromium_$(date +%F_%H:%M)
}

backup-firefox() {
  local backups; local num_of_backups; local num_backups_to_delete

  for d in ~/bkp/mozilla*; do
    backups+=($d)
  done
  num_of_backups=${#backups[@]}

  if [[ $num_of_backups -gt 7 ]]; then
    num_backups_to_delete=$(( $num_of_backups - 7 ))
    while [[ $num_backups_to_delete -gt 0 ]]; do
      rm -r "${backups[0]}"
      (( num_backups_to_delete-- ))
    done
  fi

  while pgrep firefox; do
    sleep 4
  done
  cp -a .mozilla bkp/mozilla_$(date +%F_%H:%M)
}

sync-keepass-passwords() {
  while IFS= read -r -d $'\0'; do
    dbFiles+=("$REPLY")
  done < <(find /run/media/$USER -iname casual.kdbx -print0)

  newestDB="${dbFiles[0]}"
  for x in "${dbFiles[@]}"; do
    [[ "$x" -ot "$newestDB" ]] || newestDB="$x"
  done

  for x in "${dbFiles[@]}"; do
    if [[ "$newestDB" != "$x" ]]; then
      cp "$newestDB" "$x"
    fi
  done
}

##### End Functions #####

PATH=$PATH:~/.android/platform-tools/:~/.android/tools/
HISTSIZE=4000
HISTFILESIZE=4000
HISTTIMEFORMAT="%d/%m/%y %T "
HISTIGNORE='&:vi .bash_history:vi ~/.bash_history:set +o history:'
HISTCONTROL=ignoreboth
