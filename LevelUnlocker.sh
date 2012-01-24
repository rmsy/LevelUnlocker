#LevelUnlocker by Isaac Moore
#Follow @iamramsey on Twitter
#-------------
#Thanks to:
#MadHouse (for practically teaching me bash)
#rastignac (whose scripts serve as a great Bash 101 lesson)
#dissident (without him, the scene might not even be where it is today)
#WYSE (Testing)
#Kaikz (making an awesome GUI)
#TheSexyPenguin (Tiny Wings multiplier)
#-------------
#Changelog:
#---
#v0.1: Support for one Application:
#-Cut the Rope
#---
#v0.1.2: Added support for:
#-Cut the Rope Holiday Gift
#---
#v0.1.3: Added support for:
#-Cut the Rope Lite
#---
#v0.2
#Fixed bug
#Added -s flag
#-------------
#v0.3
#Better Support for Kaikz's Haxie
#Outputs a supported app list to /var/mobile/supported_levelunlocker.txt
#---
#v0.3.1
#Added support for Cut the Rope Valentines Update
#-------------
#v0.4: Added support for:
#-Tiny Wings
#Introduced "High Score Editing" Feature
#-------------
#v0.4.5: Added support for:
#-Carcassonne
#Removed support for:
#-Cut the Rope
#New apps are added with every update.
#Feel free to help out with the effort, at:
#http://hackulo.us/
#-------------
#This script is VERY similar to dlc.sh.
#That's because the idea behind both is almost the same,
#as is the method used to carry them out.

function help
{
echo "Help: "
echo "----- "
echo "Run the script normally, to unlock levels. Run the script with -s, to list supported apps. "

#Exit
exit 1
}

function supported
{
echo "Supported Apps: "

#Cut the Rope
appdir=$(grep -i "CutTheRope.app" /tmp/App_list.tmp)
if [ ! -z "$appdir" ]; then
        echo "Cut the Rope - Chillingo "
fi

#Cut the Rope Holiday
appdir=$(grep -i "CutTheRopeGift.app" /tmp/App_list.tmp)
if [ ! -z "$appdir" ]; then
        echo "Cut the Rope Holiday Gift - Chillingo "
fi

#Cut the Rope Lite
appdir=$(grep -i "CutTheRopeLite.app" /tmp/App_list.tmp)
if [ ! -z "$appdir" ]; then
        echo "Cut the Rope Lite - Chillingo "
fi

#Tiny Wings
appdir=$(grep -i "TinyWings.app" /tmp/App_list.tmp)
if [ ! -z "$appdir" ]; then
        echo "Tiny Wings - Andreas Illiger "
fi

#Carcassonne
appdir=$(grep -i "Carcassonne.app" /tmp/App_list.tmp)
if [ ! -z "$appdir" ]; then
	echo "Carcassonne - The Coding Monkeys "
fi

#Remove apps list
rm -rf /tmp/App_list.tmp

#Exit
exit 1
}

#All the glitz:
clear
echo "LevelUnlocker by Isaac Moore "
echo "Follow @iamramsey on Twitter "
echo "Loading... "

#We need plutil. Checking for it (and prompting for install)...
if [ ! -e /usr/bin/plutil ]; then
        echo "Erica Utilities is not installed. "
        read -p "Would you like to install it now? [Y/N] " response
        if [ "$response" -eq "Y" ]; then
                clear
                echo "Installing..."
                apt-get install com.ericasadun.utilities
        else
                echo "Please install Erica Utilities from Cydia. "      
                exit 1
        fi
fi

#Checking for wget
if [ ! -e /usr/bin/wget ]; then
        echo "wget is not installed. "
        read -p "Would you like to install it now? [Y/N] " response
        if [ "$response" -eq "Y" ]; then
                clear
                echo "Installing..."
                apt-get install wget
        else
                echo "Please install wget from Cydia. "      
                exit 1
        fi
fi

#Loading supported apps list file...
#if [ -e "/var/mobile/supported_levelunlocker.txt" ]; then
#        rm -rf /var/mobile/supported_levelunlocker.txt
#fi
#echo "Cut the Rope - Chillingo " >> /var/mobile/supported_levelunlocker.txt
#echo "Cut the Rope Holiday Gift - Chillingo " >> /var/mobile/supported_levelunlocker.txt
#echo "Cut the Rope Lite - Chillingo " >> /var/mobile/supported_levelulocker.txt
#echo "Tiny Wings - Andreas Illiger " >> /var/mobile/supported_levelulocker.txt

#Checking for outdated apps list (and removing)...
if [ -e /tmp/applist ]; then
        rm -rf /tmp/applist
fi
if [ -e /var/mobile/supported_levelunlocker.txt ]; then
		rm /var/mobile/supported_levelunlocker.txt
fi

