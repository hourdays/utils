#! /bin/bash

# Start
echo "Please enter your name"
read name
echo "Hello $name, nice to meet you!"

# Grab active MarkLogic version
# returns something like: 9.0-7
# the following line should work on all unix platforms assuming awk is installed
VERSION="$(grep "MarkLogic Server" ~/Library/StartupItems/MarkLogic/StartupParameters.plist | awk '{print substr($3,1,length($3)-9)}')"
echo "The current active version is: $VERSION"
# on macOS one can do the following as well
#defaults read ~/Library/StartupItems/MarkLogic/StartupParameters.plist Description | awk '{print $3}'
DATE="$(date +'%Y%m%d%H%M%S')"

# Try to find other MarkLogic versions
# List them all (ultimately list also what apps are bound to each version)
# Ask the user which one he/she wants to switch to (with option to exit)

cd ~/Library
printf "Please select the version you want to switch to:\n"
select d in MarkLogic_*; do test -n "$d" && break; echo ">>> Invalid Selection"; done
#cd "$d" && pwd

suffix=$(echo $d | awk -F _ '{ print $2 }')
new_version=$(echo $suffix | awk -F + '{ print $1 }')

# Inform that MarkLogic will be stopped and ask for confirmation or exit
echo "You've decided to switch to $d, do you want to continue?"
echo "Answer Yes or No. Yes will stop MarkLogic and rename relevent folders whereas No will exit this script."
select yn in "Yes" "No"; do
    case $REPLY in
        Yes )
			echo "Stop MarkLogic"
            ~/Library/StartupItems/MarkLogic/MarkLogic stop
            
            echo "Deactivate version $VERSION"
            mv ~/Library/MarkLogic ~/Library/MarkLogic_"$VERSION+$DATE"
            mv ~/Library/Application\ Support/MarkLogic ~/Library/Application\ Support/MarkLogic_"$VERSION+$DATE"
            sudo mv ~/Library/StartupItems/MarkLogic ~/Library/StartupItems/MarkLogic_"$VERSION+$DATE"
            mv ~/Library/PreferencePanes/MarkLogic.prefPane ~/Library/PreferencePanes/MarkLogic.prefPane_"$VERSION+$DATE"

            echo "Activate version $new_version"
            mv ~/Library/"$d" ~/Library/MarkLogic
            mv ~/Library/Application\ Support/"$d" ~/Library/Application\ Support/MarkLogic
            sudo mv ~/Library/StartupItems/"$d" ~/Library/StartupItems/MarkLogic
            mv ~/Library/PreferencePanes/MarkLogic.prefPane_"$suffix" ~/Library/PreferencePanes/MarkLogic.prefPane

            break;;
        No ) 
            echo "Exit";
            exit 1;;
        *)
            echo "Incorrect choice";
            break;;
    esac
done

# Report
echo "Version $new_version successfully activated."

# Ask if it should be started

# End
