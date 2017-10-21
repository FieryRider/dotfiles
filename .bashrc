#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias sudo='sudo '
alias ls='ls --color=auto'
alias ll='ls -hl'
alias la='ls -a'
alias lla='ls -ahl'
alias vi='vim'
alias bell='aplay /home/ivailo/Music/chime.wav'
alias ffmpeg='ffmpeg -hide_banner'
alias ffprobe='ffprobe -hide_banner'
alias qemu-win8='tmux new-session -d -s qemu ~/Stuff/Scripts/qemu-win8-start.sh'
alias kdeshutdown='qdbus org.kde.ksmserver /KSMServer logout 0 2 1' # https://api.kde.org/4.x-api/kde-workspace-apidocs/plasma-workspace/html/namespaceKWorkSpace.html#a0c75f4db070a83b47f0bfc5026383aeb
alias kderestart='qdbus org.kde.ksmserver /KSMServer logout 0 1 1'

PS1='[\u@\h \W]\$ '

if [ "$PS1" ]; then
complete -cf sudo
fi

export EDITOR=vim

gpp () {
	 g++ -o "${1%.*}.out" "$1";
	 ./"${1%.*}.out"
}

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

HISTSIZE=4000
HISTFILESIZE=4000
HISTIGNORE='g++*:gpp:./*.out:vi .bash_history:'
