#!/bin/sh
## Prepare Variables
TANG_CACHE_PATH=${TANG_CACHE_PATH:-"/var/cache/tang"}

if [ "$1" == "tangd-rotate-keys" ]; then
  "Start rotating keys..."
  exec tangd-rotate-keys -d "$TANG_CACHE_PATH"
  "End rotating keys..."
fi

if [ "$1" == "bash" ] || [ "$1" == "sh"]; then
  exec bash
fi

## Prepare Log
echo "=================================="
echo "`date`:"

# Check if keys already exists, if not create one
[ -f "$TANG_CACHE_PATH/*.jwk" ] || ( tangd-rotate-keys -d "$TANG_CACHE_PATH" && echo "Rotate keys...")

## Start Application
socat tcp-l:80,reuseaddr,fork exec:"tangd $TANG_CACHE_PATH"
