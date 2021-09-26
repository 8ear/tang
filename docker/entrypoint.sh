#!/bin/sh
## Prepare Variables
TANG_CACHE_PATH=${TANG_CACHE_PATH:-"/var/cache/tang"}

## Prepare Log
echo "=================================="
echo "`date`:"

# Check if keys already exists, if not create one
[ -f $TANG_CACHE_PATH/*.jwk ] || tangd-rotate-keys -d $TANG_CACHE_PATH

## Start Application
socat tcp-l:80,reuseaddr,fork exec:"tangd $TANG_CACHE_PATH"
