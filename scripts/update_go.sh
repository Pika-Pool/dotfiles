#!/bin/bash

confirm() {
	#Call with a promp string or use default
	read -r -p "${1:-Are you sure? [y/N]} " response
	response=${response,,} # tolower
	if [[ "$response" =~ ^(yes|y)$ ]]
	then
		true
	else
		false
	fi	
}

download() {
	echo "$1$2"
	wget --continue -qO- "$1$2" | tar -xvz -C "/usr/local"
}

DL_HOME=https://golang.org

(confirm "rm -rf /usr/local/go? [y/N]" && rm -rf /usr/local/go) || exit 1

echo "Finding latest version of go for linux AMD64"
DL_PATH_URL="$(wget -qO- $DL_HOME/dl/ | grep -oP '\/dl\/go([0-9\.]+)\.linux-amd64\.tar\.gz' | head -n 1)"
latest="$(echo $DL_PATH_URL | grep -oP 'go[0-9\.]+' | grep -oP '[0-9\.]+' | head -c -2 )"

(confirm "Download and extract latest Go for AMD64: ${latest} at /usr/local/? [y/N]" && download $DL_HOME $DL_PATH_URL) || exit 1

echo "Done!!"
exit 0
