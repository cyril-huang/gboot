gboot
=====

Gyoza usb multiboot creator project

The usb drive now is cheaper with large capacity and it's suitable media for a device to install an OS. It has some advantages over the traditional optical media.

- faster speed
- larger capacity
- easy to erase and modify
- no special huge optical drive required

The gboot project is to create the multiboot installation usb by using the syslinux/grub/ipxe as boot loader and support the multiple following OS with unlimit number of OS instance as long as the usb capacity is enough.

- Linux (Different distro and live Linux)
- BSD (netbsd, openbsd)
- MS DOS
- Windows NT series (Windows NT, 2003 server, XP)
- Windows Vista series (vista, 2008 server, 7, winpe 2 & 3)
- VMware ESXi
- OSX (with chainload of chameleon)
- Android (actually is a Linux)
- Solaris

Installation
============
Linux 64 bit environment with dosfstools package. hfsplus and hfsprogs are required to create hfs filesystem if OSX support wanted.

./igboot /dev/sdx

to create the parition and filesystem required and copy all bootloaders with configuration file into device /dev/sdx. The pre-compiled different bootmgr with associated boot/bcd for windows 2008 server and windows 7 are provided. Here are

- Windows 7 English
- Windows 7 Traditional Chinese
- Windows 7 Simplified Chinese
- Windows 2008 Server
- Windows 2003 Server
- Windows XP English
- Windows XP Tradititonal Chinese
- Windows PE 2
- Windows PE 3

with the setup.cmd inside gyoza/wim.
