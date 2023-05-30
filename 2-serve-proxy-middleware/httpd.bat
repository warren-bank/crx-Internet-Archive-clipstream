@echo off

serve --config "%~dpn0.json" --cors --listen "tcp:0.0.0.0:8000" "%~dpn0."
