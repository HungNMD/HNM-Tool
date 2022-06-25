@echo off
color 1a
chcp 65001
mode con lines=30 cols=100
title CHANGE IP TIME-RECORDER
set T="Ethernet"
:start
ECHO.
ECHO 1. Change %T% to 192.168.31.1
ECHO 2. Change %T% to 192.168.0.1
ECHO 3. Just backup options
ECHO 4. Obtain an IP address automatically
ECHO 0. Exit

set choice=
set /p choice=Type your choice, then press [ENTER]: 
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto con1
if '%choice%'=='2' goto con2
if '%choice%'=='3' goto con3
if '%choice%'=='4' goto autosearch
if '%choice%'=='0' goto end
ECHO "%choice%" is not valid, try again
ECHO.
goto start
:con1
ECHO Connecting Connection 1
netsh interface ipv4 set address name=%T% static 192.168.31.1 255.255.255.0 192.168.31.1
netsh interface ipv4 set dns name=%T% static 8.8.8.8 primary
netsh interface ipv4 add dns name=%T% 8.8.4.4 index=2
goto end

:con2
ECHO Connecting Connection 2
netsh interface ipv4 set address name=%T% static 192.168.0.1 255.255.255.0 192.168.0.1
netsh interface ipv4 set dns name=%T% static 8.8.8.8 primary
netsh interface ipv4 add dns name=%T% 8.8.4.4 index=2
goto end

:con3
ECHO Connecting Connection 3
netsh interface ipv4 set address name=%T% static 192.168.31.1 255.255.255.0 192.168.31.1
netsh interface ipv4 set dns name=%T% static 8.8.8.8 primary
netsh interface ipv4 add dns name=%T% 8.8.4.4 index=2
goto end

:autosearch
ECHO RESETTING CFG
netsh interface ip set address %t% dhcp
ipconfig /renew %t%
goto end

:end

