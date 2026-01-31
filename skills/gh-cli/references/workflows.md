# GitHub CLI 工作流示例

本文档提供使用 gh CLI 的常见工作流示例。

## 日常开发工作流

### 1. 开始新功能开发

```bash
# 1. 确保在正确的仓库中
gh repo view

# 2. 查看当前 PR 状态
gh pr status

# 3. 创建并切换到新分支
git checkout -b feature/new-feature

# 4. 进行代码更改...
# ... coding ...

# 5. 提交更改
git add .
git commit -m "Add new feature"

# 6. 推送分支
git push -u origin feature/new-feature

# 7. 创建 PR
gh pr create --title "Add new feature" --body "## 变更\n- 添加了新功能\n- 修复了 bug"
```

### 2. 审查和合并 PR

```bash
# 1. 列出待审查的 PR
gh pr list --review-requested=@me

# 2. 查看 PR 详情
gh pr view 123

# 3. 检出 PR 进行本地测试
gh pr checkout 123

# 4. 查看差异
gh pr diff 123

# 5. 查看状态检查
gh pr checks 123

# 6. 添加审查意见
gh pr review 123 --comment --body "需要修改..."
# 或批准
gh pr review 123 --approve

# 7. 合并 PR
gh pr merge 123 --squash
```

### 3. Issue 管理工作流

```bash
# 1. 查看分配给您的 Issue
gh issue list --assignee=@me

# 2. 查看 Issue 详情
gh issue view 456

# 3. 开始处理 Issue - 创建分支
gh issue develop 456 --checkout

# 4. 完成后，创建 PR 并关联 Issue
gh pr create --title "Fix #456" --body "Closes #456"

# 5. PR 合并后，Issue 会自动关闭
```

## 发布管理工作流

### 1. 创建新版本发布

```bash
# 1. 确保在 main 分支
gh repo view --branch main

# 2. 拉取最新更改
git pull origin main

# 3. 创建标签
git tag -a v1.2.0 -m "Release version 1.2.0"
git push origin v1.2.0

# 4. 创建发布
gh release create v1.2.0 \
  --title "Version 1.2.0" \
  --notes-file RELEASE_NOTES.md \
  --verify-tag

# 5. 上传构建产物
gh release upload v1.2.0 ./dist/app-v1.2.0.exe
```

### 2. 生成发布说明

```bash
# 使用 GitHub 自动生成发布说明
gh release create v1.2.0 --generate-notes

# 查看未包含在发布中的 PR
gh pr list --state merged --search "merged:>2024-01-01"
```

## 团队协作工作流

### 1. Fork 和贡献工作流

```bash
# 1. Fork 上游仓库
gh repo fork upstream/repo

# 2. 克隆 fork
gh repo clone my-username/repo

# 3. 添加上游远程
gh repo fork --clone --remote

# 4. 创建功能分支
git checkout -b feature/improvement

# 5. 提交更改并推送
# ...

# 6. 创建 PR
gh pr create --repo upstream/repo

# 7. 保持 fork 同步
gh repo sync
```

### 2. 管理组织仓库

```bash
# 1. 查看组织中的仓库
gh repo list my-org --limit 100

# 2. 批量创建仓库
for repo in repo1 repo2 repo3; do
  gh repo create my-org/$repo --private --template my-org/template
done

# 3. 设置仓库权限
gh api repos/my-org/repo/collaborators/username \
  -X PUT -f permission=admin
```

## CI/CD 集成工作流

### 1. 监控 Actions 运行

```bash
# 1. 列出最近的运行
gh run list --limit 20

# 2. 查看失败的运行
gh run list --status failure

# 3. 查看特定运行的日志
gh run view 123456789 --log-failed

# 4. 重新运行失败的任务
gh run rerun 123456789 --failed

# 5. 监视正在进行的运行
gh run watch 123456789
```

### 2. 管理工作流

```bash
# 1. 列出工作流
gh workflow list

# 2. 禁用暂时不需要的工作流
gh workflow disable "old-workflow.yml"

# 3. 启用工作流
gh workflow enable "new-workflow.yml"

# 4. 手动触发工作流
gh workflow run "deploy.yml" -f environment=production
```

