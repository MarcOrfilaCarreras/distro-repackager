# distro-repackager

Command-line tool to preinstall your preferred packages, crafting personalized Linux distributions tailored to your exact needs.
## Installation

### With Docker

1. Clone the Repository:
``` bash
git clone https://github.com/MarcOrfilaCarreras/distro-repackager.git
```

2. Navigate to Project Directory:
``` bash
cd distro-repackager
```

3. Build the Docker Image:

``` bash
docker build -t distro-repackager:latest .
```

4. Run the Docker Container:

``` bash
docker run --rm -v "$(pwd)/distros/ubuntu/22-04/cache:/app/distros/ubuntu/22-04/cache" distro-repackager:latest --help
```

### Without Docker

> 👀 It requires root privileges to use

1. Clone the Repository:
``` bash
git clone https://github.com/MarcOrfilaCarreras/distro-repackager.git
```

2. Navigate to Project Directory:
``` bash
cd distro-repackager
```

3. Install dependencies:

``` bash
sudo ./run.sh dependencies -i
```

4. Run the tool:

``` bash
sudo ./run.sh -h
```

## Usage
1. Prepare the Original ISO:
    - Place the original ISO file of the desired Linux distribution and version in the cache folder corresponding to that distribution and version.
    - Ensure the original ISO file is named `original.iso`.

2. Run the Tool:
    - Open a terminal or command prompt.
    - Use the `cd` command to navigate to the directory where the CLI tool is located.
    - Run the CLI tool with appropriate parameters to customize the Linux distribution.

3. Output:
    - After executing the tool, a customized ISO file named `custom.iso` will be created in the same directory where the original ISO file was located.

4. Additional Notes:
    - Ensure you have sufficient disk space and permissions to write to the output directory.
    - Review the tool's documentation or help (--help flag) for additional options and usage instructions.

## License

See the [LICENSE.md](LICENSE.md) file for details.
## Acknowledgements

 - [Automating ISO Customization with Jenkins and Shell Script](https://dev.to/otomato_io/automating-iso-customization-with-jenkins-and-shell-script-4goj)

 - [Ubuntu 22.04 Server Autoinstall ISO](https://www.pugetsystems.com/labs/hpc/ubuntu-22-04-server-autoinstall-iso/)
