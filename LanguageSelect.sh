#!/bin/bash

# Script to set the system default language
# I'd use profiles if I wanted to lock these settings down, but I only wish to set them once. Hence this script.

# Author: Richard Purves <richard at richard - purves dot com>
# Version 1.0 : 25-08-2016 - Initial version
# Version 1.1 : 25-08-2016 - reworked for specific countries plus other localisation settings.

country=$4

case $country in

ch)
	langspec="3"
	lang="de"
	keyboard="Swiss German"
	kbid="19"
	region="de_CH"
;;

uk)
	langspec="1"
	lang="en"
	keyboard="British"
	kbid="2"
	region="en_GB"
;;

us)
	langspec="1"
	lang="en"
	keyboard="U.S."
	kbid="0"
	region="en_US"
;;

sg)
	langspec="1"
	lang="en"
	keyboard="U.S."
	kbid="2"
	region="en_SG"
;;

au)
	langspec="1"
	lang="en"
	keyboard="Australian"
	kbid="15"
	region="en_AU"
;;

pl)
	langspec="18"
	lang="pl"
	keyboard="Polish"
	kbid="30762"
	region="pl_PL"
;;

*)
	#generic setting. allows user to configure manually later. japanese and other non roman languages require different settings.
	langspec="1"
	lang="en"
	keyboard="U.S."
	kbid="0"
	region="en_US"
;;

esac

# Set system language here. This mainly affects the loginwindow.
languagesetup -langspec "$langspec"

# Set region settings here for /Library
/usr/libexec/Plistbuddy -c "Delete :AppleLocale" "/Library/Preferences/.GlobalPreferences.plist" &>/dev/null
/usr/libexec/Plistbuddy -c "Add :AppleLocale string ${region}" "/Library/Preferences/.GlobalPreferences.plist" &>/dev/null
/usr/libexec/Plistbuddy -c "Delete :Country" "/Library/Preferences/.GlobalPreferences.plist" &>/dev/null
/usr/libexec/Plistbuddy -c "Add :Country string ${region:3:2}" "/Library/Preferences/.GlobalPreferences.plist" &>/dev/null

# Set region settings here for User Template
for uthome in "/System/Library/User Template"/*
do
	if [ -d "${uthome}"/Library/Preferences ]
	then
		/usr/libexec/Plistbuddy -c "Delete :AppleLocale" "${uthome}/Library/Preferences/.GlobalPreferences.plist" &>/dev/null
		/usr/libexec/Plistbuddy -c "Add :AppleLocale string ${region}" "${uthome}/Library/Preferences/.GlobalPreferences.plist" &>/dev/null
		/usr/libexec/Plistbuddy -c "Delete :Country" "${uthome}/Library/Preferences/.GlobalPreferences.plist" &>/dev/null
		/usr/libexec/Plistbuddy -c "Add :Country string ${region:3:2}" "${uthome}/Library/Preferences/.GlobalPreferences.plist" &>/dev/null
	fi
done

# Set user language for /Library
/usr/libexec/Plistbuddy -c "Delete :AppleLanguages" "/Library/Preferences/com.apple.HIToolbox.plist" &>/dev/null
if [ ${?} -eq 0 ]
then
	/usr/libexec/Plistbuddy -c "Add :AppleLanguages array" "/Library/Preferences/com.apple.HIToolbox.plist" &>/dev/null
	/usr/libexec/Plistbuddy -c "Add :AppleLanguages:0 string '${lang}'" "/Library/Preferences/com.apple.HIToolbox.plist" &>/dev/null
fi

# Set keyboard settings here
/usr/libexec/Plistbuddy -c "Delete :AppleCurrentKeyboardLayoutInputSourceID" "/Library/Preferences/com.apple.HIToolbox.plist" &>/dev/null

if [ ${?} -eq 0 ]
then
	/usr/libexec/Plistbuddy -c "Add :AppleCurrentKeyboardLayoutInputSourceID string com.apple.keylayout.${kb}" "/Library/Preferences/com.apple.HIToolbox.plist" &>/dev/null
fi

for source in AppleDefaultAsciiInputSource AppleCurrentAsciiInputSource AppleCurrentInputSource AppleEnabledInputSources AppleSelectedInputSources
do
	/usr/libexec/Plistbuddy -c "Delete :${source}" "/Library/Preferences/com.apple.HIToolbox.plist"  &>/dev/null
	if [ ${?} -eq 0 ]
	then
		/usr/libexec/Plistbuddy -c "Add :${source} array" "/Library/Preferences/com.apple.HIToolbox.plist" &>/dev/null
		/usr/libexec/Plistbuddy -c "Add :${source}:0 dict" "/Library/Preferences/com.apple.HIToolbox.plist" &>/dev/null
		/usr/libexec/Plistbuddy -c "Add :${source}:0:InputSourceKind string 'Keyboard Layout'" "/Library/Preferences/com.apple.HIToolbox.plist" &>/dev/null
		/usr/libexec/Plistbuddy -c "Add :${source}:0:KeyboardLayout\ ID integer ${kbid}" "/Library/Preferences/com.apple.HIToolbox.plist" &>/dev/null
		/usr/libexec/Plistbuddy -c "Add :${source}:0:KeyboardLayout\ Name string '${keyboard}'" "/Library/Preferences/com.apple.HIToolbox.plist" &>/dev/null
	fi
done

# Force a recache of the plist since we made changes to it.
killall cfprefsd

# All done!

exit 0