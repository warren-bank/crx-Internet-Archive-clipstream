@echo off

set input_m3u="%~1"
set output_dir="%~2"

if defined input_m3u if defined output_dir goto :convert

echo Error: missing required input parameters.
echo Usage: download-segments.bat [input_m3u_url] [output_dirpath]
goto :done

:convert
set nget_opts=
set nget_opts=%nget_opts% --no-check-certificate --no-cookies

nget %nget_opts% --url %input_m3u% -O "-" | nget %nget_opts% -i "-" -mc 3 -P %output_dir% -nc

:done
