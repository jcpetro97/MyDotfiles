#
# Machine-specific bashrc: WSL
# Sourced by ~/.bashrc via the ~/.bashrc-machine symlink.
#
# Bridge WSL SSH to Windows Pageant
export SSH_AUTH_SOCK="$HOME/.ssh/agent.sock"
if ! ss -a | grep -q "$SSH_AUTH_SOCK"; then
  rm -f "$SSH_AUTH_SOCK"
  wsl2_ssh_pageant_bin="$HOME/.ssh/wsl2-ssh-pageant.exe"
  if [ -x "$wsl2_ssh_pageant_bin" ]; then
    # Launch the bridge silently in the background
    setsid nohup socat UNIX-LISTEN:"$SSH_AUTH_SOCK",fork EXEC:"$wsl2_ssh_pageant_bin",nofork >/dev/null 2>&1 &
  fi
fi

# NoMachine server helpers
alias nxstatus='sudo systemctl status nxserver'
alias nxrestart='sudo systemctl restart nxserver'
