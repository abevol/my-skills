#!/bin/bash
# add-skill.sh - 添加新技能到"我的技能"并注册

SKILL_NAME=$1
SKILL_DESC=$2
SKILL_PATH=$3

if [ -z "$SKILL_NAME" ] || [ -z "$SKILL_DESC" ]; then
    echo "Usage: ./add-skill.sh <skill-name> <description> [skill-source-path]"
    echo "Example: ./add-skill.sh my-tool \"My useful tool\" ~/Downloads/my-tool"
    exit 1
fi

SKILLS_DIR="~/.agent/my-skills/skills"

# 如果提供了源路径，复制技能
if [ ! -z "$SKILL_PATH" ]; then
    echo "Copying skill from $SKILL_PATH..."
    cp -r "$SKILL_PATH" "$SKILLS_DIR/$SKILL_NAME"
fi

# 检查 SKILL.md 是否存在
if [ ! -f "$SKILLS_DIR/$SKILL_NAME/SKILL.md" ]; then
    echo "Error: SKILL.md not found in $SKILLS_DIR/$SKILL_NAME/"
    exit 1
fi

echo "✓ Skill copied to $SKILLS_DIR/$SKILL_NAME/"

# 提示用户更新 README.md 和 marketplace.json
echo ""
echo "Next steps:"
echo "1. Update README.md to add skill entry"
echo "2. Update .claude-plugin/marketplace.json to register skill"
echo "3. Run: git add . && git commit -m \"feat: add skill $SKILL_NAME\" && git push"
