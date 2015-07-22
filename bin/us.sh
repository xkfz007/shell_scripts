#!/bin/bash
usb_dir=/media/SKIPPER
test -d  $usb_dir&& umount $usb_dir&&echo "ok!$usb_dir" || echo "not exist!"
