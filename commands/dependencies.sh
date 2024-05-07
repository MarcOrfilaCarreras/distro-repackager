#!/bin/bash

dependencies_help() {
	# dependencies_help function
	#
	# Description: Displays usage instructions for the dependencies command.
	#
	# Parameters: None

	echo ""
	echo "Usage: ./run.sh dependencies [arguments]"
	echo ""
	echo "Arguments:"
	echo "	-i, --install	Install the dependencies."
	echo "	-h, --help	Show this help message and exit."

	exit 0
}

dependencies_run() {
	# dependencies_run function
	#
	# Description: Installs the necessary dependencies.
	#
	# Parameters: None

	 # Check if the script is run as root
    if [ "$(id -u)" -ne 0 ]; then
		echo ""
        echo "ERROR: Run this script with sudo or as root."
        exit 1
    fi

	# Install necessary dependencies
	apt update -y
	apt install -y \
		p7zip-full \
		git \
		genisoimage \
		fakeroot \
		pwgen \
		whois \
		xorriso \
		isolinux \
		binutils \
		squashfs-tools
}

dependencies() {
	# dependencies function
	#
	# Description: Parses command line arguments for the dependencies command and initiates dependency installation.
	#
	# Parameters: None

	# Parse command line arguments
	while [[ $# -gt 0 ]]; do
		case "$1" in
			"--install" | "-i")
				dependencies_run
				exit 0
				;;
			"--help" | "-h")
				build_help
				;;
		esac
		shift
	done

	# If no valid command is provided, display usage instructions
	dependencies_help
}
