@echo off
move %SYSTEMDRIVE%\sources\setup.bak %SYSTEMDRIVE%\sources\setup.exe > null
move %SYSTEMDRIVE%\setup.bak %SYSTEMDRIVE%\setup.exe > null
set sources=srcw2k8
if not exist h:\%sources%\install.wim (
	for /f "tokens=2 delims=:" %%c in ('chcp') do set codepage=%%c
	chcp 437 > null
	echo list volume > listvolume.dkp
	for /d %%v in (1,2,3,4) do (
		diskpart /s listvolume.dkp | find "Volume %%v" > volume.txt
		for /f "tokens=3" %%d in (volume.txt) do (
			set volume=%%v
			set drive=%%d
			call :change_to_h
		)
	)
) else (
	goto :install_wim
)

: change_to_h
if exist %drive%:\%sources%\install.wim (
	echo select volume %volume% > change_to_h.dkp
	echo assign letter=h >> change_to_h.dkp
	diskpart /s change_to_h.dkp
	chcp %codepage%
	goto :install_wim
)
goto:eof

: install_wim
%SYSTEMDRIVE%\sources\setup.exe /installfrom:h:\%sources%\install.wim
