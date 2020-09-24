#! /bin/bash

# Default shell
shell=$(echo $SHELL | cut -d'/' -f 3)

# Get the real IP from physics PC
realip=$(dig +noall +answer $(hostname -s) | tail -1 | cut -f 5)

# Get the IP of the virtual machine WSL
vmip=$(grep -oP "(?<=nameserver ).+" /etc/resolv.conf)
# Or
#vmip=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')
#vmip=$(grep nameserver /etc/resolv.conf | awk '{print $2}')

# Gain access to C: drive

echo "The current default shell: $shell"
echo "The Real-IP is:            $realip"
echo "The virtual-IP is:         $vmip"
echo "-----------------------------------------"

# Update and Upgrade
sudo apt-get update -y
sudo apt-get upgrade -y
# GIT
echo "-----------------------------------------"
echo "Do you want to set up GIT ?"
select yn in "Yes" "No"; do
  case $yn in
    Yes )
      sudo apt install git -y
      git config --global color.ui true
      # Give permission to access external drive
      git config --add --global core.filemode false
      # Remember credential after first pull or push
      git config --global credential.helper store
      # Add name and email to global
      while true; do
        echo "-----------------------------------------"
        read -p "Enter your global user.name (git): " git_username
        read -p "Enter your global user.email: " git_email
        echo "Github username will be: $git_username"
        echo "Github email will bee: $git_email"
        read -p "Are you sure? y/n" yn
        case $yn in
          [Yy]* )
            git config --global user.name "$git_username"
            git config --global user.email "$git_email"
            echo "user: $git_username - email: $git_email"
            break;;
          [Nn]* )
            echo "Enter again, please"
            ;;
          * )
            echo "Please answer yes or no."
            ;;
        esac
      done

      # Generate Key and authorized_keys file
      mkdir ~/.ssh -p
      ssh-keygen -t rsa -b 4096 -C "$git_email" -P '' -f ~/.ssh/id_rsa
      cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
      chmod 0600 ~/.ssh/authorized_keys
      echo "-----------------------------------------"
      echo "You must copy public key below and add to github"
      cat ~/.ssh/id_rsa.pub
      # Check connection to Github
      echo "-----------------------------------------"
      echo "Do you wanna check connection?"
      select yn in "Yes" "No"; do
        case $yn in
          Yes )
            ssh -T git@github.com -o PreferredAuthentications=publickey -i ~/.ssh/id_rsa;
            break;;
          No )
            echo "If something happened, u must add key manully later.";
            break;;
        esac
      done
      break
      ;;
    No  )
      break
      ;;
  esac
done

##########################

###############################################################
# NEOVIM
echo "-----------------------------------------"
echo "Do you want to set up NEOVIM ?"
select yn in "Yes" "No"; do
  case $yn in
    Yes )
      # Install neovim
      sudo apt install neovim -y
      # Install python
      sudo apt install python python3 -y
      # Install pip
			sudo add-apt-repository universe
			sudo apt update
			sudo apt install python2
			curl https://bootstrap.pypa.io/get-pip.py --output ~/get-pip.py
			sudo python2 ~/get-pip.py
			sudo apt install python3-pip
			# Upgrade pip
      sudo python3 -m pip install pip --upgrade --force
      sudo python -m pip install pip --upgrade --force
      # Install c/c++ stuff
      sudo apt install g++ gcc make cmake -y
      # Other stuff
      sudo apt install build-essential python3-dev -y

      # Plugin
      # 1st, create ~/.config/nvim/init.vim
      mkdir ~/.config/nvim -p
      touch ~/.config/nvim/init.vim
      # 2nd, install Vim-Plug
      curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      # 3rd, get public config file from github.com/msaio
      curl -fLo ~/.config/nvim/init.vim https://raw.githubusercontent.com/msaio/hf/master/U20.04/init.vim
      # 4th, install plugin
      nvim +PlugInstall +qall
      sudo python3 ~/.config/nvim/plugged/YouCompleteMe/install.py --clangd-completer
      sudo python3 ~/.config/nvim/plugged/YouCompleteMe/install.py --all
      break
      ;;
    No  )
      break
      ;;
  esac
done
##########################

###############################################################
# BASH_IT or OH_MY_ZSH
echo "-----------------------------------------"
echo "Do you want to set up SHELL?"
select yn in "Yes" "No"; do
  case $yn in
    Yes )
      # Select (Can be install alongside in next setup)
      echo "BASH-IT or OH_MY_ZSH ?"
      select choice in "BASH-IT" "OhMyZSH"; do
        case $choice in
          BASH-IT )
            shell="bash_it"
            break
            ;;
          OhMyZSH )
  	  		  shell="oh_my_zsh"
			      break
			      ;;
	      esac
      done
      echo "-----------------------------------------"
      echo "Ok, let's install $shell"
      case $shell in
        bash_it )
          # 1st, download bash_it
          git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
          # 2nd, install bash_it
          ~/.bash_it/install.sh -s
          # 3rd, get public config file from github.com/msaio
          curl -fLo ~/.bashrc https://raw.githubusercontent.com/msaio/hf/master/U20.04/.bashrc
          # 4th, bash_it as default
          sudo chsh -s /bin/bash
					source ~/.bashrc
          ;;
        oh_my_zsh )
          # 1st, install zsh
          sudo apt install zsh -y
          # 2nd, Download oh_my_zsh
          git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
          # 3rd, Install
          cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
          # 4th, BulletTrain theme
          curl -fLo $ZSH_CUSTOM/themes/bullet-train.zsh-theme https://raw.githubusercontent.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme
		      sed -i "s/ZSH_THEME.*/ZSH_THEME\=\"bullet-train\"/g" ~/.zshrc
		      # 5th, zsh as default
		      sudo chsh -s /bin/zsh
					source ~/.zshrc
          ;;
      esac
      break
      ;;
    No  )
      break
      ;;
  esac
