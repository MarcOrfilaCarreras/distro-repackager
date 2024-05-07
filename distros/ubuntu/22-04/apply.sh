#!/bin/bash

install_packages() {
    # install_packages function
    #
    # Description: Installs packages, including those defined in packages.sh and other_packages.sh,
    # Visual Studio Code, Brave Browser, and Tailscale.
    #
    # Parameters:
    #   - base_path: The base path where the ISO and extracted files are located.

	local base_path="$1"

    # Source package lists
	source "$(dirname "$0")/common/config/packages.sh"
    source "$(dirname "$0")/common/config/other_packages.sh"

	echo "INFO: Installing packages."

    # Add repositories
    chroot "$base_path/cache/squashfs-root/" /bin/bash -c "add-apt-repository universe -y"
    chroot "$base_path/cache/squashfs-root/" /bin/bash -c "add-apt-repository multiverse -y"

    # Update package list
    chroot "$base_path/cache/squashfs-root/" /bin/bash -c "apt-get update -y"

    # Install optional and development packages
    command="apt-get install -y"
    for package in "${PACKAGES_OPTIONAL[@]}"
    do
        command="$command $package"
    done
    for package in "${PACKAGES_DEVELOPMENT[@]}"
    do
            command="$command $package"
    done
    chroot "$base_path/cache/squashfs-root/" /bin/bash -c "$command"

    # Install Python packages via pip
    command="pip install"
    for package in "${PACKAGES_PIP[@]}"
    do
            command="$command $package"
    done
    chroot "$base_path/cache/squashfs-root/" /bin/bash -c "$command"

    # Install Visual Studio Code, Brave Browser, and Tailscale
    vscode_install "$base_path"
    brave_browser_install "$base_path"
    tailscale_install "$base_path"
}

apply() {
    # apply function
    #
    # Description: Applies configuration and installs packages to the extracted filesystem before creating the ISO.
    #
    # Parameters:
    #   - base_path: The base path where the ISO and extracted files are located.

	local base_path="$1"

    # Source ISO management functions
    source "$(dirname "$0")/common/lib/iso_management.sh"

    # Uncompress ISO file and prepare filesystem
	uncompress_iso "$base_path" "filesystem.squashfs"

    # Set DNS resolver
	chroot "$base_path/cache/squashfs-root/" /bin/bash -c "echo 'nameserver 8.8.8.8' > /etc/resolv.conf"

    # Install packages and customize system
	install_packages "$base_path"

    # Compress modified filesystem back into ISO
	compress_iso "$base_path" "filesystem.squashfs" -as mkisofs -r -V 'Custom Ubuntu 22.04' -J --grub2-mbr "$base_path/cache/uncompressed/[BOOT]/1-Boot-NoEmul.img" -partition_offset 16 --mbr-force-bootable -append_partition 2 28732ac11ff8d211ba4b00a0c93ec93b "$base_path/cache/uncompressed/[BOOT]/2-Boot-NoEmul.img" -appended_part_as_gpt -iso_mbr_part_type a2a0d0ebe5b9334487c068b6b72699c7 -c '/boot.catalog' -b '/boot/grub/i386-pc/eltorito.img' -no-emul-boot -boot-load-size 4 -boot-info-table --grub2-boot-info -eltorito-alt-boot -e '--interval:appended_partition_2:::' -no-emul-boot -o "$base_path/cache/custom.iso"
}
