OS_DESCRIPTION=$(lsb_release -d -s)
OS_TYPE=$(lsb_release -i -s)
OS_VERSION=$(lsb_release -r -s)

function install_for_u20_04() {
	#Download setup file
	curl -fLo ~/20.04_set_up.sh https://raw.githubusercontent.com/msaio/hf/master/WSL/20.04_set_up.sh	
	#Give permission for excuting setup file
	chmod +x ~/20.04_set_up.sh
	#Now excute it
	cd ~
	./20.04_set_up.sh
	#End
	echo "------------"
	rm -rf ~/20.04_set_up.sh
	echo "Finished!"
}

function install_for_u18_04() {
	#Download setup file
	curl -fLo ~/18.04_set_up.sh https://raw.githubusercontent.com/msaio/hf/master/WSL/18.04_set_up.sh	
	#Give permission for excuting setup file
	chmod +x ~/18.04_set_up.sh
	#Now excute it
	cd ~
	./18.04_set_up.sh
	#End
	echo "------------"
	rm -rf ~/18.04_set_up.sh
	echo "Finished!"
}

#-----------------------RUN------------------------#
echo "Hello $USER! As i can see, you are currently using _-$OS_DESCRIPTION-_"
	echo "------------"
echo "Let me check a little bit if you can run this installation..."
	echo "------------"

sleep 1
echo -ne '[##                                               ](5%)\r'
sleep 1
echo -ne '[#### #### ##                                     ](25%)\r'
sleep 1

if  [ $OS_TYPE = "Ubuntu" ]
then

	echo -ne '[#### #### #### #### ####                         ](50%)\r'
	sleep 1
	echo -ne '[#### #### #### #### #### #### #### ####          ](80%)\r'
	sleep 1
	echo -ne '[#### #### #### #### #### #### #### #### #### ####](100%)\r'
	sleep 1
	echo -ne '\n'

	echo "OK! Your OS is good!"
	echo "------------"
	case $OS_VERSION in
		20.04 )
			echo "About to install on $OS_DESCRIPTION"
			#Installation for u20.04
			install_for_u20_04
			;;
		18.04 )
			echo "About to install on $OS_DESCRIPTION"
			#Installation for u18.04
			install_for_u18_04
			;;
		* )
			echo "Oops! Your Ubuntu version has not been supported offically."
			#Give further options
			;;
	esac
else
	echo "------------"
	echo -ne '\n'
	echo "Oh sorry! I haven't support your OS"
	#Give further options
fi