### 3. 管理 Secrets 和 Variables

```bash
# 1. 列出 Secrets
gh secret list

# 2. 设置 Secret
gh secret set API_KEY --body "secret-value"
# 或从文件
gh secret set API_KEY < api-key.txt

# 3. 设置 Variables
gh variable set VERSION --body "1.0.0"

# 4. 删除旧 Secret
gh secret delete OLD_SECRET
```

## 自动化工作流

### 1. 批量 Issue 操作

```bash
# 1. 批量关闭旧 Issue
gh issue list --state open --label "wontfix" | \
  awk '{print $1}' | \
  xargs -I {} gh issue close {}

# 2. 批量添加标签
gh issue list --state open | \
  grep "bug" | \
  awk '{print $1}' | \
  xargs -I {} gh issue edit {} --add-label bug

# 3. 导出 Issue 列表
gh issue list --state all --json number,title,state,labels | \
  jq '.[] | {number, title, state}' > issues.json
```

### 2. 自动化报告生成

```bash
# 1. 获取仓库统计信息
gh api repos/owner/repo | jq '{stars: .stargazers_count, forks: .forks_count}'

# 2. 生成贡献者报告
gh api repos/owner/repo/contributors | jq '.[] | {login, contributions}'

# 3. 获取最近的发布统计
gh release view --json tagName,createdAt,publishedAt,assets
```

### 3. 代码空间批量管理

```bash
# 1. 列出所有代码空间
gh codespace list

# 2. 停止不活动的代码空间
gh codespace list | \
  grep "Idle" | \
  awk '{print $1}' | \
  xargs -I {} gh codespace stop {}

# 3. 删除旧的代码空间
gh codespace list | \
  awk '$4 < "2024-01-01" {print $1}' | \
  xargs -I {} gh codespace delete {} --yes
```

## 故障排除工作流

### 1. 诊断认证问题

```bash
# 1. 检查认证状态
gh auth status

# 2. 重新认证
gh auth login --hostname github.enterprise.com

# 3. 刷新令牌
gh auth refresh --scopes repo,workflow
```

### 2. 调试 API 问题

```bash
# 1. 启用调试模式
GH_DEBUG=1 gh api repos/owner/repo

# 2. 检查 API 响应
gh api repos/owner/repo --jq '.permissions'

# 3. 验证权限
gh api user/repos | jq '.[] | {name, permissions}'
```

### 3. 修复同步问题

```bash
# 1. 同步 fork
gh repo sync

# 2. 强制同步（丢弃本地更改）
gh repo sync --force

# 3. 查看远程信息
gh repo view --json url,defaultBranchRef,viewerPermission
```

## 最佳实践

### 1. 使用别名提高效率

```bash
# 设置常用别名
gh alias set prc "pr create"
gh alias set pl "pr list"
gh alias set pv "pr view"
gh alias set ic "issue create"
gh alias set rv "repo view"

# 使用别名
gh prc --title "Quick fix"
gh pl --author=@me
```

### 2. 配置合理的默认值

```bash
# 设置默认编辑器
gh config set editor code

# 使用 SSH 协议
gh config set git_protocol ssh

# 禁用提示（在脚本中使用）
gh config set prompt disabled
```

### 3. 使用 JSON 输出进行自动化

```bash
# 获取结构化数据
gh pr list --json number,title,headRefName,state | jq

# 过滤特定数据
gh pr list --json number,title,author | jq '.[] | select(.author.login == "user")'

# 导出到文件
gh issue list --json number,title,state > issues-$(date +%Y%m%d).json
```

### 4. 结合其他工具

```bash
# 使用 fzf 进行交互式选择
gh pr list | fzf | awk '{print $1}' | xargs gh pr checkout

# 使用 jq 处理 JSON
gh api repos/owner/repo/issues | jq '.[] | select(.state == "open")'

# 与 Git 命令结合
git log --oneline | head -n 10 | while read hash msg; do
  gh browse $hash
done
```
