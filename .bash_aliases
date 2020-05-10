####### Alias definitions. #######
alias sudo='sudo '
alias ls='ls --color=auto'
alias ll='ls -hl'
alias la='ls -a'
alias lla='ls -ahl'
alias grep='grep --color'
alias vi='vim'
alias ps_mem='command sudo ps_mem'
alias bell='aplay ~/Music/chime.wav'
alias ffmpeg='ffmpeg -hide_banner'
alias ffprobe='ffprobe -hide_banner'
alias start-win10="systemctl --user restart synergys && virsh -c 'qemu:///system' start Windows10"
alias kdeshutdown='qdbus org.kde.ksmserver /KSMServer logout 0 2 1' # https://api.kde.org/4.x-api/kde-workspace-apidocs/plasma-workspace/html/namespaceKWorkSpace.html#a0c75f4db070a83b47f0bfc5026383aeb
alias kderestart='qdbus org.kde.ksmserver /KSMServer logout 0 1 1'
alias dotnet='TERM=xterm dotnet'
alias rvim='vim -R'
