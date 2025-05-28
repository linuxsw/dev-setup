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
3. To apply to all repos in a folder (~/Git is the default):
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

## 🧩 VS Code: Extensions and Settings Backup

To replicate your VS Code setup (extensions and preferences) on a new machine, follow these steps:

### 📋 Export Installed Extensions

From your terminal, run:

```bash
code --list-extensions > vscode-extensions.txt
```

This will create a list of all your installed extensions.

### 📥 Restore Extensions on a New Machine

Once you transfer the `vscode-extensions.txt` file to your new machine:

```bash
xargs -n 1 code --install-extension < vscode-extensions.txt
```

> Ensure you have VS Code's command-line tool (`code`) installed and accessible in your system `PATH`.

### ⚙️ VS Code Settings

Use the following `settings.json` file to replicate your preferences. Save it in:

- **macOS**: `~/Library/Application Support/Code/User/settings.json`
- **Windows**: `%APPDATA%\Code\User\settings.json`

```json
{
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "editor.cursorBlinking": "expand",
  "editor.cursorSmoothCaretAnimation": "on",
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.formatOnPaste": true,
  "editor.formatOnSave": true,
  "editor.guides.bracketPairs": true,
  "emmet.includeLanguages": {
    "javascript": "javascriptreact"
  },
  "emmet.triggerExpansionOnTab": true,
  "git.autofetch": true,
  "git.enableCommitSigning": false,
  "git.enableSmartCommit": true,
  "git.postCommitCommand": "sync",
  "gitlab-mr.accessToken": "",
  "gitlab-mr.accessTokens": {
    "https://git.panasonic.aero/platform/": ""
  },
  "gitlab.showPipelineUpdateNotifications": true,
  "hediet.vscode-drawio.resizeImages": null,
  "highlight-matching-tag.styles": {
    "opening": {
      "left": {
        "custom": {
          "borderColor": "yellow",
          "borderRadius": "5px",
          "borderStyle": "solid",
          "borderWidth": "0 0 0 3px"
        }
      },
      "right": {
        "custom": {
          "borderColor": "yellow",
          "borderRadius": "5px",
          "borderStyle": "solid",
          "borderWidth": "0 3px 0 0"
        }
      }
    }
  },
  "javascript.updateImportsOnFileMove.enabled": "always",
  "json.schemas": [],
  "makefile.configureOnOpen": true,
  "markdown-preview-enhanced.previewTheme": "github-dark.css",
  "markdown.preview.fontFamily": "MesloLGS NF Regular",
  "markdown.preview.fontSize": 16,
  "prettier.jsxSingleQuote": true,
  "prettier.semi": false,
  "prettier.singleQuote": true,
  "redhat.telemetry.enabled": true,
  "remote.SSH.connectTimeout": 1800,
  "remote.SSH.remotePlatform": {
    "coder-vscode.us-west-2.coder-dev.nextcloud.aero--parks1--k3s-node1-parks1": "linux",
    "coder-vscode.us-west-2.coder-dev.nextcloud.aero--parks1--k3s-node1-parks1.node0": "linux",
    "coder-vscode.workspaces-dev.nextcloud.aero--parks1--seungweon-first-10": "linux"
  },
  "ruff.configuration": "",
  "security.workspace.trust.untrustedFiles": "open",
  "terminal.integrated.fontFamily": "MesloLGS NF",
  "yaml.schemas": {
    "/Users/seungweonpark/.vscode/extensions/continue.continue-1.0.9-darwin-arm64/config-yaml-schema.json": [
      ".continue/**/*.yaml"
    ]
  }
}
```

---

## With this setup, you'll have your Git tooling, VS Code extensions, and developer environment ready to go across systems.

## 🧾 Git Global Configuration Script

To set up a clean and reusable Git configuration, use the following script:

### 📄 `setup_git_global_config.sh`

This script sets up common Git configurations and aliases, including user identity, commit preferences, and helpful shortcuts.

#### 🔧 How to Use

1. Open the script and **update `user.name`, `user.email`, and file paths** (`commit.template`, `init.templatedir`) to your preferences.
2. Run the script:

```bash
./setup_git_global_config.sh
```

> It’s recommended to run this script once after installing Git on a new machine.

---
