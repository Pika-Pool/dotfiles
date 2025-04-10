# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# check if as per XDG Base Directory Specification, config home is set
# otherwise, use ~/.config
config_home="${XDG_CONFIG_HOME:-~/.config}"

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
# python - pip seems to install modules here
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes go-lang executables
if [ -d "/usr/local/go/bin" ] ;
then
    PATH="$PATH:/usr/local/go/bin";
#else
#    echo "'/usr/local/go/bin not found'  -  error in $HOME/.profile"
fi

# set PATH so it includes premake5
if [ -f "/opt/premake5" ] ;
then
    PATH="$PATH:/opt/";
#else
#    echo "'/opt/premake5' not found  -  error in $HOME/.profile"
fi

export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

# rust
if [ -f "$HOME/.cargo/" ] ; then
    . "$HOME/.cargo/env"
fi

# golang
if [ -d "/mnt/d/DEV/golang-projects" ] ; then
    export GOPATH="/mnt/d/DEV/golang-projects"
fi
if [ -d "$HOME/go" ] ; then
    export GOPATH="$HOME/go;$GOPATH"
fi
if [ -d "/usr/local/go/bin" ]; then
    export PATH="$PATH:/usr/local/go/bin"
fi

# nvm for linux
export NVM_DIR="$config_home/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

