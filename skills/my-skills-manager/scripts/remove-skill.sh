#!/bin/bash
# remove-skill.sh - 卸载技能

SKILL_NAME=$1

if [ -z "$SKILL_NAME" ]; then
    echo "Usage: ./remove-skill.sh <skill-name>"
    echo "Example: ./remove-skill.sh my-old-skill"
    exit 1
fi

echo "Removing skill: $SKILL_NAME..."
npx openskills remove "$SKILL_NAME"

if [ $? -eq 0 ]; then
    echo "✓ Skill removed successfully"
    echo "Syncing to AGENTS.md..."
    npx openskills sync -o "C:\Users\jayvi\.agent\AGENTS.md"
    echo "✓ Done"
else
    echo "✗ Removal failed"
    exit 1
fi
