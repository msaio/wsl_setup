# WSL_allInOne

This is a fully step-by-step guide comes with installation file from my original [repository](github.com/msaio/hf)

sample.png

## 1. Requirements:

WSL 1: Windows Build 16215 or later.

WSL 2: Windows Builds 18917 or higher.
(Updated May 14th 2020, WSL 2 is not offically published so you need to join Insider to enable the features).


You can check your Windows version from powershell with command like this:
```powershell 
systeminfo | Select-String "^OS Name","^OS Version"
```
In my opinion, you should update the windows to the latest, this helps alot.

## 2. Installation:


### Step 1:
##### WSL 1: open powershell as administrator then type:
```powershell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```
##### WSL 2: Do the same thing as WSL 1 but add one more: ( MAKE SURE YOU ARE ALREADY IN INSIDER PROGRAM ).
```powershell		
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

### Step 2:
##### WSL 1:
Open Microsoft Store and search for keyword "WSL".
You can download Ubuntu16, Ubuntu18, Ubuntu20,... Up to you.
After downloading, a ternimal will pop-ups, enter your username and password.
Then done.
##### WSL 2: You need to change WSL to version 2 or the system will install WSL 1 as default.
Open Powershell or CMD and type:
```powershell
wsl wsl --set-default-version 2
```
##### * NOTE: Of course, you can run both WSL 1 and WSL 2 on your machine.

Then do the same thing as WSL 1 and done.

### Step 3: This is my personal setup. I have made it easier just in a single file. All you have to do is download the set_up.sh and run: (  )
```bash
./set_up.sh
```
##### * NOTE: If you got permission denied error, run this:
 ```bash 
 chmod +x set_up.sh
 ```

## 3. Explaination:
what is going on in my set_up.sh:

### I. First of all:
We are going to update and upgrade to the latest.

Then to set up GIT ( in this set up, i am going with github.com, i will update with more options ).

You have to add your username, email and go to github, manually add ssh key then check the connection.

OR just skip my GIT set-up

I will add more options in future like GPG keys instead or many reposities like heroku, bitbucket, gitlab, ...

### II. Secondly, We will set up editor.

In this installation, i am gonna set up with my personal configuration and also with plugins.

I'm kind of in love with neovim at the moment but i will definitely try other editors and add more options in future.

One more things, you can install vscode in Windows and call it from WSL. Microsoft has done a wonderful this for developers.

### III. On the third, I give you 2 most famous shell: BASH and ZSH.
In this installation, there are:

[Bash-it](github.com/Bash-it/bash-it) from github.com/Bash-it/bash-it

[OhMyZSH](github.com/ohmyzsh/ohmyzsh) from github.com/ohmyzsh/ohmyzsh

I prefer Bash-it because i did more personal config in .bashrc file than in .zshrc .

### IV. You can run Linux GUI program from WSL and also with sound.

WSL need X-server for GUI.
Check this link for detailed discussion about GUI on WSL 2: 
[Link](https://github.com/microsoft/WSL/issues/4106#issuecomment-608492570)

Audio is not supported at the moment but can be handle with pulseaudio. 
Check this out: 
[Link](https://x410.dev/cookbook/wsl/enabling-sound-in-wsl-ubuntu-let-it-sing/)

##### *NOTE: with bash-it setup, i write some commands:
- This will give you some option to choose ip ( in my case is opt 4, it works perfectly for me ) 
```bash
set_up_ip
```
- Run xming as default
```bash
open_xserver
```
- Run x-launch with config+file. If config_file does not exist, a pane will popups.
```bash
open_xserver config_file
```
- Run pulseaudio. Click any keys to return.
```bash
open_pulseaudio
```
- Kill x-server process from cmd
```bash
kill_xserver
```
- Kill pulseaudio from cmd
```bash
kill_pulseaudio
```
- Check if x-server or puslseaudio is running
```bash
check_xserver
```
```bash
check_pulseaudio
```


### V. Last but not least, the powerful tmux.
I prefer [OhMyTmux](github.com/gpakosz/.tmux) from: github.com/gpakosz/.tmux


## --------------------------------------
## You should check the file set_up.sh for detailed explaination.
## I hope you enjoy it,
## I will update more in future.
