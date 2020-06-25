#!/bin/sh

loggedInUser=$(/bin/ls -l /dev/console | /usr/bin/awk '{ print $3 }')

checkTCCdone() {
  if [ -e /Users/"$loggedInUser"/Library/Preferences/TCCdone.txt ]; then
    echo "TCC.db has been modified."
    exit 0
  fi
}

configureTCCset() {
  /usr/bin/sqlite3 /Users/"$loggedInUser"/Library/Application\ Support/com.apple.TCC/TCC.db "INSERT or REPLACE INTO access VALUES('kTCCServiceAccessibility','com.keatonburleson.macOS-Utilities',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL)"
  /usr/bin/touch /Users/"$loggedInUser"/Library/Preferences/TCCdone.txt
}

checkTCCdone
configureTCCset

exit 0
