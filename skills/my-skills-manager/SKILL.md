---
name: my-skills-manager
description: 管理本地技能仓库"我的技能"的自动化工作流。当用户要求将技能放入/添加/创建/生成/提交到"我的技能"、更新/修改"我的技能"中的技能、安装 Github/本地技能或卸载技能时触发使用。
license: MIT
---

# 我的技能管理

本技能提供管理本地技能仓库"我的技能"的完整工作流。

## 技能存放目录

技能存放于：`~/.agent/my-skills/skills/<skill-name>/`

每个技能必须包含 `SKILL.md` 文件。

## 核心工作流

### 1. 添加新技能到"我的技能"

当用户要求将技能放入/添加/创建/生成/提交到"我的技能"时：

**步骤：**

a. **移动/创建技能文件**
   - 将技能移入目录 `~/.agent/my-skills/skills/`
   - 路径格式：`~/.agent/my-skills/skills/<skill-name>/SKILL.md`
   - 如需创建 scripts/references/assets 子目录，一并创建

b. **更新注册信息**
   - 编辑 `README.md`：在技能列表中添加新技能条目
   - 编辑 `.claude-plugin/marketplace.json`：添加技能元数据

   **marketplace.json 格式：**
   ```json
   {
     "name": "skill-name",
     "description": "技能描述",
     "location": "local",
     "author": "your-name"
   }
   ```

c. **提交并推送**
   ```bash
   git add .
   git commit -m "feat: add skill <skill-name>"
   git push origin main
   ```

### 2. 更新"我的技能"中的技能

当用户要求更新/修改"我的技能"中的技能时：

**步骤：**

a. **修改技能内容**
   - 根据需求修改 `SKILL.md` 或捆绑资源
   - 更新 scripts/references/assets 如有需要

b. **更新注册信息**
   - 如描述变更，同步更新 `README.md` 和 `.claude-plugin/marketplace.json`

c. **提交并推送**
   ```bash
   git add .
   git commit -m "update: <skill-name> - <变更描述>"
   git push origin main
   ```

### 3. 安装 Github 仓库技能

当用户要求安装 Github 仓库技能时：

**执行命令：**

```bash
npx openskills install <author>/<repo_name> --global --universal -y
```

成功后同步到 AGENTS.md：

```bash
npx openskills sync -o C:\Users\jayvi\.agent\AGENTS.md
```

### 4. 安装本地技能

当用户要求安装本地技能（通常是"我的技能"中的技能）时：

**执行命令：**

```bash
npx openskills install ~/.agent/my-skills/skills/<skill-name> --global --universal -y
```

成功后同步到 AGENTS.md：

```bash
npx openskills sync -o C:\Users\jayvi\.agent\AGENTS.md
```

### 5. 卸载技能

当用户要求卸载技能时：

**执行命令：**

```bash
npx openskills remove <skill-name>
```

成功后同步到 AGENTS.md：

```bash
npx openskills sync -o C:\Users\jayvi\.agent\AGENTS.md
```

## 目录结构参考

```
my-skills/
├── README.md                      # 技能列表和说明
├── .claude-plugin/
│   └── marketplace.json          # 技能注册信息
└── skills/
    ├── skill-a/
    │   └── SKILL.md
    ├── skill-b/
    │   ├── SKILL.md
    │   ├── scripts/
    │   └── references/
    └── my-skills-manager/        # 本技能
        └── SKILL.md
```

## 注意事项

- 技能名称使用小写字母和连字符（kebab-case）
- SKILL.md 必须包含 YAML frontmatter（name 和 description）
- marketplace.json 中的 location 字段对于本地技能应为 "local"
- 提交信息应遵循约定式提交格式（feat:, update:, fix: 等）
