# PlexPi
A Raspberry Pi project for setting up a Plex server.

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
***Warning: This will wipe any existing data on the external hard drive!***

First we need to identify the location of the external hard drive. Start by running the command `sudo lsblk`, which will list out all of the disks and partitions. In this case, the location of the external hard drive is **/dev/sda**, and the 2 partitions on the drive are **/dev/sda1** and **/dev/sda2**.

![image](https://user-images.githubusercontent.com/12025660/187563936-2f8f0ca7-4733-47d2-8b5b-1c851bef606a.png)

![image](https://user-images.githubusercontent.com/12025660/187563802-a3a90797-d34e-4dad-8572-ac2602f2e112.png)

Next we need to delete the partitions, run the command `sudo fdisk /dev/sda`. Once in the fdisk utility, type `d` to delete a partition, type `2` to delete partition 2, then type `d` to delete the last partition. Finally, type `w` to save and quit fdisk utility.

![image](https://user-images.githubusercontent.com/12025660/187565899-42e4ee7e-bccc-4cd5-bde9-27233e2ab40e.png)

We are now going to delete the partition table on the disk, type the command `sudo dd if=/dev/zero of=/dev/sda bs=512 count=1` to delete the partition table, replacing "/dev/sda" with the correct path to you disk.

Next we need to create a new empty GPT partition table. Type the command `sudo fdisk /dev/sda`. Once in the fdisk utility, type `g` to create a new empty GPT partition table. Finally, type `w` to save and quit fdisk utility.

![image](https://user-images.githubusercontent.com/12025660/187567059-8e1be9a3-e580-4b1f-a8a9-8763a8bdbea5.png)

Next we are going to create a new partition. Type the command `sudo fdisk /dev/sda`. Once in the fdisk utility, type `n` to create a new partition, pressing `<enter>` after all prompts to accept the defaults. Finally, type `w` to save and quit fdisk utility.

Next, we'll format the drive with the ext4 file system. Type the command `sudo mkfs -t ext4 /dev/sda1`.

Next we need to mount the new disk. Create the directory where the disk will be mounted, type the command `sudo mkdir /mnt/media`.

Let's now change the ownership of that directory, run the command `sudo chown -R pi:pi /mnt/media`.

Next need to add the disk to the **fstab** file so that the drive is mounted automatically every time the system boots. Type the command `sudo blkid` to list info about the disk. We need to copy the UUID of the drive. From here we need to edit the **fstab** file, type the command `sudo nano /etc/fstab` to edit the file in Nano. Add the following line to the file, replacing the empty UUID with the UUID of the drive.

**UUID=00000000-0000-0000-0000-000000000000 /mnt/media ext4 defaults 0 1**

![image](https://user-images.githubusercontent.com/12025660/188763358-81638c3b-ee51-4145-9550-90fe32e6c959.png)

To save the file and quit, type `CTRL+X`, `Y`, `<enter>`.

From here we can run the command `sudo mount -a` to mount all the drives in the **fstab** file. `lsblk` to verify

![image](https://user-images.githubusercontent.com/12025660/188764016-4b2e7bf4-881b-4495-bf14-1d44c9e53788.png)

Lastly, we will change the permissions of the directory "/mnt/media". Type the command `sudo chmod 777 -R /mnt/media`.

Success! We now have access to the external hard drive at the location "/mnt/media", it will also be available after the system reboots.

## Install Plex Media Server
To enable the Plex Media Server repository only a few terminal commands are required. From a terminal window run the following two commands:

`echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list`

`curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -`

After that, it’s just a matter of running the normal `sudo apt update` and the Plex Media Server repo will be enabled on the OS.

Finally, to install Plex, run the command `sudo apt install plexmediaserver`.

## Configure Plex Media Server
Open a web browser and navigate to http://<ip_address_or_hostname>:32400/web.

# Useful Commands
| Command | Description |
| --- | --- |
| `ls -l` | Lists the contents of the directory with details |
| `sudo chown -R myuser:mygroup /path` | Change ownership recursively. |
| `sudo chmod -R 777 /path` | Change permissions recursively. |
| `sudo blkid` | Get UUID from disk. |
| `sudo fdisk -l` | Lists all partitions |
| `sudo fdisk /path` | Launch fdisk for the specified path. |
| `sudo dd if=/dev/zero of=/dev/sda bs=512 count=1` | Remove a partition table. Fills the first 512 bytes of the disk with zeros, and in effect erase the partition table. |
| `sudo mkfs -t ext4 /dev/sda1` | Format a partition with the ext4 file system |
| `sudo nano /etc/wpa_supplicant/wpa_supplicant.conf` | Edit the WiFi configuration |
| `sudo nano /etc/ssh/sshd_config` | Change the SSH port |
