#!/bin/bash
udisk=NETAC
path=/media/$udisk/
test -d $path && umount $path &&echo "ok!$path" || echo "not exist!"
