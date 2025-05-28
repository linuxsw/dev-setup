#!/bin/bash

# === Your identities ===
GITHUB_NAME="Your Name"
GITHUB_EMAIL="your.email@example.com"

CORP_NAME="Your Name"
CORP_EMAIL="your.corporate@example.com"

# === Paths for templates ===
mkdir -p "$HOME/.git-templates/dynamic"
GITHUB_TEMPLATE="$HOME/.git-templates/dynamic/github-commit-template"
CORP_TEMPLATE="$HOME/.git-templates/dynamic/corp-commit-template"

# === Create templates ===
echo "Signed-off-by: $GITHUB_NAME <$GITHUB_EMAIL>" > "$GITHUB_TEMPLATE"
echo "Signed-off-by: $CORP_NAME <$CORP_EMAIL>" > "$CORP_TEMPLATE"

# === Check current repo ===
REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)
if [ -z "$REPO_ROOT" ]; then
  echo "❌ Not inside a Git repository. Aborting."
  exit 1
fi

cd "$REPO_ROOT" || exit 1
REMOTE=$(git remote get-url origin 2>/dev/null)

# === Apply settings based on remote ===
if [[ "$REMOTE" == *"github.com"* ]]; then
  git config user.name "$GITHUB_NAME"
  git config user.email "$GITHUB_EMAIL"
  git config commit.template "$GITHUB_TEMPLATE"
  SIGNATURE_EMAIL="$GITHUB_EMAIL"
elif [[ "$REMOTE" == *"git.yourcompany.com"* ]]; then
  git config user.name "$CORP_NAME"
  git config user.email "$CORP_EMAIL"
  git config commit.template "$CORP_TEMPLATE"
  SIGNATURE_EMAIL="$CORP_EMAIL"
else
  git config user.name "$GITHUB_NAME"
  git config user.email "$GITHUB_EMAIL"
  git config commit.template "$GITHUB_TEMPLATE"
  SIGNATURE_EMAIL="$GITHUB_EMAIL"
fi

# === Install dynamic prepare-commit-msg hook ===
HOOK_FILE=".git/hooks/prepare-commit-msg"
cat <<EOF > "$HOOK_FILE"
#!/bin/sh
REMOTE=\$(git config --get remote.origin.url)
if echo "\$REMOTE" | grep -q "github.com"; then
  SIGNATURE="Signed-off-by: $GITHUB_NAME <$GITHUB_EMAIL>"
elif echo "\$REMOTE" | grep -q "git.yourcompany.com"; then
  SIGNATURE="Signed-off-by: $CORP_NAME <$CORP_EMAIL>"
else
  SIGNATURE="Signed-off-by: $GITHUB_NAME <$GITHUB_EMAIL>"
fi
if [[ "\$2" != "merge" && "\$2" != "squash" ]] && ! grep -qF "\$SIGNATURE" "\$1"; then
  echo "" >> "\$1"
  echo "\$SIGNATURE" >> "\$1"
fi
EOF

chmod +x "$HOOK_FILE"

echo "✅ Git identity and sign-off hook applied to repo: $REPO_ROOT"
