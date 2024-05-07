#!/bin/bash

uncompress_iso() {
    # uncompress_iso function
    #
    # Description: Uncompresses the provided ISO file and extracts the specified squashfs file.
    #
    # Parameters:
    #   - base_path: The base path where the ISO and extracted files will be stored.
    #   - squashfs_file_name: The name of the squashfs file to be extracted from the ISO.

	local base_path="$1"
    local squashfs_file_name="$2"

    # Check if the original ISO file exists
    if ! [ -f "$base_path/cache/original.iso" ]; then
		echo ""
		echo "ERROR: The ISO was not found !"

		exit 1
	fi

	echo "INFO: Uncompressing ISO file."

    # Create cache directory if it doesn't exist
    mkdir -p "$base_path/cache"

    # Remove any existing directories
	rm -rf "$base_path/cache/uncompressed" "$base_path/cache/squashfs-root"

    # Extract the ISO file
    7z x -y "$base_path/cache/original.iso" -o"$base_path/cache/uncompressed"

    # Copy the specified squashfs file to the cache directory
    cp "$base_path/cache/uncompressed/casper/$squashfs_file_name" "$base_path/cache"

    # Extract the specified squashfs file
    unsquashfs -d "$base_path/cache/squashfs-root" "$base_path/cache/$squashfs_file_name"

    # Clean up extracted squashfs file
    rm -rf "$base_path/cache/$squashfs_file_name"
}

compress_iso() {
    # compress_iso function
    #
    # Description: Compresses the modified filesystem back into an ISO file.
    #
    # Parameters:
    #   - base_path: The base path where the ISO and extracted files are located.
    #   - squashfs_file_name: The name of the squashfs file to be compressed into the ISO.
    #   - xorriso_params: Additional parameters for xorriso command.

	local base_path="$1"
    shift
    local squashfs_file_name="$2"
    shift
    local xorriso_params=("$@")

	echo "INFO: Compressing ISO file."

    # Create new squashfs filesystem
	mksquashfs "$base_path/cache/squashfs-root/" "$base_path/cache/$squashfs_file_name" -comp xz -b 1M -noappend

    # Move the new squashfs filesystem to casper directory
    mv "$base_path/cache/$squashfs_file_name" "$base_path/cache/uncompressed/casper"

    # Generate md5sum for the ISO file
    md5sum "$base_path/cache/uncompressed/.disk/info" > "$base_path/cache/uncompressed/md5sum.txt"

    # Replace absolute paths with relative paths in md5sum file
    sed -i "s|$base_path/cache/uncompressed/|./|g" "$base_path/cache/uncompressed/md5sum.txt"

    # Create ISO file using xorriso
    xorriso "${xorriso_params[@]}" "$base_path/cache/uncompressed" -o "$base_path/cache/custom.iso"

    # Clean up
    rm -rf "$base_path/cache/uncompressed" "$base_path/cache/squashfs-root"
}
