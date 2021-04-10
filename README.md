> install script doesn't work yet

## Installation
- Clone this repository
```shell
git clone --recurse-submodules --shallow-submodules -j8 --depth=1 https://github.com/Pika-Pool/dotfiles.git ~/.dotfiles
```
<sup>Note: `-j8` is an optional performance optimization that became available in version 2.8, and fetches up to 8 submodules at a time in parallel — see man `git-clone`.</sup>

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
