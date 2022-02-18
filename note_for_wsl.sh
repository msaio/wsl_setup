



***
    cp ~/.config/nvim/{init.vim,theme.vim,personal.vim,plugin.vim} /mnt/c/Users/msaio/Desktop/nvim/

    cp /mnt/c/Users/msaio/Desktop/nvim/{init.vim,theme.vim,personal.vim,plugin.vim} ~/.config/nvim/
***





# Install "add-apt-repository"
sudo apt install software-properties-common -y
# Add universe repository (universe is something for ubuntu)
sudo add-apt-repository universe
# Install man for more command information
sudo apt install man-db -y

# In this set-up oh-my-zsh has been removed and no longer be my option from now so bash-it is installed as default
# Assuming that running this script for default user

# Shit happen sometimes so update and upgrade is necessary
sudo apt update -y && sudo apt upgrade -y

# Kali come with no git installed so make sure git is availabale
sudo apt install git -y

# Downloading and installing bash-it with default setup, it mean old .bashrc will be backed up and replace with bash-it default configuration, currently i prefer this
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it && ~/.bash_it/install.sh --silent

# Apply "Sexy" bash-it theme, my personal favorite theme
sed -i '/BASH_IT_THEME/c\export BASH_IT_THEME="sexy"' ~/.bashrc

# Apply change for bash-it, this is not really necessary because we will need to restart terminal anyway
source ~/.bashrc


# I. Install neovim
sudo apt install neovim -y

# II. Install awesome set-up neovim
#	1. Install python2 python3
sudo apt install python python3 -y

#	2. Install gcc, g++, make
sudo apt install build-essential -y

#	3. Install pip2, pip3
#       Installing pip2 is quite simple
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output ~/get-pip2.py && sudo python2 ~/get-pip2.py

#       But pip3 may not work in kali due to 
#       "ModuleNotFoundError: No module named 'distutils.util'"
#       So we will install python3-distutils to fix this
sudo apt install python3-distutils -y

#       Then keep installing pip3 
curl https://bootstrap.pypa.io/get-pip.py --output ~/get-pip3.py && sudo python3 ~/get-pip3.py
#       After finishing installing, type "pip3" may not work but reopen terminal will be ok, don't worry

#       Remove the files after installing
sudo rm -rf ~/get-pip*

#   4. Neovim configurations and plugins
#       We're gonna download my config files and apply them 
mkdir ~/.config/nvim -p
#       Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#       Get config files
curl -fLo ~/.config/nvim/init.vim https://raw.githubusercontent.com/msaio/wsl_set_up/main/nvim/init.vim
curl -fLo ~/.config/nvim/plugin.vim https://raw.githubusercontent.com/msaio/wsl_set_up/main/nvim/plugin.vim
curl -fLo ~/.config/nvim/personal.vim https://raw.githubusercontent.com/msaio/wsl_set_up/main/nvim/personal.vim
curl -fLo ~/.config/nvim/theme.vim https://raw.githubusercontent.com/msaio/wsl_set_up/main/nvim/theme.vim

#       Set up for coc.nvim
#           - Install latest stable nodejs 
            * ( the original is without sudo, but in my case, i got permission denied, maybe i was working on wsl )
curl -sL install-node.now.sh | sudo bash -s -- --yes
#           - Install yarn
curl --compressed -o- -L https://yarnpkg.com/install.sh | bash && sudo rm -rf ~/node_modules ~/yarn.lock
#           - Add " Plug 'neoclide/coc.nvim', {'branch': 'release'} " to plugin.vim
#           * ( Assuming that we were using vim-plug )
#            then run
nvim +PlugInstall +qall
nvim +CocInstall\ coc-json +qall


#           - Add c_c++ snippet (i do both)

#           Option 1: clangd (language server) + coc-clangd (extension) + honza/vim-snippets (vim pluggin) + coc-snippets (extension)
#               > Install clangd server
sudo apt install clangd clang-tools -y
#               > Install coc-clangd extensions
nvim +CocInstall\ coc-clangd +qall
#               > Add honza/vim-snippets for more snippets
#                   -> add Plug "honza/vim-snippets" to config file then run
nvim +CocInstall\ coc-snippets +qall
#               * if using coc-clangd then dont config in coc-settings

#           Option 2: ccls (language server) + honza/vim-snippets (vim pluggin) + coc-snippets (extension)
#               > Install ccls server
sudo apt install ccls -y
#               > Add honza/vim-snippets for more snippets
#                   -> add Plug "honza/vim-snippets" to config file then run
nvim +CocInstall\ coc-snippets +qall
#               > Set ccls language server in :CocConfig
tee -a $NVIM_CFG/coc-settings.json <<EOF
{
"languageserver": {
  "ccls": {
    "command": "ccls",
    "filetypes": ["c", "cc", "cpp", "c++", "objc", "objcpp"],
    "rootPatterns": [".ccls", "compile_commands.json", ".git/", ".hg/"],
    "initializationOptions": {
        "cache": {
          "directory": "/tmp/ccls"
        }
      }
  }
}
}
EOF

#           - C/C++ formatter
#             > Install clang, clang-format
sudo apt install clang clang-format -y
#             > Add Plug 'sbdchd/neoformat' 
#             And some configs, it would be fine


