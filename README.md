# dev-setup

A collection of scripts and templates for setting up a Git development environment optimized for **VS Code** and **terminal-based Git workflows**.

This setup includes:

- Per-repository Git identity configuration based on the remote domain (e.g., `github.com`, `git.mycompany.com`)
- Auto-appended `Signed-off-by` lines in commit messages
- Support for both terminal (`git commit`) and VS Code GUI commits
- Optional batch configuration for all repositories in a base folder

---

## 🔧 Scripts Included

### `setup_git_commit_identity.sh`

This script should be run inside a Git repository. It does the following:

- Detects the remote URL (e.g., GitHub, your company’s GitLab)
- Sets `user.name` and `user.email` locally for that repo
- Sets a `commit.template` for VS Code GUI commit message pre-fill
- Installs a `prepare-commit-msg` hook that appends the appropriate `Signed-off-by` line dynamically

> **Note:** You should update this script with your own name and email addresses.

### `apply_git_identity_all_repos.sh`

Run this script once to apply the identity and commit hook setup across **all Git repositories under a base directory** (defaults to `~/Git`).

---

## 🛠 How to Use

1. Edit `setup_git_commit_identity.sh` to insert your name and email addresses.
2. Run the script inside a Git repo:
   ```bash
   ./setup_git_commit_identity.sh
   ```
3. To apply to all repos in a folder(~/Git is the default):
   ```bash
   ./apply_git_identity_all_repos.sh ~/Git
   ```

---

## 📦 .gitignore

This repository includes a `.gitignore` that excludes:

- macOS system files
- Node.js artifacts
- Python bytecode
- VS Code workspace config
- Shell history or temporary scripts

---

## 🧹 Optional Reset Scripts

### `reset_git_global_config.sh`

Use this to reset your **global Git configuration**, including `.gitconfig`, credential store, and templates.

```bash
./reset_git_global_config.sh
```

### `reset_all_local_git_config.sh`

Use this to remove and regenerate `.git/config` in every repo under a directory (like `~/Git`):

```bash
./reset_all_local_git_config.sh ~/Git
```

---

## 🧹 VS Code settings
