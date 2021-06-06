# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

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

if [ -f "$HOME/.cargo/" ] ;
then
    source "$HOME/.cargo/env"
fi

# golang
if [ -d "/mnt/d/DEV/golang-projects" ] ; then
    export GOPATH="/mnt/d/DEV/golang-projects"
fi
if [ -d "$HOME/go" ] ; then
    export GOPATH="$HOME/go;$GOPATH"
fi

# python - pip installs modules here
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$PATH:$HOME/.local/bin"
fi
