# PlexPi
A Raspberry Pi project for setting up a Plex server.

### Getting Started
Some text.

### Useful Commands
| Command | Description |
| --- | --- |
| `ls -l` | Lists the directory with details |
| `sudo blkid` & `sudo lsblk` | Allows you to display information about available block devices, useful for getting information about your external hard drive. |
| `sudo chown -R myuser:mygroup /path` | Change ownership recursively. |
| `sudo mount -t auto /dev/sdb1 /path` | Mount a disk |
| `sudo echo "/dev/sda2 /mnt/external  errors=remount-ro 0 1" >> /etc/fstab` | Unsure about what this one is yet, but I think it's to mount the external hard drive on boot. |
| `sudo fdisk -l` | Lists all partitions |
| `sudo fdisk /path` | Launch fdisk for the specified path. |
| `sudo dd if=/dev/zero of=/dev/sda bs=512 count=1` | Remove a partition table. Fills the first 512 bytes of the disk with zeros, and in effect erase the partition table. |
| https://phoenixnap.com/kb/delete-partition-linux | How to delete a partition in Linux. |
| https://phoenixnap.com/kb/linux-format-disk | How to format a disk in Linux. |
| `sudo mkfs -t ext4 /dev/sdb1` | Format a partition with the ext4 file system |

### Compatible Devices
- Raspberry Pi 3b+
- Raspberry Pi 4

### Storage Device
You can use any storage device you choose for this project. For the purposes of this guide I will be using a 3TB Western Digital Black hard drive put into a 3.5" USB drive enclosure.

## PlexPi Initial Setup
### Install Raspberry Pi OS
Navigate to the [Raspberry Pi Software Downloads](https://www.raspberrypi.com/software/) and download the Raspberry Pi Imager. For this image we want to select a headless version of the Raspberry Pi OS. Use this tool to put the OS onto the MicroSD card. You can also frontload some settings onto the image to reduce setup time. Settings include:
- Hostname
- Enabling SSH
  - You will need to ensure to enable SSH for this process
- Username & Password
  - Make this something secure ;)
- Wireless Network
  - Configure this in order for the PlexPi to connect to your wireless network
- Timezone
- Keyboard Layout

![image](https://user-images.githubusercontent.com/12025660/187555316-28848fad-2852-4255-aafc-a46feff24ec2.png)

### Connect to the PlexPi
Once you have installed the Raspberry Pi OS on the MicroSD card, insert the MicroSD card into the PlexPi and turn it on. During first boot, allow at least a few minutes to pass before attempting to connect.

Use an SSH client to connect to the PlexPi, I prefer using [PuTTY](https://www.putty.org/).

![image](https://user-images.githubusercontent.com/12025660/187557689-2e9fd138-ae85-4327-989d-40c6cf8d4ca5.png)

### Update the packages
Type the following command to download the package information for all current sources. This is a similar concept to `git fetch`.

`sudo apt update`

### Upgrade the packages
Type the following command to download and install the updates for each out of date package. This is a similar concept to `git pull`.

`sudo apt upgrade`

## Configure the External Hard Drive
For the purposed of this guide, I will be showing how to configure an external hard drive that has an existing NTFS partition.

## Install Plex Media Server
To enable the Plex Media Server repository on Ubuntu only a few terminal commands are required. From a terminal window run the following two commands:

`echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list`

`curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -`

After that, it’s just a matter of running the normal `sudo apt update` and the Plex Media Server repo will be enabled on the OS.

Finally, to install Plex, run the following command.

`sudo apt install plexmediaserver`
