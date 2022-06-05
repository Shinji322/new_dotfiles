***REMOVED***!/bin/sh
***REMOVED*** Adaptable tmux resize script by percentage
***REMOVED***
***REMOVED*** Layout types supported (-l):
***REMOVED***
***REMOVED*** main-horizontal: top pane is main pane, panes split left to right on the bottom
***REMOVED*** main-vertical: left pane is maine pane, right panes split top to bottom on the
***REMOVED***                right side
***REMOVED***
***REMOVED*** Options:
***REMOVED*** 
***REMOVED*** -l layout-name (required): the name of the layout, "main-horizontal" or "main-vertical"
***REMOVED*** -p percentage (required): an integer of the percentage of the client width/height to set
***REMOVED*** -t target-window (optional): the tmux target for the window, can be an fnmatch(1) of the
***REMOVED***                              window name, index, or id
***REMOVED***
***REMOVED*** Example usage:
***REMOVED***
***REMOVED*** Case 1: Resize to a main-horizontal, main pane 66% of client height
***REMOVED*** $ ./scripts/resize-adaptable.sh -p 66 -l main-horizontal
***REMOVED***
***REMOVED*** Case 2: Same as Case 1, target "devel" window
***REMOVED*** $ ./scripts/resize-adaptable.sh -p 66 -l main-horizontal -t devel
***REMOVED***
***REMOVED*** Case 3: Resize to a main-horizontal, main pane half width
***REMOVED*** $ ./scripts/resize-adaptable.sh -p 50 -l main-vertical
***REMOVED***
***REMOVED*** Case 4: Same as Case 3, target "mywindow"
***REMOVED*** $ ./scripts/resize-adaptable.sh -p 50 -l main-vertical -t mywindow
***REMOVED***
***REMOVED*** Author: Tony Narlock
***REMOVED*** Website: https://devel.tech
***REMOVED*** License: MIT

lflag=
pflag=
tflag=
while getopts l:p:t: name;
do
    case $name in
    l)    lflag=1
	  layout_name=$OPTARG;;
    p)    pflag=1
          percentage="$OPTARG";;
    t)    tflag=1
          target="$OPTARG";;
    ?)   printf "Usage: %s: [-l layout-name] [-p percentage] [-t target-window]\n" $0
          exit 2;;
    esac
done

if [ ! -z "$pflag" ]; then
    if ! [ "$percentage" -eq "$percentage" ] 2> /dev/null; then
        printf "Percentage (-p) must be an integer" >&2
        exit 1
    fi
fi
if [ ! -z "$lflag" ]; then
    if [ $layout_name != 'main-horizontal' ] && [ $layout_name != 'main-vertical' ] ; then
        printf "layout name must be main-horizontal or main-vertical" >&2
        exit 1
    fi
fi

if [ "$layout_name" = "main-vertical" ]; then
    MAIN_PANE_SIZE=$(expr $(tmux display -p '***REMOVED***{window_width}') \* $percentage \/ 100)
    MAIN_SIZE_OPTION='main-pane-width'

fi

if [ "$layout_name" = "main-horizontal" ]; then
    MAIN_PANE_SIZE=$(expr $(tmux display -p '***REMOVED***{window_height}') \* $percentage \/ 100)
    MAIN_SIZE_OPTION='main-pane-height'
fi

if [ ! -z "$target" ]; then
    tmux setw -t $target $MAIN_SIZE_OPTION $MAIN_PANE_SIZE; tmux select-layout -t $target $layout_name
else
    tmux setw $MAIN_SIZE_OPTION $MAIN_PANE_SIZE; tmux select-layout $layout_name
fi

exit 0
