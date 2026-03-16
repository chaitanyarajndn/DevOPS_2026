#!/bin/bash


<< DISCLAIMER

THIS SCRIPT IS FOR CHANGING PASSWORD

DISCLAIMER


function change_pass {


	#Loop created so that username should not be empty#

	while [ -z "$username" ]; do

		echo -e "\n"
		echo "................!!! USERNAME CANNOT BE EMPTY !!!................"
		echo -e "\n"
		read -p "Enter Username Again: " username
		echo -e "\n"
	
	done

	if grep -q "^$username:" /etc/passwd; then
		
		sudo passwd $username
	else
		echo -e "\n"

		echo "..............!!! USERNAME DOESNOT EXIST !!!....................."

		echo -e "\n"
	fi
	
}

while true; do
	
	echo -e "\n"

	read -p "Enter the username: " username

	change_pass 

	read -p "Do you want to continue ("Y/y" OR "N/n"): " C

        if [[ $C == [Yy] ]]; then

		echo -e "\n"

                read -p "Enter the username again: " username

		change_pass

	elif [[ $C == [Nn] ]]; then
		
		echo -e "\n"
 
		echo ".................# STOPPING THE SCRIPT #......................"
	
		echo -e "\n"

		break
	
	else
		echo -e "\n"

		echo "Enter correct Input either Y/y or N/n"

		echo -e "\n"
	
	fi

done

