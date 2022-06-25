@echo off
setlocal EnableExtensions DisableDelayedExpansion
:repeat

set /p SourceFolder=Input the Source Folder:
echo %sourcefolder%
set "LogExtract=%SourceFolder%\ExtractionLog.txt"
set "LogError=%SourceFolder%\ErrorLog.txt"

del /Q "%LogExtract%" "%LogError%" 2>nul

for /F "eol=| delims=" %%I in ('dir "%SourceFolder%\*" /AD-H /B /ON 2^>nul ^| %SystemRoot%\System32\findstr.exe /I /L /V /X /C:done') do (
    set "ArchiveExtracted="
    for /F "eol=| delims=" %%J in ('dir "%SourceFolder%\%%I\*.rar" "%SourceFolder%\%%I\*.zip" /A-D-H /B /ON 2^>nul') do (
        if exist "%SourceFolder%\%%I\%%J" (
            echo Extracting "%SourceFolder%\%%I\%%J" ...
            "%ProgramFiles%\WinRAR\WinRAR.exe" x -cfg- -ibck -pyeukindlevietnam -logpfu="%LogExtract%" -o+ -y -- "%SourceFolder%\%%I\%%J" "%SourceFolder%\"
            if errorlevel 1 (
                set "ArchiveFile=%SourceFolder%\%%I\%%J"
                >>"%LogError%" call echo Error %%ErrorLevel%% on extracting "%%ArchiveFile%%"
            ) else (
                set "ArchiveExtracted=1"
                echo %%~nJ| %SystemRoot%\System32\findstr.exe /I /R "\.part[0123456789][0123456789]*$" >nul
                if errorlevel 1 ( del /F "%SourceFolder%\%%I\%%J" ) else for %%# in ("%%~nJ") do del /F /Q "%SourceFolder%\%%I\%%~n#.part*%%~xJ"
            )
        )
    )
    
    )       
	 
)
goto repeat

endlocal