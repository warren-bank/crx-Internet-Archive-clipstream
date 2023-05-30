@echo off

set input_m3u8="%~1"
set output_mp4="%~2"

if defined input_m3u8 if defined output_mp4 goto :convert

echo Error: missing required input parameters.
echo Usage: convert-m3u8-to-mp4.bat [input_m3u8_url] [output_mp4_filepath]
goto :done

:convert
set ffmpeg_opts=
set ffmpeg_opts=%ffmpeg_opts% -nostats -hide_banner -loglevel repeat+level+info
set ffmpeg_opts=%ffmpeg_opts% -protocol_whitelist file,http,https,tcp,tls
set ffmpeg_opts=%ffmpeg_opts% -http_persistent 0
set ffmpeg_opts=%ffmpeg_opts% -allowed_extensions ALL
set ffmpeg_opts=%ffmpeg_opts% -i %input_m3u8%
set ffmpeg_opts=%ffmpeg_opts% -c copy -movflags +faststart

call ffmpeg %ffmpeg_opts% %output_mp4%

:done
