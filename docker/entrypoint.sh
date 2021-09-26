#!/bin/sh
## Prepare Variables
TANG_CACHE_PATH=${TANG_CACHE_PATH:-"/var/cache/tang"}

## Prepare Log
echo "==================================" > /dev/stdout
echo `date`: >> /var/log/tangd.log > /dev/stdout

## Start Application
/usr/libexec/tangd $TANG_CACHE_PATH > /dev/stdout >2& /dev/stderr
