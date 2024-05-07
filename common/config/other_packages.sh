#!/bin/bash

vscode_install() {
    # vscode_install function
    #
    # Description: Installs Visual Studio Code inside the chroot environment.
    #
    # Parameters:
    #   - base_path: The base path where the chroot environment is located.

    local base_path="$1"

    chroot "$base_path/cache/squashfs-root/" /bin/bash -c "apt install -y software-properties-common apt-transport-https wget"
    chroot "$base_path/cache/squashfs-root/" /bin/bash -c "wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add -"
    chroot "$base_path/cache/squashfs-root/" /bin/bash -c "add-apt-repository -y 'deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main'"
    chroot "$base_path/cache/squashfs-root/" /bin/bash -c "apt-get update -y"
    chroot "$base_path/cache/squashfs-root/" /bin/bash -c "apt install -y code"
}

brave_browser_install() {
    # brave_browser_install function
    #
    # Description: Installs Brave Browser inside the chroot environment.
    #
    # Parameters:
    #   - base_path: The base path where the chroot environment is located.

    local base_path="$1"

    chroot "$base_path/cache/squashfs-root/" /bin/bash -c "apt install -y curl"
    chroot "$base_path/cache/squashfs-root/" /bin/bash -c "curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg"
    chroot "$base_path/cache/squashfs-root/" /bin/bash -c "echo 'deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main'|tee /etc/apt/sources.list.d/brave-browser-release.list"
    chroot "$base_path/cache/squashfs-root/" /bin/bash -c "apt-get update -y"
    chroot "$base_path/cache/squashfs-root/" /bin/bash -c "apt install -y brave-browser"
}

tailscale_install() {
    # tailscale_install function
    #
    # Description: Installs Tailscale inside the chroot environment.
    #
    # Parameters:
    #   - base_path: The base path where the chroot environment is located.

    local base_path="$1"

    chroot "$base_path/cache/squashfs-root/" /bin/bash -c "apt install -y curl"
    chroot "$base_path/cache/squashfs-root/" /bin/bash -c "curl -fsSL https://tailscale.com/install.sh | sh"
}
