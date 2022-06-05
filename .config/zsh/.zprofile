if [[ $TTY = "/dev/tty1" ]]; then
    pgrep i3; startx "/home/mokou/.config/x11/xinitrc"
fi
