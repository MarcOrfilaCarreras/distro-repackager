#!/bin/bash

build_help() {
	# build_help function
	#
	# Description: Displays usage instructions for the build command.
	#
	# Parameters: None

	echo ""
	echo "Usage: ./run.sh build [arguments]"
	echo ""
	echo "Arguments:"
	echo "	-d, --distro	Specify the distribution name."
	echo "	-v, --version	Specify the version of the distribution."
	echo "	-h, --help	Show this help message and exit."

	exit 0
}

build_run() {
	# build_run function
	#
	# Description: Runs the appropriate apply.sh file based on the specified distribution and version.
	#
	# Parameters:
	#   - distribution: The distribution name.
	#   - version: The version of the distribution.

	local distribution="$1"
	local version="$2"

	# Check if the apply.sh file exists for the specified distribution and version
	if ! [ -f "$(dirname "$0")/distros/$distribution/$version/apply.sh" ]; then
		echo ""
		echo "ERROR: The specified distribution version is not available !"

		exit 1
	fi

	# Source the apply.sh file and run the apply function
	source "$(dirname "$0")/distros/$distribution/$version/apply.sh"
	apply "$(dirname "$0")/distros/$distribution/$version"
}

build() {
	# build function
	#
	# Description: Parses command line arguments for the build command and initiates the build process.
	#
	# Parameters: None

	local distribution
	local version

	# Parse command line arguments
	while [[ $# -gt 0 ]]; do
		case "$1" in
			"--distro" | "-d")
				shift
				distribution="$1"
				;;
			"--version" | "-v")
				shift
				version="$1"
				;;
			"--help" | "-h")
				build_help
				;;
		esac
		shift
	done

	# Check if distribution name is provided
	if ! [ -n "$distribution" ]; then
		echo ""
		echo "ERROR: You must specify the distribution name !"

		exit 1
	fi

	# Check if version is provided
	if ! [ -n "$version" ]; then
		echo ""
        echo "ERROR: You must specify the version of the distribution !"

		exit 1
	fi

	# Check if the script is run as root
    if [ "$(id -u)" -ne 0 ]; then
		echo ""
        echo "ERROR: Run this script with sudo or as root."
        exit 1
    fi

	# Call build_run function with provided distribution and version
	build_run "$distribution" "$version"
}
