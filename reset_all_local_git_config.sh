#!/bin/bash

# Default base directory is ~/Git unless specified
BASE_DIR="${1:-$HOME/Git}"

echo "⚠️  This will remove all local Git configuration files (.git/config)"
echo "📂 Target base directory: $BASE_DIR"
read -p "Are you sure you want to continue? (y/n): " confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo "❌ Aborted."
  exit 1
fi

find "$BASE_DIR" -type d -name ".git" | while read -r gitdir; do
  config_file="$gitdir/config"
  if [ -f "$config_file" ]; then
    echo "🧹 Resetting local config in: $(dirname "$gitdir")"
    rm -f "$config_file"
    # Recreate a minimal config to keep Git functional
    cat <<EOF > "$config_file"
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
EOF
  fi
done

echo ""
echo "✅ All local Git configs under $BASE_DIR have been reset."
