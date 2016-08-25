#!/bin/bash

# Script to set the system default language

# Author: Richard Purves <richard at richard - purves dot com>
# Version 1.0 : 25-08-2016 - Initial version

# Set up working variables from info passed to the script
language=$4

case $language in

	english)
		languagesetup -langspec 1
	;;

	french)
		languagesetup -langspec 2
	;;

	german)
		languagesetup -langspec 3
	;;

	simplifiedchinese)
		languagesetup -langspec 4
	;;

	traditionalchinese)
		languagesetup -langspec 5
	;;

	japanese)
		languagesetup -langspec 6
	;;

	spanish)
		languagesetup -langspec 7
	;;

	italian)
		languagesetup -langspec 8
	;;

	dutch)
		languagesetup -langspec 9
	;;

	korean)
		languagesetup -langspec 10
	;;

	portugesebrasil)
		languagesetup -langspec 11
	;;

	portugese)
		languagesetup -langspec 12
	;;

	danish)
		languagesetup -langspec 13
	;;

	finnish)
		languagesetup -langspec 14
	;;

	norwegian)
		languagesetup -langspec 15
	;;

	swedish)
		languagesetup -langspec 16
	;;

	russian)
		languagesetup -langspec 17
	;;

	polish)
		languagesetup -langspec 18
	;;

	turkish)
		languagesetup -langspec 19
	;;
	
	arabic)
		languagesetup -langspec 20
	;;
	
	thai)
		languagesetup -langspec 21
	;;
	
	czech)
		languagesetup -langspec 22
	;;
	
	hungarian)
		languagesetup -langspec 23
	;;
	
	catalan)
		languagesetup -langspec 24
	;;
	
	croatian)
		languagesetup -langspec 25
	;;
	
	greek)
		languagesetup -langspec 26
	;;
	
	hebrew)
		languagesetup -langspec 27
	;;
	
	romanian)
		languagesetup -langspec 28
	;;
	
	slovakian)
		languagesetup -langspec 29
	;;
	
	ukranian)
		languagesetup -langspec 30
	;;

	indonesian)
		languagesetup -langspec 31
	;;

	malay)
		languagesetup -langspec 32
	;;

	vietnamese)
		languagesetup -langspec 33
	;;

	mexicanspanish)
		languagesetup -langspec 34
	;;

	*)
		languagesetup -langspec 1
	;;

esac

# All done!

exit 0