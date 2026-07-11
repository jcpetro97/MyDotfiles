#
# Machine-specific bashrc: macbook (macOS / BSD userland)
# Sourced by ~/.bashrc via the ~/.bashrc-machine symlink.
# Anything here overrides the common ~/.bashrc, since it is sourced after it.
#

# silence "The default interactive shell is now zsh" warning
export BASH_SILENCE_DEPRECATION_WARNING=1
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

#   Set Paths
#   ------------------------------------------------------------
    export USER="jxpsys"
    export PATH="/usr/local/bin/:$PATH"
    export PATH="/usr/local/git/bin:/usr/local/opt/krb5/bin:/sw/bin/:/usr/local/:/usr/local/sbin:/usr/local/mysql/bin:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
    export PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:/Library/Frameworks/Python.framework/Versions/2.7/sbin:/Users/jxpsys/bin:$PATH"
    export PATH="~/Library/Python/3.9/bin:$PATH"
    export PATH="/usr/local/opt/krb5/bin:$PATH"
    export PATH="/usr/local/opt/krb5/sbin:$PATH"

#   Set default blocksize for ls, df, du
#   from this: http://hints.macworld.com/comment.php?mode=view&cid=24491
#   ------------------------------------------------------------
    export BLOCKSIZE=1k

#   colorize ls and grep (BSD ls has no --color / dircolors)
#   ------------------------------------------------------------
    alias ls='ls -G '
    alias l='ls -G '
    alias ll='ls -FGlAhp'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

#   macOS terminal helpers
#   ------------------------------------------------------------
alias edit='subl'                           # edit:         Opens any file in sublime editor
alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
alias which='type -all'                     # which:        Find executables
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive
mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview
alias DT='tee ~/Desktop/terminalOut.txt'    # DT:           Pipe content to file on MacOS Desktop
alias dirsize='du -s * .[^.]* | sort -rn | cut -f2 | tr "\n" "\0" | xargs -0 -I {} du -sh "{}"'
alias dirsizer='sudo du -s * .[^.]* | sort -rn | cut -f2 | tr "\n" "\0" | xargs -0 -I {} du -sh "{}"'
alias dirsizen='sudo du -s * .[^.]* | sort -n | cut -f2 | tr "\n" "\0" | xargs -0 -I {} du -sh "{}"'
alias glog="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'"

#   showa: to remind yourself of an alias (given some part of it)
#   ------------------------------------------------------------
    showa () { /usr/bin/grep --color=always -i -a1 $@ ~/Library/init/bash/aliases.bash | grep -v '^\s*$' | less -FSRXc ; }

#   cdf:  'Cd's to frontmost window of MacOS Finder
#   ------------------------------------------------------
    cdf () {
        currFolderPath=$( /usr/bin/osascript <<"    EOT"
            tell application "Finder"
                try
            set currFolder to (folder of the front window as alias)
                on error
            set currFolder to (path to desktop folder as alias)
                end try
                POSIX path of currFolder
            end tell
    EOT
        )
        echo "cd to \"$currFolderPath\""
        cd "$currFolderPath"
    }

#   spotlight: Search for a file using MacOS Spotlight's metadata
#   -----------------------------------------------------------
    spotlight () { mdfind "kMDItemDisplayName == '$@'wc"; }

#   Networking (BSD lsof lives in /usr/sbin; macOS-only tools)
#   ------------------------------------------------------------
alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs

#   ii:  display useful host related informaton (macOS version, uses scselect)
#   -------------------------------------------------------------------
    ii() {
        echo -e "\nYou are logged on ${RED}$HOST"
        echo -e "\nAdditionnal information:$NC " ; uname -a
        echo -e "\n${RED}Users logged on:$NC " ; w -h
        echo -e "\n${RED}Current date :$NC " ; date
        echo -e "\n${RED}Machine stats :$NC " ; uptime
        echo -e "\n${RED}Current network location :$NC " ; scselect
        echo -e "\n${RED}Public facing IP Address :$NC " ;myip
        #echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
        echo
    }

#   clusters: BSD cut has no --complement, so use the macOS variant
#   -------------------------------------------------------------------
clusters() {
    if [ -f ~/.aliases/bash_aliases_tmux_cssh ]; then
        cat ~/.aliases/bash_aliases_tmux_cssh  | grep -v "#" | grep "alias " | cut -c 7-
    fi
}

#   macOS system operations
#   -------------------------------------------------------------------
alias mountReadWrite='/sbin/mount -uw /'    # mountReadWrite:   For use when booted into single-user

#   cleanupDS:  Recursively delete .DS_Store files
    alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"

#   finderShowHidden:   Show hidden files in Finder
#   finderHideHidden:   Hide hidden files in Finder
    alias finderShowHidden='defaults write com.apple.finder ShowAllFiles TRUE'
    alias finderHideHidden='defaults write com.apple.finder ShowAllFiles FALSE'
    alias smerge='/Applications/Sublime Merge.app/Contents/MacOS/sublime_merge'

#   cleanupLS:  Clean up LaunchServices to remove duplicates in the "Open With" menu
    alias cleanupLS="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

#    screensaverDesktop: Run a screensaver on the Desktop
    alias screensaverDesktop='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'

#   todo.txt
#   ---------------------------------------
export TODOTXT_CFG_FILE="/Users/${USER}/Dropbox/todotxt/todo.cfg"
export TODOTXT_DEFAULT_ACTION=ls
export TODO_FILE="/Users/${USER}/Dropbox/todotxt/todo.txt"
export DONE_FILE="/Users/${USER}/Dropbox/todotxt/done.txt"
export REPORT_FILE="/Users/${USER}/Dropbox/todotxt/report.txt"
alias todo='/Users/${USER}/todo/bin/todo.sh '

#   httpDebug:  Download a web page and show info on what took time
#   -------------------------------------------------------------------
    httpDebug () { /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; }

#   perl5 (local::lib)
#   -------------------------------------------------------------------
PATH="/Users/jxpsys/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/jxpsys/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/jxpsys/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/jxpsys/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/jxpsys/perl5"; export PERL_MM_OPT;

#   ssh agent
#   -------------------------------------------------------------------
export DISPLAY="ssh-askpass"
export SSH_AUTH_SOCK=~/ssh.auth

#   REMINDERS & NOTES
#   ---------------------------------------
#   remove_disk: spin down unneeded disk
#   diskutil eject /dev/disk1s3
#
#   to change the password on an encrypted disk image:
#   hdiutil chpass /path/to/the/diskimage
#
#   to mount a read-only disk image as read-write:
#   hdiutil attach example.dmg -shadow /tmp/example.shadow -noverify
#
#   mounting a removable drive (of type msdos or hfs)
#   mkdir /Volumes/Foo
#   ls /dev/disk*   to find out the device to use in the mount command)
#   mount -t msdos /dev/disk1s1 /Volumes/Foo
#   mount -t hfs /dev/disk1s1 /Volumes/Foo
#
#   to create a file of a given size: /usr/sbin/mkfile or /usr/bin/hdiutil
#   e.g.: mkfile 10m 10MB.dat
#   e.g.: hdiutil create -size 10m 10MB.dmg
#   the above create files that are almost all zeros - if random bytes are desired
#   then use: ~/Dev/Perl/randBytes 1048576 > 10MB.dat
