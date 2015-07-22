#!/bin/bash
usb_dir=/media/RICO
test -d  $usb_dir&& umount $usb_dir&&echo "ok!$usb_dir" || echo "not exist!"
