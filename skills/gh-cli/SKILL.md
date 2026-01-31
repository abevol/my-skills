---
name: gh-cli
description: GitHub CLI (gh) 技能。用于通过命令行与 GitHub 进行无缝交互，包括仓库管理、PR/Issue 操作、代码空间管理、发布管理等。当用户需要与 GitHub 仓库、PR、Issue、Release、Codespace 等交互，或需要执行 GitHub 相关自动化任务时使用此技能。
---

# GitHub CLI (gh) 技能

GitHub CLI (gh) 是一个命令行工具，允许用户直接从终端与 GitHub 进行交互，无需切换到浏览器。

## 快速开始

### 认证
```bash
# 登录 GitHub
gh auth login

# 查看当前认证状态
gh auth status

# 登出
gh auth logout
```

### 核心命令概览

| 命令 | 用途 |
|------|------|
| `gh repo` | 管理仓库 |
| `gh pr` | 管理 Pull Request |
| `gh issue` | 管理 Issue |
| `gh gist` | 管理 Gist |
| `gh release` | 管理发布 |
| `gh codespace` | 管理代码空间 |
| `gh browse` | 在浏览器中打开仓库 |

## 仓库管理 (gh repo)

### 常用操作
```bash
# 克隆仓库
gh repo clone owner/repo

# 创建新仓库
gh repo create my-project --public
gh repo create my-project --private --description "My new project"

# 查看仓库列表
gh repo list
gh repo list owner --limit 50

# 查看仓库详情
gh repo view owner/repo

# 在浏览器中打开仓库
gh repo view owner/repo --web

# 删除仓库（谨慎使用）
gh repo delete owner/repo --yes
```

### 分叉与同步
```bash
# 创建分支
gh repo fork owner/repo

# 同步 fork
gh repo sync owner/repo
```

## Pull Request 管理 (gh pr)

### 查看 PR
```bash
# 列出 PR
gh pr list
gh pr list --state merged
gh pr list --author username
gh pr list --label bug

# 查看 PR 详情
gh pr view 123
gh pr view 123 --web
```

### 创建 PR
```bash
# 创建 PR（交互式）
gh pr create

# 创建 PR 并指定标题和正文
gh pr create --title "Fix bug" --body "This PR fixes..."

# 从当前分支创建草稿 PR
gh pr create --draft
```

### PR 操作
```bash
# 检出 PR 分支
gh pr checkout 123

# 合并 PR
gh pr merge 123
gh pr merge 123 --squash
gh pr merge 123 --rebase

# 关闭 PR
gh pr close 123

# 重新打开 PR
gh pr reopen 123

# 在 PR 上添加评论
gh pr comment 123 --body "LGTM!"

# 查看 PR 状态检查
gh pr checks 123

# 查看 PR 差异
gh pr diff 123
```

## Issue 管理 (gh issue)

### 查看 Issue
```bash
# 列出 Issue
gh issue list
gh issue list --state closed
gh issue list --assignee username
gh issue list --label bug

# 查看 Issue 详情
gh issue view 123
gh issue view 123 --web
```

### 创建和管理
```bash
# 创建 Issue
gh issue create
gh issue create --title "Bug report" --body "Description..."

# 关闭 Issue
gh issue close 123

# 重新打开 Issue
gh issue reopen 123

# 添加评论
gh issue comment 123 --body "I can reproduce this"

# 分配给某人
gh issue edit 123 --assignee username

# 添加标签
gh issue edit 123 --label bug --label priority-high
```

## Gist 管理 (gh gist)

```bash
# 创建 Gist
gh gist create file.txt
gh gist create file.txt --public --desc "My gist"

# 列出 Gist
gh gist list

# 查看 Gist
gh gist view GIST_ID

# 克隆 Gist
gh gist clone GIST_ID

# 删除 Gist
gh gist delete GIST_ID
```

## 发布管理 (gh release)

```bash
# 列出发布
gh release list

# 创建发布
gh release create v1.0.0 --title "Version 1.0.0" --notes "Release notes"

# 上传资源到发布
gh release upload v1.0.0 ./binary.exe

# 下载发布资源
gh release download v1.0.0

# 删除发布
gh release delete v1.0.0
```

## 代码空间管理 (gh codespace)

```bash
# 列出代码空间
gh codespace list

# 创建代码空间
gh codespace create --repo owner/repo

# 连接到代码空间
gh codespace ssh
gh codespace code  # 在 VS Code 中打开

# 停止代码空间
gh codespace stop

# 删除代码空间
gh codespace delete
```

## GitHub Actions (gh workflow, gh run, gh cache)

### 工作流管理
```bash
# 列出工作流
gh workflow list

# 查看工作流
gh workflow view workflow.yml

# 启用/禁用工作流
gh workflow enable workflow.yml
gh workflow disable workflow.yml

# 手动触发工作流
gh workflow run workflow.yml
```

### 运行管理
```bash
# 列出运行记录
gh run list
gh run list --workflow workflow.yml

# 查看运行详情
gh run view RUN_ID
gh run view RUN_ID --log

# 重新运行
gh run rerun RUN_ID
gh run rerun RUN_ID --failed

# 取消运行
gh run cancel RUN_ID

# 查看日志
gh run view RUN_ID --log-failed
```

## 搜索功能 (gh search)

```bash
# 搜索仓库
gh search repos "query"
gh search repos --language python --stars ">100"

# 搜索 Issue
gh search issues "query"
gh search issues --state open --label bug

# 搜索 PR
gh search prs "query"
gh search prs --state merged

# 搜索代码
gh search code "query" --repo owner/repo
```

## 常用快捷命令

```bash
# 别名：快速检出 PR
gh co 123  # 等同于 gh pr checkout 123

# 在浏览器中打开当前仓库
gh browse

# 查看状态
gh status
```

## 配置与扩展

### 配置管理
```bash
# 查看配置
gh config list

# 设置编辑器
gh config set editor vim

# 设置默认分支
gh config set git_protocol ssh
```

### 扩展管理
```bash
# 列出扩展
gh extension list

# 安装扩展
gh extension install owner/extension

# 升级扩展
gh extension upgrade extension-name

# 删除扩展
gh extension remove extension-name
```

## API 访问

```bash
# 直接调用 GitHub API
gh api repos/owner/repo/issues
gh api repos/owner/repo/pulls --method POST --input pr.json
```

## 高级技巧

### JSON 输出
```bash
# 获取 JSON 格式的数据
gh pr list --json number,title,author,state
gh issue list --json number,title,labels --jq '.[] | select(.labels | contains(["bug"]))'
```

### 模板使用
```bash
# 使用 PR 模板
gh pr create --template "PULL_REQUEST_TEMPLATE.md"

# 使用 Issue 模板
gh issue create --template "bug_report.md"
```

## 常见问题

### 认证问题
- 运行 `gh auth status` 检查认证状态
- 运行 `gh auth login` 重新登录
- 检查 SSH 密钥配置：`gh config get git_protocol`

### 权限问题
- 确保有仓库的适当权限
- 检查 Personal Access Token 的 scopes
- 对于组织仓库，可能需要额外的组织授权

## 完整参考

更多详细信息，请参阅 [references/commands.md](references/commands.md) 获取完整命令参考。
