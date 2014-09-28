#!ipxe
:start
menu ipxe environment
item shell	ipxe shell
item
item back	Go Back
choose os && goto ${os}

:shell
shell
goto start

:back
