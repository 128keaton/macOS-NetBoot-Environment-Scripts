#!/bin/bash

sleep 30
DOCKUTIL="/Library/Application Support/AutoNBI/Scripts/dockutil"

# Delete everything from the dock and replace it with a specific selection of apps.
"$DOCKUTIL" --remove all --no-restart

# We add a delay so that the dock has time to initialize the removal
sleep 2

# Finally, add our applications
"$DOCKUTIL" --add /Applications/Safari.app --no-restart
"$DOCKUTIL" --add /System/Applications/Utilities/Terminal.app --no-restart
"$DOCKUTIL" --add /Applications/Prime95.app --no-restart
"$DOCKUTIL" --add /Applications/FurMark.app --no-restart
"$DOCKUTIL" --add '/Applications' --view list
