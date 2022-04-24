#!/bin/bash

dotfiles_path="$HOME/.dotfiles"

confirm() {
	question=${1:-"Are you sure?[Y/n]"}
	# read store result in $REPLY
	REPLY=${REPLY:-Y}

	read -p "$question" -r
	echo # (optional) move to a new line

	if [[ $REPLY =~ ^[Yy]$ ]]; then
		return 0
	else
		return 1
	fi
}

reload_shell() {
	if [ -n "$BASH_VERSION" ]; then
		echo "its bash"
		exec bash
	elif [[ "$SHELL" =~ "zsh" ]]; then
		echo "its zsh"
		exec zsh
	fi
}

ubuntu() {
	packages_to_install=(gnome-tweaks mlocate)

	create_symlinks() {
		declare -A dict
		dict=(
			['zsh/zshrc']="$HOME/.zshrc"
			['bashrc']="$HOME/.bashrc"
			['bash_aliases']="$HOME/.bash_aliases"
			['gitconfig_popos']="$HOME/.gitconfig"
			['profile_popos']="$HOME/.profile"
			['npmrc_popos']="$HOME/.npmrc"
			['vim']="$HOME/.vim"
			['bin']="$HOME/bin"
			['zsh/starship.toml']="${STARSHIP_CONFIG:-"$HOME/.config/starship.toml"}"
			['zsh/plugins']="$dotfiles_path/zsh/ohmyzsh/custom/plugins"
			['zsh/themes']="$dotfiles_path/zsh/ohmyzsh/custom/themes"
		)

		confirm_overwrite() {
			confirm "Are you sure you want to overwrite $1?[Y/n]"
		}

		for i in "${!dict[@]}"; do
			if confirm_overwrite "${dict[$i]}"; then
				rm -rf "${dict[$i]}"
				ln -s "$dotfiles_path/$i" "${dict[$i]}"
			fi
		done
	}

	fonts() {
		dest_dir="$HOME/.local/share/fonts"
		mkdir -p "$dest_dir"

		local base_url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download"
		local fonts_list=(FiraMono JetBrainsMono)

		for font_name in "${fonts_list[@]}"; do
			echo -e "Installing $font_name font\n"

			local font_dir="/tmp/$font_name"
			local font_file_name="/tmp/$font_name.zip"

			curl -L -o "$font_file_name" "$base_url/$font_name.zip"

			if [ "$font_name" = "JetBrainsMono" ]; then
				unzip "$font_file_name" -d "$font_dir"
			else
				unzip -j "$font_file_name" "*.otf" -d "$font_dir"
			fi

			# sometimes mv doesn't work, don't lose the zip file
			mv "$font_dir"/* "$HOME/.local/share/fonts/" && rm "$font_file_name"

			echo
		done
	}

	latest_git() {
		sudo add-apt-repository ppa:git-core/ppa
		packages_to_install+=(git)
	}

	latest_vim() {
		sudo add-apt-repository ppa:jonathonf/vim
		packages_to_install+=(vim)
	}

	vscode() {
		# taken from https://code.visualstudio.com/docs/setup/linux
		# install repo and key
		sudo apt-get install wget gpg
		wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
		sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
		sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
		rm -f packages.microsoft.gpg

		# install vscode
		packages_to_install+=(apt-transport-https code)
	}

	keepassxc_install() {
		# taken from https://keepassxc.org/download/#linux > https://launchpad.net/~phoerious/+archive/ubuntu/keepassxc
		sudo add-apt-repository ppa:phoerious/keepassxc

		packages_to_install+=(keepassxc)
	}

	firefox_dev() {
		# taken from https://www.mozilla.org/en-US/firefox/developer/
		sudo rm -d /opt/firefox_dev/
		sudo mkdir /opt/firefox_dev &&
			wget -qO- "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US" |
			sudo tar xvj -C /opt/firefox_dev --strip-components=1

		ln -s ~/.dotfiles/extra_or_template_files/firefox_dev.desktop ~/.local/share/applications/firefox_dev.desktop
	}

	node_nvm() {
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

		reload_shell

		nvm install --lts --latest-npm
		nvm use --lts
	}

	throttle_battery_charge() {
		#write out current crontab
		sudo crontab -l >/tmp/mycron

		#echo new cron into cron file
		echo "@reboot echo 60 | tee /sys/class/power_supply/BAT0/charge_control_end_threshold" | sudo tee -a mycron

		#install new cron file
		crontab mycron

		# cleanup
		rm /tmp/mycron
	}

	rust_install() {
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
		reload_shell
	}

	bat_install() {
		cargo install bat
	}

	zsh_init() {
		sudo apt update && sudo apt install zsh
		chsh -s $(which zsh)
	}

	starship_init() {
		cargo install starship --locked
		exec zsh
	}

	install_packages() {
		if [ ${#packages_to_install[@]} -ne 0 ]; then
			sudo apt update &&
				sudo apt install "${packages_to_install[@]}"
		fi
	}

	if [ "$#" -ne 0 ]; then
		"$@"

	else
		create_symlinks
		echo

		latest_git
		echo

		vscode
		echo

		keepassxc_install
		echo

		firefox_dev
		echo

		node_nvm
		echo

		throttle_battery_charge
		echo

		rust_install
		echo

		bat_install
		echo
	fi

	# echo # new line
	# install_packages
}

"$@"