#Creating the apps list...
ls -d /var/mobile/Applications/*/*.app > /tmp/App_list.tmp

#Checking for operation flags...
if [ "$1" = "-s" ]; then
        supported
elif [ "$1" = "-h" ]; then
		help
fi

#Cut the Rope
#by Isaac Moore

echo "Looking for Cut the Rope... "
appdir=$(grep -i "CutTheRope.app" /tmp/App_list.tmp)
if [ ! -z "$appdir" ]; then
        echo "Unlocking levels..."
        echo "Please wait..."
        killall CutTheRope 2>&1> /dev/null
        for box in {0..5}
        do
                for lvl in {0..24}
                do
                        key="UNLOCKED_${box}_$lvl"
                        cd "$appdir"
                        cd "../Library/Preferences/"
                        plutil -key "$key" -value '1' "com.chillingo.cuttherope.plist" 2>&1> /dev/null
                        done
                done
                echo "Cut the Rope: Unlocked! "
fi

#Cut the Rope Holiday Gift
#by Isaac Moore

echo "Looking for Cut the Rope Holiday Gift... "
appdir=$(grep -i "CutTheRopeGift.app" /tmp/App_list.tmp)
if [ ! -z "$appdir" ]; then
        echo "Unlocking levels..."
        echo "Please wait..."
        killall CutTheRopeGift 2>&1> /dev/null
        for lvl in {0..24}
        do
                key="UNLOCKED_0_$lvl"
                cd "$appdir"
                cd "../Library/Preferences/"
                plutil -key "$key" -value '1' "com.chillingo.cuttheropexmas.plist" 2>&1> /dev/null
        done
        echo "Cut the Rope Holiday Gift: Unlocked! "
fi

#Cut the Rope Lite
#by Isaac Moore

echo "Looking for Cut the Rope Lite... "
appdir=$(grep -i "CutTheRopeLite.app" /tmp/App_list.tmp)
if [ ! -z "$appdir" ]; then
        echo "Unlocking levels..."
        echo "Please wait..."
        killall CutTheRopeLite 2>&1> /dev/null
        for box in {0..4}
        do
                for lvl in {0..5}
                do
                        key="UNLOCKED_${box}_$lvl"
                        cd "$appdir"
                        cd "../Library/Preferences/"
                        plutil -key "$key" -value '1' "com.chillingo.cuttheropelite.plist" 2>&1> /dev/null
                done
        done
        echo "Cut the Rope Lite: Unlocked! "
fi

#Tiny Wings
#Multiplier by TheSexyPenguin
#High Score by Isaac Moore

echo "Looking for Tiny Wings... "
appdir=$(grep -i "TinyWings.app" /tmp/App_list.tmp)
if [ ! -z "$appdir" ]; then
	echo "Unlocking levels..."
	echo "Please wait..."
    killall TinyWings 2>&1> /dev/null
    for multiplier in {0..26}
    do
        key="achievment${multiplier}"
        cd "$appdir"
		cd "../Library/Preferences/"
		plutil -key "$key" -true "com.andreasilliger.tinywings.plist" 2>&1> /dev/null
	done
    echo "Done. "
    echo "This application also supports high-score editing. "
    echo " "
    echo "----- "
    echo " "
    read -p "Would you like to edit your High Score? 1(yes)/0(no) " answer
    if [ $answer = "1" ]; then
        cd "$appdir"
        cd "../Library/Preferences/"
        highscore=$(plutil -key "highScoreEntry1" "com.andreasilliger.tinywings.plist")
        echo "Please enter a score higher than ${highscore} "
        read -p "Score: " answer
        cd "$appdir"
		cd "../Library/Preferences/"
        plutil -key "highScoreEntry0" -value "$answer" "com.andreasilliger.tinywings.plist" 2>&1> /dev/null
        echo "Enter a name to be associated with this score: "
		read -p ":" answer
        cd "$appdir"
        cd "../Library/Preferences/"
        plutil -key "highScoreNameEntry0" -value "$answer" "com.andreasilliger.tinywings.plist" 2>&1> /dev/null
        echo "High Score Changed"
    fi
    echo "Tiny Wings: Done! "
fi

#Carcassonne
#By Isaac Moore

echo "Looking for Carcassonne... "
appdir=$(grep -i "Carcassonne.app" /tmp/App_list.tmp)
if [ ! -z "appdir" ]; then
	echo "Unlocking achievements... "
	echo "Please wait... "
	killall Carcassonne 2>&1> /dev/null
	cd "$appdir"
	cd "../Library/Preferences/"
	rm de.codingmonkeys.Carcassonne.plist
	wget http://cl.ly/1z3f011u0G3y3R27292k/de.codingmonkeys.Carcassonne.plist
	echo "Achievements unlocked! "
fi
	
echo "Done! "

rm /tmp/App_list.tmp

exit