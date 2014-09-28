# vim:sts=4:sw=4:noexpandtab
copy files under sources of win7 and win2k8 to srcxxxx
copy any boot/boot.sdi from ISO to boot
boot.wim in sources of win7 and win2k8 is winpe3.0 64bit
boot.wim in sources of vista is winpe2.0 32bit, required to boot xp and 2k3
download wimlib from http://sourceforge.net/projects/wimlib/
modify the boot.wim in all srcxxxx directory with wimlib
    - move setup.exe setup.bak
    - move sources\setup.exe sources\setup.bak
    - copy the winpeshl.ini to Windows\System32
    - copy the setup.cmd to Windows\System32\setup.cmd of win7 and win2k8
    - copy the setup_nt.cmd to Windows\System32\setup.cmd of winxp and win2k3
    - modify the corresponding directory path in setup.cmd
