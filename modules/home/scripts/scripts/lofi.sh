#!/usr/bin/env bash

if (ps aux | grep mpv | grep -v grep > /dev/null); then
    notify-send "Lofi" "Deactivated Lofi"
    pkill mpv
else
    notify-send "Lofi" "Activated Lofi"
    runbg mpv --no-video https://www.youtube.com/live/jfKfPfyJRdk?si=OF0HKrYFFj33BzMo
fi
