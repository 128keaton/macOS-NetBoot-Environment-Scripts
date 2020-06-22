#!/bin/sh

# Determine OS version
osvers=$(sw_vers -productVersion | awk -F. '{print $2}')
sw_vers=$(sw_vers -productVersion)

sw_build=$(sw_vers -buildVersion)

# Checks first to see if the Mac is running 10.7.0 or higher. 
# If so, the script checks the system default user template
# for the presence of the Library/Preferences directory.
#
# If the directory is not found, it is created and then the
# iCloud pop-up settings are set to be disabled.

if [[ ${osvers} -ge 7 ]]; then

 for USER_TEMPLATE in "/System/Library/User Template"/*
  do
    defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant DidSeeCloudSetup -bool TRUE
    defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant GestureMovieSeen none
    defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant.plist DidSeePrivacy -bool TRUE
	defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant.plist DidSeeiCloudLoginForStorageServices -bool TRUE
	defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant.plist LastSeenCloudProductVersion "${sw_vers}"
	defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant.plist LastSeenBuddyBuildVersion "${sw_build}"
	defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant.plist DidSeeSiriSetup -bool TRUE
	defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant.plist DidSeeSyncSetup -bool TRUE
	defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant.plist DidSeeSyncSetup2 -bool TRUE
	defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant.plist SkipFirstLoginOptimization -bool TRUE
	defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.Siri.plist StatusMenuVisible -bool FALSE 
  done

 # Checks first to see if the Mac is running 10.7.0 or higher.
 # If so, the script checks the existing user folders in /Users
 # for the presence of the Library/Preferences directory.
 #
 # If the directory is not found, it is created and then the
 # iCloud pop-up settings are set to be disabled.
 UserName=$( dscl . -list /Users PrimaryGroupID | grep ' 20$' | awk '{print $1}' )
 for DIR in $UserName
 do
 	mkdir -p /Users/"${DIR}"
 done
 for USER_HOME in /Users/*
  do
    USER_UID=`basename "${USER_HOME}"`
    if [ ! "${USER_UID}" = "Shared" ] 
    then
      if [ ! -d "${USER_HOME}"/Library/Preferences ]
      then
        mkdir -p "${USER_HOME}"
        chown "${USER_UID}" "${USER_HOME}"
        mkdir -p "${USER_HOME}"/Library/Preferences
        chown "${USER_UID}" "${USER_HOME}"/Library
        chown "${USER_UID}" "${USER_HOME}"/Library/Preferences
      fi
      if [ -d "${USER_HOME}"/Library/Preferences ]
      then
		defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant.plist DidSeeCloudSetup -bool TRUE
		defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant.plist GestureMovieSeen none
		defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant.plist DidSeePrivacy -bool TRUE
		defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant.plist DidSeeiCloudLoginForStorageServices -bool TRUE
		defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant.plist LastSeenCloudProductVersion "${sw_vers}"
		defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant.plist LastSeenBuddyBuildVersion "${sw_build}"
		defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant.plist DidSeeSiriSetup -bool TRUE
		defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant.plist DidSeeSyncSetup -bool TRUE
		defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant.plist DidSeeSyncSetup2 -bool TRUE
		defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant.plist SkipFirstLoginOptimization -bool TRUE
		defaults write "${USER_HOME}"/Library/Preferences/com.apple.Siri.plist StatusMenuVisible -bool FALSE 
		defaults write /Library/Preferences/com.apple.loginwindow SHOWFULLNAME -bool true
        chown -R "${USER_UID}" "${USER_HOME}"/Library/
        chown "${USER_UID}" "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant.plist
      fi
    fi
  done
fi
exit
