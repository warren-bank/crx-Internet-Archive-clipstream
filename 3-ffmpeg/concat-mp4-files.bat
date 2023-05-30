@echo off

set input_list="%~1"
set output_mp4="%~2"

if defined input_list if defined output_mp4 goto :convert

echo Error: missing required input parameters.
echo Usage: concat-mp4-files.bat [input_list_url] [output_mp4_filepath]
goto :done

:convert
set ffmpeg_opts=
set ffmpeg_opts=%ffmpeg_opts% -nostats -hide_banner -loglevel repeat+level+info
set ffmpeg_opts=%ffmpeg_opts% -protocol_whitelist file,http,https,tcp,tls
set ffmpeg_opts=%ffmpeg_opts% -f concat -safe 0
set ffmpeg_opts=%ffmpeg_opts% -i %input_list%
set ffmpeg_opts=%ffmpeg_opts% -c copy -movflags +faststart

call ffmpeg %ffmpeg_opts% %output_mp4%

:done
