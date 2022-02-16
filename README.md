## Installation
- Clone this repository(make sure its in ~/.dotfiles/ if using ./install)
```shell
git clone --recurse-submodules --shallow-submodules -j8 --depth=1 https://github.com/Pika-Pool/dotfiles.git ~/.dotfiles
```
<sup>Note: `-j8` is an optional performance optimization that became available in version 2.8, and fetches up to 8 submodules at a time in parallel — see man `git-clone`.</sup>

## Update submodules
```sh
git submodule update --init --recursive --remote
```
> Note: `--remote` is required to pull the latest commit from upstream

- Create symbolic links according to the following:

| Source    	| Target       	| Note                            	|
|-----------	|--------------	|---------------------------------	|
| bashrc    	| ~/.bashrc    	|                                 	|
| vim       	| ~/.vim       	|                                 	|
| profile   	| ~/.profile   	|                                 	|
| gitconfig 	| ~/.gitconfig 	| Change user.email and user.name 	|
- while creating symlinks using `ln -s`, use the full absolute path
	``` shell
	ln -s ~/.dotfiles/.bashrc ~/.bashrc
	```
