***REMOVED***!/bin/sh
***REMOVED*** $1 = path to copy to

copy() {
  while IFS="" read -r p || [ -n "$p" ]
  do
    if [ -z "$(which cpg)" ]; then
      cpg -g -ri "$p" $1
    else
      cp -ri "$p" $1
    fi
  done <<< "$(tail +2 ~/.local/share/lf/files)"
}

move() {
  while IFS="" read -r p || [ -n "$p" ]
  do
    if [ -z "$(which mvg)" ]; then
      mvg -g -i "$p" $1
    else
      mv -i "$p" $1
    fi
  done <<< "$(tail +2 ~/.local/share/lf/files)"
}

COLS=$(($(tput cols)/3))
case "$(head -1 ~/.local/share/lf/files)" in
  copy)
    tmux split-window -h -p $COLS -- move "$1"
    ;;
  move)
    tmux split-window -h -p $COLS -- copy "$1"
    ;;
esac
