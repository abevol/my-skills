---
name: my-skills-manager
description: 我的技能管理。用于管理本地 AI Agent 技能，包括添加、更新、安装和卸载技能。当用户需要管理个人技能库中的技能时使用此技能。
---

# 我的技能管理

此技能用于管理本地 AI Agent 技能库，支持添加新技能、更新现有技能、从 GitHub 安装技能以及卸载技能。

## 技能存放目录

技能默认存放于：`~/.agent/my-skills/skills/<skill-name>/SKILL.md`

## 工作流

### 1. 添加/创建新技能

当用户要求将技能放入/添加/创建/生成/提交到"我的技能"时：

**步骤 a**: 将技能移入目录
- 将技能文件复制到 `~/.agent/my-skills/skills/<skill-name>/`
- 技能主文件命名为 `SKILL.md`
- 如需附加文件，可创建 `references/`、`scripts/`、`assets/` 等子目录

**步骤 b**: 更新注册信息
- 编辑 `README.md`，在技能列表中添加新技能条目
- 编辑 `.claude-plugin/marketplace.json`，在 `skills` 数组中添加技能路径

**步骤 c**: 提交并推送
- 提交 git 更改
- 推送到远程仓库

**示例**:
```bash
# 创建技能目录
mkdir -p ~/.agent/my-skills/skills/my-new-skill

# 创建 SKILL.md 文件
cat > ~/.agent/my-skills/skills/my-new-skill/SKILL.md << 'EOF'
---
name: my-new-skill
description: 新技能描述
---

# 我的新技能

技能内容...
EOF
```

### 2. 更新现有技能

当用户要求更新/修改"我的技能"当中的技能时：

**步骤 a**: 修改技能内容
- 根据用户需求修改 `SKILL.md` 或相关文件

**步骤 b**: 更新注册信息
- 如需修改名称或描述，同步更新 `README.md` 和 `marketplace.json`

**步骤 c**: 提交并推送
- 提交 git 更改
- 推送到远程仓库

### 3. 从 GitHub 安装技能

当用户要求安装 GitHub 仓库技能时：

**执行命令**:
```bash
npx openskills install <author>/<repo_name> --global --universal -y
```

**同步配置**:
```bash
npx openskills sync -o C:/Users/jayvi/.agent/AGENTS.md
```

**示例**:
```bash
# 安装 GitHub 上的技能
npx openskills install abevol/gh-cli --global --universal -y

# 同步到 AGENTS.md
npx openskills sync -o C:/Users/jayvi/.agent/AGENTS.md
```

### 4. 安装本地技能

当用户要求安装本地技能时（一般是"我的技能"当中的技能）：

**执行命令**:
```bash
npx openskills install ~/.agent/my-skills/skills/<skill-name> --global --universal -y
```

**同步配置**:
```bash
npx openskills sync -o C:/Users/jayvi/.agent/AGENTS.md
```

**示例**:
```bash
# 安装本地技能
npx openskills install ~/.agent/my-skills/skills/gh-cli --global --universal -y

# 同步到 AGENTS.md
npx openskills sync -o C:/Users/jayvi/.agent/AGENTS.md
```

### 5. 卸载技能

当用户要求卸载技能时：

**执行命令**:
```bash
npx openskills remove <skill-name>
```

**同步配置**:
```bash
npx openskills sync -o C:/Users/jayvi/.agent/AGENTS.md
```

**示例**:
```bash
# 卸载技能
npx openskills remove gh-cli

# 同步到 AGENTS.md
npx openskills sync -o C:/Users/jayvi/.agent/AGENTS.md
```

## 技能目录结构

```
~/.agent/my-skills/
├── .claude-plugin/
│   └── marketplace.json    # 技能注册配置
├── skills/
│   ├── <skill-name-1>/
│   │   ├── SKILL.md        # 技能主文件
│   │   ├── references/     # 参考资料（可选）
│   │   ├── scripts/        # 脚本文件（可选）
│   │   └── assets/         # 资源文件（可选）
│   └── <skill-name-2>/
│       └── SKILL.md
└── README.md               # 技能列表文档
```

## SKILL.md 格式规范

技能文件必须包含 YAML Front Matter：

```yaml
---
name: skill-name
description: 技能的简短描述，说明用途和触发条件
---
```

随后是 Markdown 格式的技能内容，包括：
- 技能概述
- 使用场景
- 具体工作流
- 命令示例
- 注意事项

## marketplace.json 配置

```json
{
  "name": "abevol-my-skills",
  "owner": {
    "name": "Abevol",
    "email": "abevol@github.com"
  },
  "metadata": {
    "description": "Abevol's AI Agent skills",
    "version": "1.0.0"
  },
  "plugins": [
    {
      "name": "my-skills",
      "description": "Collection of AI Agent skills for personal use.",
      "source": "./",
      "strict": false,
      "skills": [
        "./skills/skill-name-1",
        "./skills/skill-name-2"
      ]
    }
  ]
}
```

## 常用命令速查

| 操作 | 命令 |
|------|------|
| 安装 GitHub 技能 | `npx openskills install <author>/<repo> --global --universal -y` |
| 安装本地技能 | `npx openskills install <local-path> --global --universal -y` |
| 卸载技能 | `npx openskills remove <skill-name>` |
| 同步配置 | `npx openskills sync -o <output-path>` |
| 查看已安装技能 | `npx openskills list` |

## 注意事项

1. **路径格式**: Windows 系统使用 `C:/Users/...` 格式，避免使用反斜杠
2. **命名规范**: 技能名称使用小写字母和连字符，如 `my-skill-name`
3. **描述清晰**: description 应明确说明技能用途和触发条件
4. **及时同步**: 安装/卸载技能后务必执行 `sync` 命令更新 AGENTS.md
5. **版本管理**: 所有技能更改应提交到 git 并推送到远程仓库
