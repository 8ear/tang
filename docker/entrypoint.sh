#!/bin/bash
set -x

## Prepare Variables
TANG_CACHE_PATH=${TANG_CACHE_PATH:-"/var/cache/tang"}
CMD=${1:-"none"}

# Check if CMD is set
if [[ "$CMD" == "tangd-rotate-keys" ]] || [[ "$CMD" == "rotate-keys" ]] || [[ "$CMD" == "rotate" ]]; then
  "Start rotating keys..."
  exec tangd-rotate-keys -d "$TANG_CACHE_PATH"
  "End rotating keys..."
fi

# Check if CMD is set
if [[ "$CMD" == "bash" ]] || [[ "$CMD" == "sh" ]] ; then
  exec bash
  exit 0
fi

## Prepare Log
echo "=================================="
echo "`date`:"

# Check if keys already exists, if not create one
if [[ -f "$TANG_CACHE_PATH/*.jwk" ]]; then
  echo "No keys exists, generate some..."
  tangd-rotate-keys -d "$TANG_CACHE_PATH"
  echo "... done"
fi

## Start Application
socat -d TCP-LISTEN:80,reuseaddr,fork exec:"tangd $TANG_CACHE_PATH"
