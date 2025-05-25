#!/bin/bash

BASE_DIR="${1:-$HOME/Git}"
IDENTITY_SCRIPT="$HOME/setup_git_commit_identity.sh"

if [ ! -f "$IDENTITY_SCRIPT" ]; then
  echo "❌ setup_git_commit_identity.sh not found at $IDENTITY_SCRIPT"
  exit 1
fi

find "$BASE_DIR" -type d -name ".git" | while read -r gitdir; do
  REPO_DIR="$(dirname "$gitdir")"
  echo "⚙️  Applying Git identity setup to: $REPO_DIR"
  (cd "$REPO_DIR" && bash "$IDENTITY_SCRIPT")
done

echo "✅ All repos under $BASE_DIR have been updated."
