@echo off

rem :: ---------------------------------
rem :: config

set url="http://localhost:8000/archive.org/details/CNNW_20230528_160000_State_of_the_Union_With_Jake_Tapper_and_Dana_Bash.ffmpeg"
set output="%~dp0.\2-response.mp4"

rem :: ---------------------------------

call "%~dp0..\..\..\3-ffmpeg\concat-mp4-files.bat" %url% %output%