done
##########################

###############################################################
echo "-----------------------------------------"
# GUI FOR WSL
echo "Do you want to set up GUI?"
select yn in "Yes" "No"; do
  case $yn in
    Yes )
			# Download x-server (https://sourceforge.net/projects/xming/
			echo "Download X-ming ..."
			curl -fLo /mnt/c/Users/uiw/Downloads/x-server.exe https://sourceforge.net/projects/xming/files/latest/Downloads
			# Set up x-server
			echo "Install X-ming"
			cd /mnt/c/Users/uiw/Downloads/ && cmd.exe /c x-server.exe & cd
			# An instalation will popups, finish it then return to terminal
			read -p "Install X-ming on Windows then ENTER."

      echo "Are you using WSL1 or WSL2 ?"
      select edition in "WSL1" "WSL2"; do
        case $edition in
          WSL1  )

            if [ $shell == "oh_my_zsh" ] || [ $shell == "zsh" ]
						then
              echo "export DISPLAY=:0" >> ~/.zshrc
            elif [ $shell == "bash_it" ] || [ $shell == "bash" ]
						then
              echo "#export DISPLAY=:0" >> ~/.bashrc
            fi
            break
            ;;
          WSL2  )
						# get required configuration for wsl 2 GUI
						curl -fLo ~/config.xlaunch https://raw.githubusercontent.com/msaio/hf/master/config.xlaunch

            if [ $shell == "oh_my_zsh" ] || [ $shell == "zsh" ]
						then
							echo "Added to .zshrc"
              echo "export DISPLAY=$realip:0" >> ~/.zshrc
            elif [ $shell == "bash_it" ] || [ $shell == "bash" ]
						then
							echo "Added to .bashrc"
              echo "#export DISPLAY=$realip:0" >> ~/.bashrc
            fi
            break
            ;;
        esac
      done
			source ~/.bashrc
			echo "One more thing: "
      echo "X-server is must"
      echo "I highly recommend using X410 from Microsoft store if you have plenty money"
      echo "If not, Xming/Xserver is your best choice"
      echo "Highly recommend this:"
			echo "------------"
      echo "https://sourceforge.net/projects/xming/"
			echo "------------"
      break
      ;;
    No  )
      break
      ;;
  esac
done
##########################

###############################################################
echo "-----------------------------------------"
# AUDIO ON WSL
echo "Do you want to setup Audio?"
select yn in "Yes" "No"; do
  case $yn in
    Yes )
			# Download dependencies
			sudo apt install unzip -y
			sudo apt install libpulse0 -y
			mkdir /mnt/c/wsl
			# Download pulseaudio for windows
			curl -fLo /mnt/c/wsl/pulseaudio-1.1.zip http://bosmans.ch/pulseaudio/pulseaudio-1.1.zip
			# Unpack
			sudo unzip /mnt/c/wsl/pulseaudio-1.1.zip -d /mnt/c/wsl/
			# Edit config
			sed -i "42s/.*/load-module module-waveout sink_name=output source_name=input record=0/" /mnt/c/wsl/etc/pulse/default.pa
			sed -i "61s/.*/load-module module-native-protocol-tcp auth-ip-acl=$(dig +noall +answer $(hostname -s) | tail -1 | cut -f 5)/" /mnt/c/wsl/etc/pulse/default.pa
			sed -i "39s/.*/exit-idle-time = -1/" /mnt/c/wsl/etc/pulse/daemon.conf

			if [ $shell == "oh_my_zsh" ] || [ $shell == "zsh" ]
			then
				echo "Added to .zshrc"
				echo "export PULSE_SERVER=tcp:$realip" >> ~/.zshrc
			elif [ $shell == "bash_it" ] || [ $shell == "bash" ]
			then
				echo "Added to .bashrc"
				echo "#export PULSE_SERVER=tcp:$realip" >> ~/.bashrc
			fi
			source ~/.bashrc

			echo "Microsoft does not support sound on WSL right now."
			echo "Pulseaudio is your friend."
			echo "Check this link for more info:"
			echo "https://x410.dev/cookbook/wsl/enabling-sound-in-wsl-ubuntu-let-it-sing/"

      break
      ;;
    No  )
      break
      ;;
  esac
done

##########################

###############################################################
# OH MY TMUX
echo "-----------------------------------------"
echo "Do you want to set up TMUX?"
select yn in "Yes" "No"; do
  case $yn in
    Yes )
      # 1st, Get dependencies
      sudo apt install awk perl sed tmux -y
      # 2nd, Download
      cd
      git clone https://github.com/gpakosz/.tmux.git
      # 3rd, Set up
      ln -s -f .tmux/.tmux.conf
      cp .tmux/.tmux.conf.local .
      # 4th, Get public settings
			curl -fLo ~/.tmux.conf https://raw.githubusercontent.com/msaio/hf/master/.tmux.conf
			curl -fLo ~/.tmux.conf.local https://raw.githubusercontent.com/msaio/hf/master/.tmux.conf.local
      break
      ;;
    No  )
      break
      ;;
  esac
done
##########################
echo "-----------------------------------------"
echo "OK, thank you for using this installation."
echo "Reopen terminal to take fully effect."
echo "-----------------------------------------"
echo "------------------END--------------------"
