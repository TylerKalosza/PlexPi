# PlexPi
A Raspberry Pi project for setting up a Plex server.

## Getting Started
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

## Configure the External Hard Drive
Coming Soon

## Install Plex Media Server
To enable the Plex Media Server repository on Ubuntu only a few terminal commands are required. From a terminal window run the following two commands:

`echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list`

`curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -`

After that, it’s just a matter of running the normal `sudo apt update` and the Plex Media Server repo will be enabled on the OS.

Finally, to install Plex, run the following command.

`sudo apt install plexmediaserver`
