#!/bin/bash
#
# dotfiles-remove.sh
#
# Reverses dotfiles-setup.sh: removes every symlink in $HOME (and its
# subdirectories, e.g. ~/.aliases) that points into ~/.dotfiles, restoring
# any *.bak file that setup created when it backed up a pre-existing file.
#
# This is the "undo" step for cases like: I need to delete ~/.dotfiles,
# pull a fresh clone from GitLab, and re-run dotfiles-setup.sh. Run this
# first so the old symlinks (and stale backups) don't get left behind or
# conflict with the fresh setup.
#
# Usage:
#   ./dotfiles-remove.sh            # unlink everything, leave ~/.dotfiles in place
#   ./dotfiles-remove.sh --purge    # also delete ~/.dotfiles itself (asks for confirmation)
#   ./dotfiles-remove.sh --purge -y # same, but skip the confirmation prompt

USER_HOME="${HOME}"
DOTFILES_DIR="${USER_HOME}/.dotfiles"
ALIASES_DIR="${USER_HOME}/.aliases"

PURGE=0
ASSUME_YES=0

usage() {
  echo "Usage: $0 [--purge] [-y|--yes]"
  echo ""
  echo "Removes every symlink under \$HOME that points into ${DOTFILES_DIR},"
  echo "restoring any *.bak backup dotfiles-setup.sh created along the way."
  echo ""
  echo "OPTIONS:"
  echo "  --purge      Also delete ${DOTFILES_DIR} itself once all links are removed."
  echo "  -y, --yes    Don't prompt for confirmation before deleting ${DOTFILES_DIR}."
  echo "  -h, --help   Display this help message."
  exit 0
}

while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --purge)
      PURGE=1
      shift
      ;;
    -y|--yes)
      ASSUME_YES=1
      shift
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

if [ ! -d "${DOTFILES_DIR}" ]; then
  echo "!!! ${DOTFILES_DIR} does not exist, nothing to unlink."
  exit 0
fi

# Resolve to a real path so symlink target comparisons aren't fooled by
# trailing slashes or a symlinked $HOME.
DOTFILES_REAL="$(cd "${DOTFILES_DIR}" && pwd -P)"

echo "=========================================="
echo " Tearing down dotfiles symlinks "
echo "=========================================="
echo "Home:     ${USER_HOME}"
echo "Dotfiles: ${DOTFILES_DIR}"
echo "------------------------------------------"

removed=0

# Walk $HOME for symlinks pointing into ~/.dotfiles. -xdev keeps this on one
# filesystem, and skipping .dotfiles/.git avoids descending into the repo
# itself (it holds no symlinks back to itself, but there's no reason to scan it).
while IFS= read -r -d '' link; do
  target="$(readlink -f "${link}")"

  case "${target}" in
    "${DOTFILES_REAL}"|"${DOTFILES_REAL}"/*)
      echo "    Unlinking: ${link} -> ${target}"
      rm -f "${link}"

      backup="${link}.bak"
      if [ -e "${backup}" ]; then
        echo "    Restoring backup: ${backup} -> ${link}"
        mv "${backup}" "${link}"
      fi

      removed=$((removed + 1))
      ;;
  esac
done < <(find "${USER_HOME}" -xdev -path "${DOTFILES_DIR}" -prune -o -type l -print0 2>/dev/null)

echo "------------------------------------------"
echo "Removed ${removed} symlink(s)."

# Clean up ~/.aliases if setup created it and teardown emptied it out.
if [ -d "${ALIASES_DIR}" ] && [ -z "$(ls -A "${ALIASES_DIR}")" ]; then
  echo ">>> ${ALIASES_DIR} is now empty, removing it."
  rmdir "${ALIASES_DIR}"
fi

if [ "${PURGE}" -eq 1 ]; then
  echo "------------------------------------------"
  if [ "${ASSUME_YES}" -ne 1 ]; then
    read -r -p ">>> Delete ${DOTFILES_DIR} now? [y/N] " reply
    case "${reply}" in
      [yY]|[yY][eE][sS]) ;;
      *)
        echo ">>> Skipping deletion of ${DOTFILES_DIR}."
        exit 0
        ;;
    esac
  fi
  echo ">>> Removing ${DOTFILES_DIR}..."
  rm -rf "${DOTFILES_DIR}"
  echo ">>> Done. Re-clone the repo to ${DOTFILES_DIR} and re-run dotfiles-setup.sh when ready."
else
  echo ""
  echo "All dotfiles symlinks removed. ${DOTFILES_DIR} was left in place."
  echo "Run with --purge to also delete it, or remove/re-clone it yourself, then re-run dotfiles-setup.sh."
fi

echo "=========================================="
echo " Teardown complete "
echo "=========================================="
