@echo off

rem :: ---------------------------------
rem :: config

set url="http://localhost:8000/archive.org/details/CNNW_20230528_160000_State_of_the_Union_With_Jake_Tapper_and_Dana_Bash.nget"
set output="%~dp0.\output"

rem :: ---------------------------------

if exist %output% rmdir /Q /S %output%
mkdir %output%

call "%~dp0..\..\..\4-nget\download-segments.bat" %url% %output%
