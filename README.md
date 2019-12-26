This is stub README file for project. It should be replaced with real later.

Flexible framework intended to build custom hybrid ISO images for
Debian GNU/Linux distribution and it's derivatives (e.g. Ubuntu)
for automated installs (preseed) and additional features.

Aim of this project is to simplify new machine provisioning and be
an open source base for vendor specific distributions for appliances.

### Features

* Preseeded (automated) installation from
   - CD/DVD
   - USB stick (hybrid ISO)
   - PXE using same ISO loop-mounted and shared via HTTP
* Multiple simple-cdd profiles to select additional
  packages and perform specific setups.
* Disk partitioning profiles using
   - btrfs (compression, subvolume installation, default)
   - lvm
   - regular
* BIOS/UEFI support
   - all partitioning schemas are UEFI aware and use GPT
* Baremetal/Virtual machine support
* Dual VGA and Serial consoles
   - installer for both BIOS (isolinux), UEFI (grub)
   - bootloader on installed system (grub)
   - systemd getty
* Basic preconfiguration
   - iptables/ip6tables rules
   - postfix/ssh configuration
   - setup user

### Requirements

1. Buildhost.
     Debian GNU/Linux 10 (buster) system with simple-cdd, reprepro installed.
2. Network.
     IPv4/IPv6 network connection to deb.debian.org and archive.debian.org.
3. Storage.
     At least 10GB of storage to hold debian-installer and mirrored data.

### Quick help on how to build images

#### Clone repository

`git clone --recursive https://github.com/serhepopovych/simple-cdd.git`

#### Build debian-installer package

Here you need to build debian-installer images somehow using
specific Debian release (e.g. wheezy, jessie, stretch, buster).

Most likely you want to do this using docker. However this part
is not implemented yet.

`dpkg-buildpackage -b -us -uc`

#### Do build images

````
for i in 7 8 9 10
do
    ./debian/deb/$i/profiles/minimal.sh
done
````
