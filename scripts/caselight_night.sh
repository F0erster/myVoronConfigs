#!/bin/bash
# Turns the case light on if Klipper starts between 20:00 and 08:00
HOUR=$(TZ=Europe/Berlin date +%-H)

if [ "$HOUR" -ge 20 ] || [ "$HOUR" -lt 8 ]; then
  # runs in the background so RUN_SHELL_COMMAND returns immediately and
  # doesn't block the gcode queue the API call needs
  (
    for i in $(seq 1 10); do
      sleep 2
      curl -sf -X POST "http://localhost:7125/printer/gcode/script?script=_CASELIGHT_ON" && break
    done
  ) >/dev/null 2>&1 &
fi