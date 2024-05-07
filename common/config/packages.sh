#!/bin/bash

# PACKAGES_DEVELOPMENT array
#
# Description: List of development packages to be installed.
PACKAGES_DEVELOPMENT=(
	"docker.io"
	"docker-compose"
	"python3-pip"
)

# PACKAGES_PIP array
#
# Description: List of Python packages to be installed via pip.
PACKAGES_PIP=(
	"ansible"
	"markupsafe"
)

# PACKAGES_OPTIONAL array
#
# Description: List of optional packages to be installed.
PACKAGES_OPTIONAL=(
	"neofetch"
	"cowsay"
	"btop"
	"zip"
	"unzip"
)
