@echo off

rem :: ---------------------------------
rem :: config

set url="http://localhost:8000/archive.org/details/CNNW_20230528_160000_State_of_the_Union_With_Jake_Tapper_and_Dana_Bash.nget"
set print_response_headers=1
set output="%~dp0.\2-response.nget"

rem :: ---------------------------------

set curl_opts=
if defined print_response_headers if not "%print_response_headers%"=="0" set curl_opts=%curl_opts% -i
set curl_opts=%curl_opts% -s
set curl_opts=%curl_opts% -o %output%

curl %curl_opts% %url%
