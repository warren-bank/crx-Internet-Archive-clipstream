@echo off

rem :: ---------------------------------
rem :: config

set url="http://localhost:8000/archive.org/details/CNNW_20230528_160000_State_of_the_Union_With_Jake_Tapper_and_Dana_Bash.m3u8"
set output="%~dp0.\2-response.mp4"

rem :: ---------------------------------

call "%~dp0..\..\..\3-ffmpeg\convert-m3u8-to-mp4.bat" %url% %output%
