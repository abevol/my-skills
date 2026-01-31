#!/bin/bash
# install-local-skill.sh - 安装本地"我的技能"中的技能

SKILL_NAME=$1

if [ -z "$SKILL_NAME" ]; then
    echo "Usage: ./install-local-skill.sh <skill-name>"
    echo "Example: ./install-local-skill.sh my-skills-manager"
    exit 1
fi

SKILL_PATH="~/.agent/my-skills/skills/$SKILL_NAME"

echo "Installing local skill: $SKILL_NAME..."
npx openskills install "$SKILL_PATH" --global --universal -y

if [ $? -eq 0 ]; then
    echo "✓ Skill installed successfully"
    echo "Syncing to AGENTS.md..."
    npx openskills sync -o "C:\Users\jayvi\.agent\AGENTS.md"
    echo "✓ Done"
else
    echo "✗ Installation failed"
    exit 1
fi
