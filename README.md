# PlexPi
A Raspberry Pi project for setting up a Plex server.

## Getting Started
Some text.

### Compatible Devices
- Raspberry Pi 3b+
- Raspberry Pi 4

### Storage Device
Some text.

## Install Raspberry Pi OS
Navigate to the [Raspberry Pi Software Downloads](https://www.raspberrypi.com/software/) and download the Raspberry Pi Imager. For this image we want to select a headless version of the Raspberry Pi OS. Use this tool to put the OS onto the MicroSD card. You can also frontload some settings onto the image to reduce setup time. Settings include:
- Hostname
- Enabling SSH
- Username & Password
- Wireless Network
- Timezone
- Keyboard Layout

![image](https://user-images.githubusercontent.com/12025660/187323243-6787ccbb-1a01-45c6-ad1a-974ff1ccbfe0.png)

### Update the packages
Type the following command to download the package information for all current sources. This is a similar concept to `git fetch`.

`sudo apt update`

### Upgrade the packages
Type the following command to download and install the updates for each out of date package. This is a similar concept to `git pull`.

`sudo apt upgrade`

## Install Plex Media Server
To enable the Plex Media Server repository on Ubuntu only a few terminal commands are required. From a terminal window run the following two commands:

`echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list`
