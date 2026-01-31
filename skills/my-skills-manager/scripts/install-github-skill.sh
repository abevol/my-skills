#!/bin/bash
# install-github-skill.sh - 从 Github 安装技能

REPO=$1

if [ -z "$REPO" ]; then
    echo "Usage: ./install-github-skill.sh <author>/<repo_name>"
    echo "Example: ./install-github-skill.sh myuser/my-skill"
    exit 1
fi

echo "Installing skill from Github: $REPO..."
npx openskills install "$REPO" --global --universal -y

if [ $? -eq 0 ]; then
    echo "✓ Skill installed successfully"
    echo "Syncing to AGENTS.md..."
    npx openskills sync -o "C:\Users\jayvi\.agent\AGENTS.md"
    echo "✓ Done"
else
    echo "✗ Installation failed"
    exit 1
fi
