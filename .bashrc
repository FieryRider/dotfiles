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
alias qemu-win8='tmux new-session -d -s qemu ~/Stuff/Scripts/qemu-win8-start.sh'
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

####### Functions #######
if [[ $(uname -a) == *"apparmor"* ]] || [[ $(uname -a ) == *"ARCH"* ]]; then
	sdserver () {
		sudo umount -R /mnt/server/*;
		sudo umount -R /mnt/server;
		ssh ivailo@ivailoserv.fierydom "sudo poweroff"
	}

	mount-encr () {
		sudo cryptsetup --type luks open /dev/sda4 encr;
		sudo mount /dev/mapper/encr /mnt/encr/
	}

	umount-encr () {
		sudo umount /mnt/encr/;
		sudo cryptsetup close /dev/mapper/encr;
	}

	gpu-vfio () {
		sudo mv /etc/modprobe.d/vfio.conf.bak /etc/modprobe.d/vfio.conf
		sudo mv /etc/modules-load.d/vfio.conf.bak /etc/modules-load.d/vfio.conf
	}

	gpu-nvidia () {
		sudo mv /etc/modprobe.d/vfio.conf /etc/modprobe.d/vfio.conf.bak
		sudo mv /etc/modules-load.d/vfio.conf /etc/modules-load.d/vfio.conf.bak
	}
fi

if [[ $(uname -a) == *"Debian"* ]]; then
	update () {
        if sudo apt update; then
                if sudo apt upgrade; then
                        sudo apt dist-upgrade
                fi
        fi
	}
fi

iptables-off () {
	sudo iptables -X
	sudo iptables -F
	sudo iptables -P FORWARD ACCEPT
	sudo iptables -P INPUT ACCEPT
	sudo iptables -P OUTPUT ACCEPT
}

gpp () {
	 g++ -o "${1%.*}.out" "$1";
	 ./"${1%.*}.out"
}

backup-chromium () {
	rm -r /home/ivailo/bkp/chromium.old
	mv /home/ivailo/bkp/chromium /home/ivailo/bkp/chromium.old
	cp -r /home/ivailo/.config/chromium /home/ivailo/bkp/
}

sync-keepass-passwords () {
	while IFS= read -r -d $'\0'; do dbFiles+=("$REPLY"); done < <(find /run/media/ivailo -iname casual.kdbx -print0)
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

HISTSIZE=4000
HISTFILESIZE=4000
HISTIGNORE='g++*:gpp:./*.out:vi .bash_history'
HISTCONTROL=ignoreboth
