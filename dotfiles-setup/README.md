# dotfiles-setup.sh

## 🚀 Dotfiles and Aliases Setup Script

This Bash script provides a local, standalone mechanism for setting up dotfiles and aliases for a user, mirroring the linking logic defined in an Ansible role.

The script creates symbolic links (`ln -sf`) for common configuration files and alias files, while offering optional command-line arguments to include extra, user-specific configurations.

## 📋 Requirements

* **Bash:** The script requires a standard UNIX-like environment with Bash.
* **Source Directory:** The dotfiles source repository **must** already exist at: `~/.dotfiles`

## 🔧 Usage

### 1. Make the Script Executable

```bash
chmod +x dotfiles-setup.sh
```

### 2. Run the Script
The script runs on the current user's home directory ($HOME). Use flags to deploy extra configurations.

```bash
Configuration Flags (Arguments)
-f, --files: <file1,file2,...>

Description: Comma-separated list of extra dotfiles to link from ~/.dotfiles/ to $HOME/.
-a, --aliases: <alias1,alias2,...>

Description: Comma-separated list of extra alias files to link from ~/.dotfiles/.aliases/ to ~/.aliases/.
-h, --help: Displays the usage information.
```

💡 Examples

A. Basic Setup (Common Files Only) 
- Deploys the default list of dotfiles and aliases.

```bash
./dotfiles-setup.sh
```
B. Setup with Extra Aliases
- Deploys common files plus two extra alias files: docker_aliases and pyenv_aliases. (Files must exist inside ~/.dotfiles/.aliases/).

```bash
./dotfiles-setup.sh --aliases docker_aliases,pyenv_aliases
```

C. Full Custom Setup (Files and Aliases)
- Deploys common files, the extra aliases, and extra dotfiles, including a nested configuration file.

```bash
./dotfiles-setup.sh \
    --files .zshrc,.config/nvim/init.vim \
    --aliases docker_aliases,node_aliases
```

## Configuration Mapping
The script ensures that the following common files, are linked:

### Common Dotfiles
```bash
.bashrc
.bash_profile
.gitconfig
.gitconfig-personal
.gitconfig-rit
.tmux.conf
.vimrc
```

### Common Aliases
```bash
bash_aliases_user
bash_aliases_misc
```