#
# Ansible managed
#

#  ---------------------------------------------------------------------------
#
#  Description:  This file holds all my BASH configurations and aliases
#
#  Sections:
#  1.   Environment Configuration
#  2.   Make Terminal Better (remapping defaults and adding functionality)
#  3.   File and Folder Management
#  4.   Searching
#  5.   Process Management
#  6.   Networking
#  7.   System Operations & Information
#  8.   Reminders & Notes
#  9.   Work based Aliases
#  10.  User Defined Aliases
#  
#  ---------------------------------------------------------------------------

#   1.  ENVIRONMENT CONFIGURATION

#   Change Prompt
#   ------------------------------------------------------------
USER=`id -u -n`
if [ "$PS1" ]; then
        set history=1500
        stty erase ^?
        unset autologout
        set colorcat
        set autolist
        if [ $USER = "root" ]; then
	export PS1="\[\e[1;31m\]\h\[\e[0;32m\]{\u}\[\e[m\]\! \w: "

        else
	export PS1="\[\e[1;33m\]\h\[\e[0;32m\]{\u}\[\e[m\]\! \w: "

	fi


        export PS2="| => "
fi       

if [[ ${XDG_SESSION_TYPE} != "tty" ]]; then
   export SSH_AUTH_SOCK=~/ssh.auth
fi

HISTSIZE=1000
HISTFILESIZE=2000


#   Set Paths
#   ------------------------------------------------------------
    export PATH="/home/${USER}/.local/bin:/opt/java/bin:/opt/java/lib:/bin:/usr/bin:/sbin:/usr/sbin:/usr/lib:/usr/local/bin:/usr/local/sbin"
    export PATH="$PATH:/usr/local/share:/opt/kde3/bin:/home/${USER}/bin:/home/${USER}/todo/bin:/opt/SublimeText:/usr/games"


#   Set Default Editor (change 'Nano' to the editor of your choice)
#   ------------------------------------------------------------
    export EDITOR=/usr/bin/vim
#   source the bash completion script: /etc/bash_completion for more functionality
    if [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi

#   2.  MAKE TERMINAL BETTER

        case "$TERM" in
            xterm-color) color_prompt=yes;;
        esac

        #
        if [ -x /usr/bin/dircolors ]; then
            test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
            alias ls='ls --color=auto'

            alias grep='grep --color=auto'
            alias fgrep='fgrep --color=auto'
            alias egrep='egrep --color=auto'
        fi



alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias rm='rm -iv'                           # Preferred 'rm' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias l='ls -Flhp'                          # Preferred 'ls' implementation
alias ll='ls -Flhp'                         # Preferred 'ls' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels
alias st='/opt/SublimeText/sublime_text'   # Sublime Text
alias edit='sublime_text '                  # edit:         Opens any file in sublime editor
alias ~="cd ~"                              # ~:            Go Home
alias c='clear'                             # c:            Clear terminal display
alias show_options='shopt'                  # Show_options: display bash options settings
alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
alias pss='ps -ef | grep -v grep | grep --color=auto '
alias ns='nslookup '
alias top='/usr/bin/htop'
alias dirsize='du -hs * .[^.]* | sort -hr'
alias dirsizen='du -hs * .[^.]* | sort -h'
alias disk='lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT,LABEL'
alias disks='lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT,LABEL'
alias xscreensaver='xscreensaver -no-splash -log /var/tmp/xscreensaver.log'
alias go='~/.screenlayout/screenlayout.sh'
alias dvl='cd ~/dvl'
alias myansible='cd ~/dvl/Ansible'
alias boxes-novc='cd ~/dvl/Personal/Packer/packer-boxes-novc'
alias boxes='cd ~/dvl/Personal/Packer/packer-boxes'
alias rit='cd ~/dvl/RIT'
alias ritansible='cd ~/dvl/RIT/Ansible'
alias serverauto='cd ~/dvl/RIT/Ansible/ServerAutomation'
alias ritrhel='cd ~/dvl/RIT/Packer/RHEL'
alias ritubuntu='cd ~/dvl/RIT/Packer/Ubuntu'

#   lr:  Full Recursive Directory Listing
#   ------------------------------------------
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

#   mans:   Search manpage given in agument '1' for term given in argument '2' (case insensitive)
#           displays paginated result with colored search terms and two lines surrounding each hit.             Example: mans mplayer codec
#   --------------------------------------------------------------------
    mans () {
        man $1 | grep -iC2 --color=always $2 | less
    }

