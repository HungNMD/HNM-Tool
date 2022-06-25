@echo OFF
color 1a
chcp 65001
mode con lines=30 cols=100
title BACKUP PERSONAL FILE TO NAS SERVER
set t=BACKUP PERSONAL FILE TO NAS SERVER
echo %t%
echo.
echo.
set S1="D:\TRINH\"
set S2="D:\TRANGQA\"
set S3="D:\TRANGQC\"
set S4="D:\LY\"
set S5="D:\DONG\"

set T1="\\VIVC-NAS\DOC\TRINH"
set T2="\\VIVC-NAS\DOC\TRANGQA"
set T3="\\VIVC-NAS\DOC\TRANGQC"
set T4="\\VIVC-NAS\DOC\LY"
set T5="\\VIVC-NAS\DOC\DONG"

xcopy %S1% %T1% /i /d /y
echo ....................TRINH Finished!
xcopy %S2% %T2% /i /d /y
echo ....................\TRANGQA
xcopy %S3% %T3% /i /d /y
echo ....................\TRANGQC
xcopy %S4% %T4% /i /d /y /e
echo ....................\LY
xcopy %S5% %T5% /i /d /y /e
echo ....................\DONG
'xcopy %S6% %T6% /i /d /y /e
echo ....................
'xcopy %S7% %T7% /i /d /y /e
echo ....................

echo.