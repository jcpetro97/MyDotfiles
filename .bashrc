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
#  8.   todo.txt
#  9.   Reminders & Notes
#
#  ---------------------------------------------------------------------------

#   -------------------------------
#   1.  ENVIRONMENT CONFIGURATION
#   -------------------------------

#   Change Prompt
#   ------------------------------------------------------------
#USER="jxpsys"
USER=`id -u -n`
if [ "$PS1" ]; then
        set history=1500
        #stty erase ^H
        stty erase ^?
        ###3setterm -blength 0
        unset autologout
        set colorcat
        set autolist
        # original prompt
        ###export PS1="\h{\u}\! \w: "
        # uncomment if using for the root user
        #export PS1="\h\[\e[0;31m\]{\u}\[\e[m\]\! \w: "
        # comment out if using for the root user
        #export PS1="\h\[\e[0;32m\]{\u}\[\e[m\]\! \w: "
        if [ $USER = "root" ]; then
        # uncomment if using for the root user
	export PS1="\[\e[1;31m\]\h\[\e[0;32m\]{\u}\[\e[m\]\! \w: "

        else
        # comment out if using for the root user
	export PS1="\[\e[1;33m\]\h\[\e[0;32m\]{\u}\[\e[m\]\! \w: "

	fi


        export PS2="| => "
fi       

HISTSIZE=1000
HISTFILESIZE=2000


#   Set Paths
#   ------------------------------------------------------------
    export PATH="/opt/java/bin:/opt/java/lib:/bin:/usr/bin:/sbin:/usr/sbin:/usr/lib:/usr/local/bin:/usr/local/sbin"
    export PATH="$PATH:/usr/local/share:/opt/kde3/bin:/home/${USER}/bin:/home/${USER}/todo/bin:/opt/SublimeText:/usr/games"


#   Set Default Editor (change 'Nano' to the editor of your choice)
#   ------------------------------------------------------------
    export EDITOR=/usr/bin/vim
#   source the bash completion script: /etc/bash_completion for more functionality
    . /etc/bash_completion
#   -----------------------------
#   2.  MAKE TERMINAL BETTER
#   -----------------------------

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
alias evernote='/usr/share/nevernote/nevernote.sh'
alias nevernote='/usr/share/nevernote/nevernote.sh'
alias mtail='/home/${USER}/bin/mtail'
alias backintime='gksudo /usr/bin/backintime-kde4'
alias backintime-nox='/usr/bin/backintime'
alias oath='kinit -c /tmp/krb5cc_56827_OATH -f jxpsys@OATH.RIT.EDU ; export KRB5CCNAME=/tmp/krb5cc_56827_OATH'
alias scard='kinit -c /tmp/krb5cc_56827_SCARD -f jxpsys@SCARD.RIT.EDU ; export KRB5CCNAME=/tmp/krb5cc_56827_SCARD'
alias main='kinit -c /tmp/krb5cc_56827_MAIN -f jxpsys@MAIN.AD.RIT.EDU ; export KRB5CCNAME=/tmp/krb5cc_56827_MAIN'
alias kl='klist -c /tmp/krb5cc_56827 ; echo ; klist -c /tmp/krb5cc_56827_OATH ; echo ; klist -c /tmp/krb5cc_56827_SCARD ; echo ; klist -c /tmp/krb5cc_56827_MAIN'
alias krbenv='echo $KRB5CCNAME'
alias krboath='export KRB5CCNAME=/tmp/krb5cc_56827_OATH'
alias krbscard='export KRB5CCNAME=/tmp/krb5cc_56827_SCARD'
alias krbmain='export KRB5CCNAME=/tmp/krb5cc_56827_MAIN'
alias synergy='/usr/bin/synergys -f --config /etc/synergy.conf'
alias keepass='/usr/bin/mono /home/${USER}/bin/keepass2/KeePass.exe'
alias dirsize='du -hs * .[^.]* | sort -hr'
alias dirsizen='du -hs * .[^.]* | sort -h'
alias disk='lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT,LABEL'
alias disks='lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT,LABEL'
alias xscreensaver='xscreensaver -no-splash -log /var/tmp/xscreensaver.log'
alias go='~/.screenlayout/screenlayout.sh'
alias simpana='/usr/bin/javaws ~/bin/galaxy.jnlp'
#   lr:  Full Recursive Directory Listing
#   ------------------------------------------
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

#   mans:   Search manpage given in agument '1' for term given in argument '2' (case insensitive)
#           displays paginated result with colored search terms and two lines surrounding each hit.             Example: mans mplayer codec
#   --------------------------------------------------------------------
    mans () {
        man $1 | grep -iC2 --color=always $2 | less
    }

#   -------------------------------
#   3.  FILE AND FOLDER MANAGEMENT
#   -------------------------------

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


#   ---------------------------
#   4.  SEARCHING
#   ---------------------------

alias qfind="find . -name "                 # qfind:    Quickly search for file
ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file under the current directory
ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file whose name starts with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file whose name ends with a given string

#   ---------------------------
#   5.  PROCESS MANAGEMENT
#   ---------------------------

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


#   ---------------------------
#   6.  NETWORKING
#   ---------------------------

alias myip='curl ip.appspot.com'                    # myip:         Public facing IP Address
alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
alias lsock='sudo /usr/bin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo /usr/bin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/bin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias vnstat='vnstat -i eth0'
alias vnstatvm8='vnstat -i vmnet8'
#
##fail2ban aliases
alias f2bstat='sudo fail2ban-client status '
alias f2bsshub='sudo fail2ban-client set sshd unbanip '
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


#   ---------------------------------------
#   7.  SYSTEMS OPERATIONS & INFORMATION
#   ---------------------------------------
alias tmattach='tmux attach -d -t '
alias tmcreate='tmux new -s '
alias tmlist='tmux ls'
alias rhel1='ssh 0 -l john -p 2204'
alias rhel2='ssh 0 -l john -p 2205'
alias nxstatus='sudo systemctl status nxserver'
alias nxrestart='sudo systemctl restart nxserver'
alias push='git push origin master'
alias github='git push github master'
#   ---------------------------------------
#   8.  todo.txt
#   ---------------------------------------
export TODOTXT_CFG_FILE="/home/${USER}/Dropbox/todotxt/todo.cfg"
export TODO_FILE="/home/${USER}/Dropbox/todotxt/todo.txt"
export DONE_FILE="/home/${USER}/Dropbox/todotxt/done.txt"
export REPORT_FILE="/home/${USER}/Dropbox/todotxt/report.txt"
export TODOTXT_DEFAULT_ACTION=ls
alias todo='/home/${USER}/todo/bin/todo.sh '
#
####~/.tmux.startup
if [ -f .tmux.startup ]; then
   ~/.tmux.startup
fi


#   ---------------------------------------
#   9.  REMINDERS & NOTES
#   ---------------------------------------

