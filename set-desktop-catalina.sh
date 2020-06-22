#!/bin/bash


# Delete everything from the dock and replace it with a specific selection of apps.
./dockutil --remove all --no-restart

# We add a delay so that the dock has time to initialize the removal
sleep 2

# Finally, add our applications
./dockutil --add /Applications/Safari.app --no-restart
./dockutil --add /System/Applications/Utilities/Terminal.app --no-restart
./dockutil --add /Applications/Prime95.app --no-restart
./dockutil --add /Applications/FurMark.app --no-restart
./dockutil --add '/Applications' --view list 
