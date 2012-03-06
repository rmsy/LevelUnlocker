#!/bin/bash
#LevelUnlocker by Isaac Moore
#v2
#3/5/12

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
appdir=$(grep -i "Tiny Wings.app" /tmp/App_list.tmp)
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

cui=$(tr CUI cui <<< "$1")

#Hit my CloudApp URL with a GET for usage statistics
curl -L http://cl.ly/ESUd

if [ ! -e /usr/bin/sbalert ]; then
    echo "sbutils is not installed. "
    read -p "Would you like to install it now? [Y/N] " response
    response=$(tr y Y <<< "$response")
    if [ "$response" = "Y" ]; then
        if [ -e /usr/bin/wget ]; then
            echo $(wget https://github.com/downloads/innoying/iOS-sbutils/com.innoying.sbutils_1.0.2-4_iphoneos-arm.deb --no-check-certificate) >> /dev/null
            echo $(dpkg -i com.innoying.sbutils_1.0.2-4_iphoneos-arm.deb) >> /dev/null
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
    if [ "$cui" = "-cui" ]; then
        sbalert -t "Erica Utilities" -m "Erica Utils is not installed. Install it now?" -d "Yes" -a "No"
        response=$(echo $?)
        if [ "$response" = "0" ]; then
            if [ -e /usr/bin/apt-get ]; then
                apt-get install com.ericasadun.utilities -y -m
                sbalert -t "Success!" -m "Erica Utilities has been successfully installed! Hyaah!"
                exit 0
            else
                sbopenurl cydia://package/com.ericasadun.utilities
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
            fi
        else
                echo "Please install Erica Utilities from Cydia. "      
                exit 0
        fi
    fi
fi
#End Erica Utilities check

#We need coreutils. Checking for it (and prompting for install)...
if [ ! -e /usr/bin/tr ]; then
    if [ "$cui" = "-cui" ]; then
        sbalert -t "coreutils" -m "coreutils is not installed. Install it now?" -d "Yes" -a "No"
        response=$(echo $?)
        if [ "$response" = "0" ]; then
            if [ -e /usr/bin/apt-get ]; then
                apt-get install coreutils -y -m
                sbalert -t "Success!" -m "coreutils has been successfully installed! Hyaah!"
                exit 0
            else
                sbopenurl cydia://package/coreutils
                exit 0
            fi
        else
            sbalert -m "Please install coreutils from Cydia."
            exit 0
        fi
    else
        echo "coreutils is not installed. "
        read -p "Would you like to install it now? [Y/N] " response
        response=$(tr y Y <<< "$response")
        if [ "$response" = "Y" ]; then
            if [ -e /usr/bin/apt-get ]; then
                apt-get install coreutils
            else
                sbopenurl cydia://package/coreutils
                echo "Cydia has been opened to coreutils on the device. "
                exit 0
            fi
        else
                echo "Please install coreutils from Cydia. "      
                exit 0
        fi
    fi
fi
#End coreutils check

#Checking for wget
if [ ! -e /usr/bin/wget ]; then
    if [ "$cui" = "-cui" ]; then
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
    fi
                
fi
#End wget check

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
if [ "$cui" = "-s" ]; then
        supported
elif [ "$cui" = "-h" ]; then
		help
fi

#Cut the Rope
#by Isaac Moore

appdir=$(grep -i "CutTheRope.app" /tmp/App_list.tmp)
if [ ! -z "$appdir" ]; then
    echo $(killall CutTheRope) >> /dev/null
    for box in {0..5}
    do
        for lvl in {0..24}
        do
            key="UNLOCKED_${box}_$lvl"
            cd "$appdir"
            cd "../Library/Preferences"
            plutil -key "$key" -value '1' "com.chillingo.cuttherope.plist" 2>&1> /dev/null
        done
    done
    if  [ "$cui" = "-cui" ]; then
        echo "Successfully unlocked Cut the Rope!"
    else
        sbalert -t "Success!" -m "Cut the Rope was successfully unlocked! Huzzah!"
    fi
fi

#Cut the Rope Holiday Gift
#by Isaac Moore

appdir=$(grep -i "CutTheRopeGift.app" /tmp/App_list.tmp)
if [ ! -z "$appdir" ]; then
    echo $(killall CutTheRopeGift) >> /dev/null
    for box in {0..5}
    do
        for lvl in {0..24}
        do
            key="UNLOCKED_${box}_$lvl"
            cd "$appdir"
            cd "../Library/Preferences"
            plutil -key "$key" -value '1' "com.chillingo.cuttheropexmas.plist" 2>&1> /dev/null
        done
    done
    if  [ "$cui" = "-cui" ]; then
        echo "Successfully unlocked Cut the Rope: Holiday Gift!"
    else
        sbalert -t "Success!" -m "Cut the Rope: Holiday Gift was successfully unlocked! Huzzah!"
    fi
fi

#Cut the Rope Lite
#by Isaac Moore

appdir=$(grep -i "CutTheRopeLite.app" /tmp/App_list.tmp)
if [ ! -z "$appdir" ]; then
    echo $(killall CutTheRopeLite) >> /dev/null
    for box in {0..5}
    do
        for lvl in {0..24}
        do
            key="UNLOCKED_${box}_$lvl"
            cd "$appdir"
            cd "../Library/Preferences"
            plutil -key "$key" -value '1' "com.chillingo.cuttheropelite.plist" 2>&1> /dev/null
        done
    done
    if  [ "$cui" = "-cui" ]; then
        echo "Successfully unlocked Cut the Rope Lite!"
    else
        sbalert -t "Success!" -m "Cut the Rope Lite was successfully unlocked! Huzzah!"
    fi
fi

#Tiny Wings
#Multiplier by TheSexyPenguin
#High Score by Isaac Moore

appdir=$(grep -i "Tiny Wings.app" /tmp/App_list.tmp)
if [ ! -z "$appdir" ]; then
    echo $(killall Tiny\ Wings) >> /dev/null
    for multiplier in {0..30}
    do
        key="achievment${multiplier}"
        cd "$appdir"
		cd ../Documents
		plutil -key "$key" -true "gameState.plist" 2>&1> /dev/null
	done
	if [ "$cui" = "-cui" ]; then
	    echo "Successfully unlocked Tiny Wings! "
	    read -p "Tiny Wings supports high score editing. Would you like to edit your high score? [Y/N] " response
	    response=$(tr y Y <<< "$response")
	    if [ "$response" = "Y" ]; then
	        cd "$appdir"
	        cd ../Documents
	        highscore=$(plutil -key "highScoreEntry1" "gameState.plist")
	        read -p "Please enter a score higher than ${highscore}: " score
	        read -p "Please enter a name to be associated with this score: " name
	        plutil -key "highScoreEntry0" -value "$score" "gameState.plist" 2>&1> /dev/null
	        plutil -key "highScoreNameEntry0" -value "$name" "gameState.plist" 2>&1> /dev/null
	        echo "Tiny Wings' score was successfully changed! "
	    fi
	else
	    sbalert -t "Success!" -m "Tiny Wings was successfully unlocked!"
	    cd "$appdir"
	    cd ../Documents
	    highscore=$(plutil -key "highScoreEntry1" "gameState.plist")
	    score=$(sbalert -t "Tiny Wings" -m "Enter a score higher than: ${highscore}" -d "Modify" -a "Cancel" -p)
	    response=$(echo $?)
	    if [ "$response" = "0" ]; then
	        plutil -key "highScoreEntry0" -value "$score" "gameState.plist" 2>&1> /dev/null
	        name=$(sbalert -t "Tiny Wings" -m "Enter a name to be associated with this score:" -p)
	        plutil -key "highScoreNameEntry0" -value "$name" "gameState.plist" 2>&1> /dev/null
	        sbalert -t "Success!" -m "Tiny Wings' highscore was successfully changed! Huzzah!"
	    fi
	fi
fi

#Carcassonne
#By Isaac Moore

appdir=$(grep -i "Carcassonne.app" /tmp/App_list.tmp)
if [ ! -z "$appdir" ]; then
    networkStatus=$(sbnetwork foobar.com)
    if [ "$networkStatus" = "FAILED" ]; then
        if [ "$cui" = "-cui" ]; then
            echo "A network connection is required to unlock Carcassonne. "
        else
            sbalert -t "Connection Required" -m "A network connection is required to unlock Carcassonne."
        fi
    else
        echo $(killall Carcassonne) >> /dev/null
	    cd "$appdir"
	    cd "../Library/Preferences"
	    rm de.codingmonkeys.Carcassonne.plist
	    echo $(wget http://cl.ly/1z3f011u0G3y3R27292k/de.codingmonkeys.Carcassonne.plist) >> /dev/null
        rm /tmp/App_list.tmp
        if [ "$cui" = "-cui" ]; then
            echo "Carcassonne was successfully unlocked! "
        else
            sbalert -t "Success!" -m "Carcassonne was successfully unlocked! Huzzah!"
        fi
    fi
fi
exit 1