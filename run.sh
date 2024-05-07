#!/bin/bash

# Source the necessary scripts
source "$(dirname "$0")/commands/build.sh"
source "$(dirname "$0")/commands/dependencies.sh"

run_help() {
	# run_help function
	#
	# Description: Displays usage instructions for the script.
	#
	# Parameters: None

	echo ""
	echo "Usage: ./run.sh [command] [arguments]"
	echo ""
	echo "Commands:"
	echo "	build"
	echo "	dependencies"
	echo ""
	echo "Arguments:"
	echo "	-h, --help	Show this help message and exit."
}

# Case statement to handle different commands
case "$1" in
	"build")
		build "$@"
		exit
		;;
	"dependencies")
		dependencies "$@"
		exit
		;;
	"--help" | "-h")
		run_help
		exit
		;;
esac

# If no valid command is provided, display usage instructions
run_help
