#
# Machine-specific bashrc: default (Linux desktop/server)
# Sourced by ~/.bashrc via the ~/.bashrc-machine symlink.
#

# Forward the ssh agent socket for graphical sessions
# (some distros, e.g. RHEL 8, leave XDG_SESSION_TYPE unset/blank for
# non-graphical logins instead of setting it to "tty")
if [[ -n ${XDG_SESSION_TYPE} && ${XDG_SESSION_TYPE} != "tty" ]]; then
   export SSH_AUTH_SOCK=~/ssh.auth
fi

alias vnstat='vnstat -i eth0'

# Packer checkouts (only exist on this machine)
alias boxes-novc='cd ~/dvl/Personal/Packer/packer-boxes-novc'
alias boxes='cd ~/dvl/Personal/Packer/packer-boxes'
alias ritrhel='cd ~/dvl/RIT/Packer/RHEL'
alias ritubuntu='cd ~/dvl/RIT/Packer/Ubuntu'
