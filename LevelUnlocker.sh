#!/bin/bash
#LevelUnlocker by Isaac Moore

help() {
echo "LevelUnlocker: "
echo "[-h] Display this help "
echo "[-cui] Run in command-line mode "
echo "[-s] Display supported apps "
echo "Only one argument may be taken at a time "
echo "Run with no arguments to run in GUI mode "

exit 1
}

supported() {
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

clear
echo "LevelUnlocker by Isaac Moore "

#We need sbutils for pretty prompts :) Checking for it (and prompting for install)...
if [ ! -e /usr/bin/sbalert ]; then
    echo "sbutils is not installed. "
    read -p "Would you like to install it now? [Y/N] " response
    response=$(tr y Y <<< "$response")
    if [ "$response" = "Y" ]; then
        if [ -e /usr/bin/wget ]; then
            wget https://github.com/downloads/innoying/iOS-sbutils/com.innoying.sbutils_1.0.2-4_iphoneos-arm.deb --no-check-certificate
            dpkg -i com.innoying.sbutils_1.0.2-4_iphoneos-arm.deb
            rm com.innoying.sbutils_1.0.2-4_iphoneos-arm.deb
            clear
            echo "sbutils has been successfully installed. "
            echo "Please re-run the script. "
            exit 0
        else
            echo "Please install wget from Cydia and run again. "
            exit 0
        fi
    else
        echo "Please install sbutils. "
        exit 0
    fi
fi
#End sbutils check

#We need Erica Utilities. Checking for it (and prompting for install)...
if [ ! -e /usr/bin/plutil ]; then
    if [ "$1" = "-cui" ]; then
        sbalert -t "Erica Utilities" -m "Erica Utils is not installed. Install it now?" -d "Yes" -a "No"
        response=$(echo $?)
        if [ "$response" = "0" ]; then
            if [ -e /usr/bin/apt-get ]; then
                apt-get install com.ericasadun.utilities -y -m
                sbalert -t "Success!" -m "Erica Utilities has been successfully installed! Hyaah!"
                exit 0
            else
                sbopenurl cydia://com.ericasadun.utilities
                exit 0
            fi
        else
            sbalert -m "Please install Erica Utilities from Cydia."
            exit 0
        fi
    else
        echo "Erica Utilities is not installed. "
        read -p "Would you like to install it now? [Y/N] " response
        response=$(tr y Y <<< "$response")
        if [ "$response" = "Y" ]; then
            if [ -e /usr/bin/apt-get ]; then
                apt-get install com.ericasadun.utilities
            else
                sbopenurl cydia://package/com.ericasadun.utilities
                echo "Cydia has been opened to Erica Utilities on the device. "
                exit 0
        else
                echo "Please install Erica Utilities from Cydia. "      
                exit 0
        fi
fi
#End Erica Utilities check

#Checking for wget
if [ ! -e /usr/bin/wget ]; then
    if [ "$1" = "-cui" ]; then
        echo "wget is not installed. "
        read -p "Would you like to install it now? [Y/N] " response
        response=$(tr y Y <<< "$response")
        if [ "$response" -eq "Y" ]; then
            if [ -e /usr/bin/apt-get ]; then
                apt-get install wget
                exit 0
            else
                sbopenurl cydia://package/wget
                echo "Cydia has been opened to wget on your device. "
                exit 0
            fi
        else
            echo "Please install wget from Cydia. "      
            exit 0
        fi
    else
        sbalert -t "wget" -m "wget is not installed. Install it now?" -d "Yes" -a "No"
        response=$(echo $?)
        if [ "$response" = "0" ]; then
            if [ -e /usr/bin/apt-get ]; then
                apt-get install wget -y -m
                sbalert -t "Success!" -m "wget has been successfully installed! Hyaah!"
                exit 0
            else
                sbopenurl cydia://package/wget
                exit 0
            fi
        else
            sbalert -m "Please install wget from Cydia."
                
fi

#==DEPRECATED==
#if [ -e "/var/mobile/supported_levelunlocker.txt" ]; then
#        rm -rf /var/mobile/supported_levelunlocker.txt
#fi
#echo "Cut the Rope - Chillingo " >> /var/mobile/supported_levelunlocker.txt
#echo "Cut the Rope Holiday Gift - Chillingo " >> /var/mobile/supported_levelunlocker.txt
#echo "Cut the Rope Lite - Chillingo " >> /var/mobile/supported_levelulocker.txt
#echo "Tiny Wings - Andreas Illiger " >> /var/mobile/supported_levelulocker.txt
#==DEPRECATED==

#Checking for outdated and/or deprecated apps list (and removing)...
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