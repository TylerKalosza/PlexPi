# PlexPi
A Raspberry Pi project for setting up a Plex server.

### Getting Started
Some text.

### Compatible Devices
- Raspberry Pi 3b+
- Raspberry Pi 4

### Storage Device
You can use any storage device you choose for this project. For the purposes of this guide I will be using a 3TB Western Digital Black hard drive put into a 3.5" USB drive enclosure.

## PlexPi Initial Setup
### Install Raspberry Pi OS
Navigate to the [Raspberry Pi Software Downloads](https://www.raspberrypi.com/software/) and download the Raspberry Pi Imager. For this image we want to select a headless version of the Raspberry Pi OS. Use this tool to put the OS onto the MicroSD card. You can also frontload some settings onto the image to reduce setup time. Settings include:
- Hostname
- Enabling SSH - You will need to ensure to enable SSH for this process
- Username & Password - Make this something secure ;)
- Wireless Network - Configure this in order for the PlexPi to connect to your wireless network
- Timezone
- Keyboard Layout

![image](https://user-images.githubusercontent.com/12025660/187555316-28848fad-2852-4255-aafc-a46feff24ec2.png)

### Connect to the PlexPi
Once you have installed the Raspberry Pi OS on the MicroSD card, insert the MicroSD card into the PlexPi and turn it on. During first boot, allow at least a few minutes to pass before attempting to connect.

Use an SSH client to connect to the PlexPi, I prefer using [PuTTY](https://www.putty.org/).

![image](https://user-images.githubusercontent.com/12025660/187557689-2e9fd138-ae85-4327-989d-40c6cf8d4ca5.png)

### Update the packages
Type `sudo apt update` to download the package information for all current sources. This is a similar concept to "git fetch".

### Upgrade the packages
Type `sudo apt upgrade` to download and install the updates for each out of date package. This is a similar concept to "git pull".

### Configure the External Hard Drive
For the purposed of this guide, I will be showing how to configure an external hard drive that has an existing NTFS partition.

***Warning: This will wipe any existing data on the external hard drive!***

First we need to identify the location of the external hard drive. Start by running the command `sudo lsblk`, which will list out all of the disks and partitions. In this case, the location of the external hard drive is **/dev/sda**, and the 2 partitions on the drive are **/dev/sda1** and **/dev/sda2**.

![image](https://user-images.githubusercontent.com/12025660/187563936-2f8f0ca7-4733-47d2-8b5b-1c851bef606a.png)

![image](https://user-images.githubusercontent.com/12025660/187563802-a3a90797-d34e-4dad-8572-ac2602f2e112.png)

Next we need to delete the partitions, run the command `sudo fdisk /dev/sda`. Once in the fdisk utility, type `d` to delete a partition, type `2` to delete partition 2, then type `d` to delete the last partition. Finally, type `w` to save and quit fdisk utility.

![image](https://user-images.githubusercontent.com/12025660/187565899-42e4ee7e-bccc-4cd5-bde9-27233e2ab40e.png)

We are now going to delete the partition table on the disk, type the command `sudo dd if=/dev/zero of=/dev/sda bs=512 count=1` to delete the partition table, replacing "/dev/sda" with the correct path to you disk.

Next we need to create a new empty GPT partition table. Type the command `sudo fdisk /dev/sda`. Once in the fdisk utility, type `g` to create a new empty GPT partition table. Finally, type `w` to save and quit fdisk utility.

![image](https://user-images.githubusercontent.com/12025660/187567059-8e1be9a3-e580-4b1f-a8a9-8763a8bdbea5.png)

Next, we'll format the drive with the ext4 file system. Type the command `sudo mkfs -t ext4 /dev/sda`.

![image](https://user-images.githubusercontent.com/12025660/187567561-322c676b-19eb-47ad-aa8f-0abdb2dbe4b8.png)

Next we need to mount the new disk. Create the directory where the disk will be mounted, type the command `sudo mkdir /mnt/media`. Then type the command `sudo mount -t auto /dev/sda /mnt/media` to mount the disk.

Lastly, we will change the permissions of the directory "/mnt/media". Type the command `sudo chmod 777 /mnt/media`.

Success! We now have access to the external hard drive at the location /mnt/media.

## Install Plex Media Server
To enable the Plex Media Server repository only a few terminal commands are required. From a terminal window run the following two commands:

`echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list`

`curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -`

After that, it’s just a matter of running the normal `sudo apt update` and the Plex Media Server repo will be enabled on the OS.

Finally, to install Plex, run the command `sudo apt install plexmediaserver`.

## Configure Plex Media Server
Open a web browser and navigate to http://<ip_address>:32400/web.

# Useful Commands
| Command | Description |
| --- | --- |
| `ls -l` | Lists the contents of the directory with details |
| `sudo chown -R myuser:mygroup /path` | Change ownership recursively. |
| `sudo mount -t auto /dev/sdb1 /path` | Mount a disk |
| `sudo fdisk -l` | Lists all partitions |
| `sudo fdisk /path` | Launch fdisk for the specified path. |
| `sudo dd if=/dev/zero of=/dev/sda bs=512 count=1` | Remove a partition table. Fills the first 512 bytes of the disk with zeros, and in effect erase the partition table. |
| `sudo mkfs -t ext4 /dev/sda` | Format a partition with the ext4 file system |
