#-------EXPORTS-------#
export EDITOR=vim
# XDG Base Directory Spec
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share
## IntelliJIdea config dirs
export IDEA_PROPERTIES="$XDG_CONFIG_HOME"/IntelliJIdea/idea.properties
export IDEA_VM_OPTIONS="$XDG_CONFIG_HOME"/IntelliJIdea/idea.vmoptions
## NPM config dir
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
## Nuget config dir
export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages
## MPlayer config dir
export MPLAYER_HOME="$XDG_CONFIG_HOME"/mplayer
## Kodi config dir
export KODI_DATA="$XDG_DATA_HOME"/kodi
## GnuPG
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
## Mtools
export MTOOLSRC="$XDG_CONFIG_HOME"/mtools

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
# QT5 theme for GTK
#export QT_STYLE_OVERRIDE=adwaita-dark
export QT_STYLE_OVERRIDE=kvantum
export DOTNET_CLI_TELEMETRY_OPTOUT=1

