## My Personal Dotfiles

* **.aliases/bash_aliases_rit** - file I store work related bash aliases
* **.aliases/bash_aliases_user** - file I store personal bash aliases
* **.aliases/bash_aliases_user_macos** - file I store personal bash aliases for my macbook
* **.bashrc - my bashrc** - common config shared by every machine; sources ~/.bashrc-machine at the end
* **bashrc.d/default.sh** - machine-specific config for my main linux machines
* **bashrc.d/wsl.sh** - machine-specific config for WSL
* **bashrc.d/macbook.sh** - machine-specific config for my macbook
* **.gitconfig** - main gitconfig which uses the subsequent gitconfigs for personal/wo**rk related settings
* **.gitconfig-personal** - sets the default user/email for personal content
* **.gitconfig-rit** - sets the default user/email for work related content
* **.vimrc**

Run `./check.sh` to syntax-check every bash file in the repo (can also be linked as a git pre-commit hook — see the comments in the script).

See [dotfiles-setup/README.md](dotfiles-setup/README.md) for the setup script. Everyone gets the same ~/.bashrc; the `-m/--machine` option (default, wsl, or macbook — auto-detected if omitted) controls which bashrc.d overlay gets linked as ~/.bashrc-machine.
