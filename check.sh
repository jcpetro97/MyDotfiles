#!/bin/bash
#
# check.sh - syntax-check every bash file in this repo with `bash -n`.
#
# Run manually before committing, or wire it up as a git pre-commit hook:
#   ln -sf ../../check.sh .git/hooks/pre-commit
#
# This exists because .bashrc-macbook once carried an unnoticed heredoc
# syntax error for years; `bash -n` catches that class of mistake.

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

FILES=(
  "${REPO_DIR}/.bashrc"
  "${REPO_DIR}/.bash_profile"
  "${REPO_DIR}"/bashrc.d/*.sh
  "${REPO_DIR}"/.aliases/bash_aliases_*
  "${REPO_DIR}/dotfiles-setup/dotfiles-setup.sh"
  "${REPO_DIR}/dotfiles-setup/dotfiles-remove.sh"
)

rc=0
for file in "${FILES[@]}"; do
  if [ ! -f "${file}" ]; then
    echo "!!! WARNING: expected file not found: ${file}"
    continue
  fi
  if bash -n "${file}" 2>&1; then
    echo "OK: ${file#"${REPO_DIR}"/}"
  else
    echo "FAIL: ${file#"${REPO_DIR}"/}"
    rc=1
  fi
done

if [ ${rc} -ne 0 ]; then
  echo ""
  echo "!!! Syntax errors found. Fix them before committing."
fi
exit ${rc}
