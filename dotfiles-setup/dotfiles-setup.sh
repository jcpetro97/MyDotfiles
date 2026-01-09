#!/bin/bash

# --- Configuration Variables (from main.yml, used for linking) ---

DOTFILES_FILES_COMMON=(
  .bashrc
  .bash_profile
  .gitconfig
  .gitconfig-personal
  .gitconfig-rit
  .tmux.conf
  .vimrc
)

DOTFILES_ALIASES_COMMON=(
  bash_aliases_user
  bash_aliases_misc
)

# Initialize extra arrays - these will be populated by command-line arguments
DOTFILES_FILES_EXTRA=()
DOTFILES_ALIASES_EXTRA=()

# --- User/Path Variables ---
CURRENT_USER=$(whoami)
USER_HOME="${HOME}"
DOTFILES_DIR="${USER_HOME}/.dotfiles"
ALIASES_DIR="${USER_HOME}/.aliases"

# --- Functions ---

# Function to display usage instructions
usage() {
  echo "Usage: $0 [OPTIONS]"
  echo "Sets up dotfiles and aliases by creating symbolic links from ~/.dotfiles."
  echo ""
  echo "OPTIONS:"
  echo "  -f, --files <file1,file2,...>  Comma-separated list of extra dotfiles (e.g., .zshrc, .config/nvim/init.vim)"
  echo "  -a, --aliases <alias1,alias2,...> Comma-separated list of extra alias files (e.g., git_aliases, docker_aliases)"
  echo "  -h, --help                     Display this help message"
  exit 0
}

# Function to ensure .aliases directory exists
ensure_aliases_dir() {
  echo ">>> Ensuring ${ALIASES_DIR} directory exists..."
  mkdir -p "${ALIASES_DIR}"
  chmod 755 "${ALIASES_DIR}"
  if [ $? -ne 0 ]; then
    echo "!!! ERROR: Failed to create aliases directory. Aborting."
    exit 1
  fi
  echo "    Aliases directory is ready."
}

# Function to create symbolic links
create_symlinks() {
  local source_base="$1"
  local target_base="$2"
  
  shift 2 
  
  # Now, "$@" only contains the file names
  for file in "$@"; do
    # Remove leading/trailing whitespace if any
    file=$(echo "$file" | tr -d '[:space:]')

    local SRC_PATH="${source_base}/${file}"
    local DEST_PATH="${target_base}/${file}"
    
    echo "    Linking: ${file}"
    
    if [ ! -e "${SRC_PATH}" ]; then
      echo "!!! WARNING: Source file not found: ${SRC_PATH}. Skipping link."
      continue
    fi

    # Create parent directory for the destination if it's a subdirectory
    if [[ "$DEST_PATH" == */* ]]; then
        mkdir -p "$(dirname "$DEST_PATH")"
    fi

    # ln -sf: creates a symbolic link, force overwrite (s: symbolic, f: force)
    ln -sf "${SRC_PATH}" "${DEST_PATH}"
    
    if [ $? -ne 0 ]; then
      echo "!!! ERROR: Failed to create link for ${file}. Continuing..."
    fi
  done
}

# --- Argument Parsing ---

while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -f|--files)
            (
              IFS=',' read -r -a DOTFILES_FILES_EXTRA <<< "$2"
            )
            shift 2
            ;;
        -a|--aliases)
            (
              IFS=',' read -r -a DOTFILES_ALIASES_EXTRA <<< "$2"
            )
            shift 2
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo "Unknown parameter passed: $1"
            usage
            ;;
    esac
done

# --- Main Execution ---

echo "=========================================="
echo " Starting Dotfiles and Aliases Setup Script "
echo "=========================================="
echo "User: ${CURRENT_USER}"
echo "Home: ${USER_HOME}"
echo "------------------------------------------"

# Check for the existence of the dotfiles source directory
if [ ! -d "${DOTFILES_DIR}" ]; then
  echo "!!! FATAL ERROR: The required dotfiles directory was not found at ${DOTFILES_DIR}."
  echo "!!! Please ensure the repository is cloned/extracted to ${DOTFILES_DIR}."
  exit 1
fi

# 1. Ensure .aliases directory exists
ensure_aliases_dir

# 2. Link common aliases
echo ">>> Linking common aliases..."
create_symlinks \
  "${DOTFILES_DIR}/.aliases" \
  "${ALIASES_DIR}" \
  "${DOTFILES_ALIASES_COMMON[@]}"

# 3. Link extra aliases (if provided)
if [ ${#DOTFILES_ALIASES_EXTRA[@]} -gt 0 ]; then
  echo ">>> Linking extra aliases (from arguments)..."
  create_symlinks \
    "${DOTFILES_DIR}/.aliases" \
    "${ALIASES_DIR}" \
    "${DOTFILES_ALIASES_EXTRA[@]}"
else
  echo ">>> No extra aliases specified."
fi

# 4. Link common dotfiles
echo ">>> Linking common dotfiles..."
create_symlinks \
  "${DOTFILES_DIR}" \
  "${USER_HOME}" \
  "${DOTFILES_FILES_COMMON[@]}"

# 5. Link extra dotfiles (if provided)
if [ ${#DOTFILES_FILES_EXTRA[@]} -gt 0 ]; then
  echo ">>> Linking extra dotfiles (from arguments)..."
  create_symlinks \
    "${DOTFILES_DIR}" \
    "${USER_HOME}" \
    "${DOTFILES_FILES_EXTRA[@]}"
else
  echo ">>> No extra dotfiles specified."
fi

echo "=========================================="
echo " Dotfiles setup complete for ${CURRENT_USER}! "
echo "=========================================="