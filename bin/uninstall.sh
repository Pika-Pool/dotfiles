#!/bin/bash

ubuntu() {
	git_credential_manager() {
		git-credential-manager-core unconfigure
		sudo dpkg -r gcmcore
	}

	"$@"
}

"$@"
