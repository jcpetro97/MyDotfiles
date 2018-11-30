* bashrc
copy .bashrc to home directory

* conkyrc

** Create a conky directory
** place config file in directory
** make changes to file for monitoring network ports, and mounted filesystems
** execute the folling command to start:

conky -c ~/<homedir>/conky/conkrc

* terminator
Config file goes in the following directory:

<homedir>/.config/terminator
ex. /home/jxpsys/.config/terminator/config

* tmux
Copy .tmux.conf  to home directory


You can also copy the .tmux.startup, and configure that file, if you have certain apps you want started up when you log in. just make sure that you execute that script ( ie. ~/.tmux.startup ) **note** tmux.startup is set to execute in the .bashrc currently.

This all assumes that tmux has been installed on the system.

* screenlayout.sh
This is used to configure my screen layout on my current workstation, since the OS seems to see my display card as one device, even though it has 2 ports.

To install this:

1. mkdir <homedir>/.screenlayout
2. cp screenlayout.sh to <homedir>/.screenlayout
3. put the "screenlayout.sh" into the autostart for xfce

* multitail
cp .multitail.conf to homedir


