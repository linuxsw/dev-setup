#!/bin/bash

echo "⚠️  WARNING: This will reset all global Git configuration and remove templates/hooks."
read -p "Are you sure you want to continue? (y/n): " confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo "❌ Aborted."
  exit 1
fi

# Remove global Git config
GIT_CONFIG_FILE="$HOME/.gitconfig"
if [ -f "$GIT_CONFIG_FILE" ]; then
  echo "🧹 Removing $GIT_CONFIG_FILE ..."
  rm "$GIT_CONFIG_FILE"
else
  echo "ℹ️  No global .gitconfig file found."
fi

# Remove Git credentials store file
GIT_CREDENTIAL_FILE="$HOME/.git-credentials"
if [ -f "$GIT_CREDENTIAL_FILE" ]; then
  echo "🧹 Removing saved Git credentials ($GIT_CREDENTIAL_FILE) ..."
  rm "$GIT_CREDENTIAL_FILE"
else
  echo "ℹ️  No stored Git credentials found."
fi

# Remove global excludes file (if set)
if git config --global core.excludesFile &>/dev/null; then
  IGNORE_FILE=$(git config --global core.excludesFile)
  echo "🧹 Removing global gitignore file ($IGNORE_FILE) ..."
  rm -f "$IGNORE_FILE"
fi

# Remove template directory
TEMPLATE_DIR="$HOME/.git-templates"
if [ -d "$TEMPLATE_DIR" ]; then
  echo "🧹 Removing Git template directory ($TEMPLATE_DIR) ..."
  rm -rf "$TEMPLATE_DIR"
fi

# Unset Git-related environment variables
unset GIT_AUTHOR_NAME
unset GIT_AUTHOR_EMAIL
unset GIT_COMMITTER_NAME
unset GIT_COMMITTER_EMAIL

echo "✅ All global Git settings and templates have been reset."
