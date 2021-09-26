#!/bin/sh
## Prepare Variables
TANG_CACHE_PATH=${TANG_CACHE_PATH:-"/var/cache/tang"}

## Prepare Log
echo "=================================="
echo "`date`:"

## Start Application
tangd $TANG_CACHE_PATH
