# This excludes timeshift folders from the output of locate

locate $1 | grep -v timeshift
