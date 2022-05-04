***REMOVED*** This excludes timeshift folders from the output of locate

locate -i $1 | grep -v timeshift
