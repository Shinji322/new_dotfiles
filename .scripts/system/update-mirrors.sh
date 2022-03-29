#!/bin/sh
# This is a simple tool for generating mirrorlists

sudo reflector --latest 200 --protocol https --sort rate --save /etc/pacman.d/mirrorlist && notify-send "All mirrors have been ranked"
