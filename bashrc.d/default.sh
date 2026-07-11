#
# Machine-specific bashrc: default (Linux desktop/server)
# Sourced by ~/.bashrc via the ~/.bashrc-machine symlink.
#

# Forward the ssh agent socket for graphical sessions
if [[ ${XDG_SESSION_TYPE} != "tty" ]]; then
   export SSH_AUTH_SOCK=~/ssh.auth
fi

alias vnstat='vnstat -i eth0'

# Packer checkouts (only exist on this machine)
alias boxes-novc='cd ~/dvl/Personal/Packer/packer-boxes-novc'
alias boxes='cd ~/dvl/Personal/Packer/packer-boxes'
alias ritrhel='cd ~/dvl/RIT/Packer/RHEL'
alias ritubuntu='cd ~/dvl/RIT/Packer/Ubuntu'
