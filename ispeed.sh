#!/usr/bin/env bash

DL_ICON='⬆️'
UL_ICON='⬇️'

notify-send -t 20000 '🌐 Checking your internet connection...' 'Please wait a moment'

notify-send -t 10000 'Download/Upload Speed' "$(curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python - | grep 'Download\|Upload' | sed "s/Download:/$DL_ICON:/;s/Upload:/$UL_ICON:/")"

