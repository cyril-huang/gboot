@echo off
echo list disk > listdisk.dkp
diskpart /s listdisk.dkp | find "Disk " > tmp_disks.txt
for /f "tokens=* skip=1" %%d in (tmp_disks.txt) do echo %%d >> disks.txt
for /f "tokens=3" %%c in ('find /C "Disk " disks.txt') do set ndisks=%%c
if %ndisks% == 1 (
	set /P pause=No hard disk found! Please check hard disk configuration
	weputil reboot
)
set /a last_disk=%ndisks%-1

set winnt=winsrc\k3en\i386\winnt32.exe
if not exist h:\%winnt% (
	for /f "tokens=2 delims=:" %%c in ('chcp') do set codepage=%%c
	chcp 437 > null
	echo list volume > listvolume.dkp
	for /l %%v in (1,1,10) do (
		diskpart /s listvolume.dkp | find "Volume %%v" > volume%%v.txt
		for /f "tokens=3" %%d in (volume%%v.txt) do (
			set volume=%%v
			set drive=%%d
			call :change_to_h
		)
	)
) else (
	goto :install_nt
)

: change_to_h
if exist %drive%:\%winnt% (
	set source_volume=%volume%
	echo select volume %volume% > change_to_h.dkp
	echo assign letter=h >> change_to_h.dkp
	diskpart /s change_to_h.dkp
	goto :install_nt
)
goto:eof

: install_nt
echo select volume %source_volume% > detailvolume.dkp
echo detail volume >> detailvolume.dkp
diskpart /s detailvolume.dkp | find "*" > detailsource.txt
for /f "tokens=3" %%d in (detailsource.txt) do set source_disk=%%d

: select_disk
echo   disk    status        size
echo =======================================================================
for /f "tokens=*" %%d in (disks.txt) do (
	echo %%d > test.txt
	find "Disk %source_disk%" test.txt > null
	if errorlevel 1 echo %%d
)
echo =======================================================================

set /P target_disk=Select disk to install:  
if %target_disk% == %source_disk% goto :select_disk

for /l %%d in (0, 1, %last_disk%) do (
	if %target_disk% == %%d goto :create_target
)
goto :select_disk

: create_target
echo select disk %target_disk% > create_target.dkp
echo clean >> create_target.dkp
echo create partition primary >> create_target.dkp
echo active >> create_target.dkp
echo format fs=ntfs label=windows quick >> create_target.dkp
diskpart /s create_target.dkp

echo select disk %target_disk% > detailtarget.dkp
echo detail disk >> detailtarget.dkp
diskpart /s detailtarget.dkp | find "Volume " > tmp_target_vol.txt
for /f "tokens=2 skip=1" %%v in (tmp_target_vol.txt) do set target_volume=%%v

echo select volume %target_volume% > change_to_c.dkp
echo assign letter=c >> change_to_c.dkp
diskpart /s change_to_c.dkp

if not exist c: (
	set /P pause=No C: found! Please check hard disk configuration
	wpeutil reboot
)

chcp %codepage%
h:\%winnt% /syspart:c: /tempdrive:c: /makelocalsource
