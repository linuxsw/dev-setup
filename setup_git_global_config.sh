#!/bin/bash

# Set Git global configuration for a developer setup

# Update these values with your personal name and email
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

git config --global credential.helper store
git config --global commit.gpgsign false
git config --global commit.signoff true

# Update this path to point to your preferred commit template
git config --global commit.template "~/.git-commit-template"
git config --global init.templatedir "~/.git-templates"

# Git command aliases
git config --global alias.commit '!f() { git commit -s "$@"; }; f'
git config --global alias.st status
git config --global alias.ci commit
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.last 'log -1 HEAD'
git config --global alias.graph 'log --oneline --graph --decorate --all'

# Preferred editor
git config --global core.editor vim

echo "✅ Git global configuration has been set. Please edit 'user.name', 'user.email', and file paths as needed."