#   3.  FILE AND FOLDER MANAGEMENT

zipf () { zip -r "$1".zip "$1" ; }          # zipf:         To create a ZIP archive of a folder
alias numFiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir
alias make1mb='mkfile 1m ./1MB.dat'         # make1mb:      Creates a file of 1mb size (all zeros)
alias make5mb='mkfile 5m ./5MB.dat'         # make5mb:      Creates a file of 5mb size (all zeros)
alias make10mb='mkfile 10m ./10MB.dat'      # make10mb:     Creates a file of 10mb size (all zeros)
alias vi='/usr/bin/vim'			    # using vim instead of vi

#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
    extract () {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
             esac
         else
             echo "'$1' is not a valid file"
         fi
    }


#   4.  SEARCHING

alias qfind="find . -name "                 # qfind:    Quickly search for file
ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file under the current directory
ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file whose name starts with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file whose name ends with a given string

#   5.  PROCESS MANAGEMENT

#   findPid: find out the pid of a specified process
#   -----------------------------------------------------
#       Note that the command name can be specified via a regex
#       E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
#       Without the 'sudo' it will only find processes of the current user
#   -----------------------------------------------------
    findPid () { lsof -t -c "$@" ; }

#   memHogsTop, memHogsPs:  Find memory hogs
#   -----------------------------------------------------
    alias memHogsTop='top -l 1 -o rsize | head -20'
    alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'

#   cpuHogs:  Find CPU hogs
#   -----------------------------------------------------
    alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'

#   topForever:  Continual 'top' listing (every 10 seconds)
#   -----------------------------------------------------
    alias topForever='top -l 9999999 -s 10 -o cpu'

#   ttop:  Recommended 'top' invocation to minimize resources
#   ------------------------------------------------------------
#       Taken from this macosxhints article
#       http://www.macosxhints.com/article.php?story=20060816123853639
#   ------------------------------------------------------------
    alias ttop="top -R -F -s 10 -o rsize"

#   my_ps: List processes owned by my user:
#   ------------------------------------------------------------
    my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }


#   6.  NETWORKING

alias myip='dig +short myip.opendns.com @resolver1.opendns.com'	# myip:         Public facing IP Address
alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
alias lsock='sudo /usr/bin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo /usr/bin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/bin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias vnstat='vnstat -i eth0'
#
##fail2ban aliases
alias f2bstat='sudo fail2ban-client status '
alias f2bunban='sudo fail2ban-client set sshd unbanip '
alias f2b='route -n'

#   ii:  display useful host related informaton
#   -------------------------------------------------------------------
    ii() {
        echo -e "\nYou are logged on ${RED}$HOST"
        echo -e "\nAdditionnal information:$NC " ; uname -a
        echo -e "\n${RED}Users logged on:$NC " ; w -h
        echo -e "\n${RED}Current date :$NC " ; date
        echo -e "\n${RED}Machine stats :$NC " ; uptime
        #echo -e "\n${RED}Current network location :$NC " ; scselect
        echo -e "\n${RED}Public facing IP Address :$NC " ;myip
        #echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
        echo
    }


#   7.  SYSTEMS OPERATIONS & INFORMATION

# Delete a given line number in the known_hosts file.
knownrm() {
 re='^[0-9]+$'
 if ! [[ $1 =~ $re ]] ; then
   echo "error: line number missing" >&2;
 else
   sed -i '' "$1d" ~/.ssh/known_hosts
 fi
}

# Enter a running Docker container.
denter() {
 if [[ ! "$1" ]] ; then
     echo "You must supply a container ID or name."
     return 0
 fi

 docker exec -it $1 bash
 return 0
}

clusters() {
    if [ -f ~/.aliases/bash_aliases_tmux_cssh ]; then
        cat ~/.aliases/bash_aliases_tmux_cssh  | grep -v "#" | cut -d ' ' -f 1 --complement
    fi
}

alias tmattach='tmux attach -d -t '      # tmux attach ( detatches existing sessions first )
alias tmcreate='tmux new -s '            # tmux create new session
alias tmlist='tmux ls'                   # tmux list all sessions
alias tmnw='tmux new-window -d -n '      # create a new window inside a session
#
if [ -f .tmux.startup ]; then
   ~/.tmux.startup
fi


# Include alias file (if present) containing aliases for ssh, etc.
if [ -d "$HOME/.aliases/" ]; then
    for file in $HOME/.aliases/bash_aliases_*; do
        . "$file"
    done
fi

#   8.  REMINDERS & NOTES
