# GitHub CLI 完整命令参考

本文档包含 gh CLI 的完整命令列表和详细说明。

## 核心命令

### auth - 认证管理
```
gh auth <command>

命令：
  login       登录 GitHub
  logout      登出 GitHub
  status      查看认证状态
  refresh     刷新认证
  token       打印认证令牌
  switch      切换活动账户
```

### browse - 浏览器操作
```
gh browse [<number> | <path>] [flags]

选项：
  -b, --branch <string>    查看特定分支
  -c, --commit             查看特定提交
  -n, --no-browser         打印 URL 而不是打开浏览器
  -p, --projects           查看项目
  -s, --settings           打开设置页面
  -w, --wiki               打开 Wiki 页面
```

### codespace - 代码空间
```
gh codespace <command>

命令：
  code          在 VS Code 中打开代码空间
  cp            在代码空间内复制文件
  create        创建代码空间
  delete        删除代码空间
  edit          编辑代码空间
  jupyter       在 JupyterLab 中打开代码空间
  list          列出代码空间
  logs          访问代码空间日志
  ports         管理代码空间端口
  rebuild       重建代码空间
  ssh           通过 SSH 连接到代码空间
  stop          停止代码空间
```

### gist - Gist 管理
```
gh gist <command>

命令：
  clone         克隆 Gist
  create        创建 Gist
  delete        删除 Gist
  edit          编辑 Gist
  list          列出 Gist
  rename        重命名 Gist 文件
  view          查看 Gist
```

### issue - Issue 管理
```
gh issue <command>

命令：
  close         关闭 Issue
  comment       添加评论
  create        创建 Issue
  delete        删除 Issue
  develop       管理开发分支
  edit          编辑 Issue
  list          列出 Issue
  lock          锁定 Issue 对话
  pin           置顶 Issue
  reopen        重新打开 Issue
  transfer      转移 Issue
  unlock        解锁 Issue 对话
  unpin         取消置顶 Issue
  view          查看 Issue
```

### org - 组织管理
```
gh org <command>

命令：
  list          列出组织
  invite        邀请用户到组织
  public-key    查看组织的 SSH 公钥
  view          查看组织信息
```

### pr - Pull Request 管理
```
gh pr <command>

命令：
  checkout      检出 PR 分支
  checks        查看 PR 状态检查
  close         关闭 PR
  comment       添加评论
  create        创建 PR
  diff          查看 PR 差异
  edit          编辑 PR
  list          列出 PR
  lock          锁定 PR 对话
  merge         合并 PR
  ready         将草稿 PR 标记为就绪
  reopen        重新打开 PR
  review        审核 PR
  unlock        解锁 PR 对话
  view          查看 PR
```

### project - GitHub Projects
```
gh project <command>

命令：
  close         关闭项目
  copy          复制项目
  create        创建项目
  delete        删除项目
  edit          编辑项目
  field-create  创建自定义字段
  field-delete  删除自定义字段
  field-list    列出自定义字段
  item-add      添加项目项
  item-archive  归档项目项
  item-create   创建草稿项目项
  item-delete   删除项目项
  item-edit     编辑项目项
  item-list     列出项目项
  link          链接仓库到项目
  list          列出项目
  unlink        取消链接仓库
  view          查看项目
```

### release - 发布管理
```
gh release <command>

命令：
  create        创建发布
  delete        删除发布
  download      下载发布资源
  edit          编辑发布
  list          列出发布
  upload        上传资源到发布
  view          查看发布
```

### repo - 仓库管理
```
gh repo <command>

命令：
  archive       归档仓库
  clone         克隆仓库
  create        创建仓库
  default-branch 管理默认分支
  delete        删除仓库
  deploy-key    管理部署密钥
  edit          编辑仓库设置
  fork          创建分支
  gc            运行垃圾回收
  list          列出仓库
  rename        重命名仓库
  set-default   设置默认仓库
  sync          同步分支
  unarchive     取消归档仓库
  view          查看仓库
```

## GitHub Actions 命令

### cache - Actions 缓存
```
gh cache <command>

命令：
  delete        删除缓存
  list          列出缓存
```

### run - 工作流运行
```
gh run <command>

命令：
  cancel        取消运行
  delete        删除运行
  download      下载运行产物
  list          列出运行
  rerun         重新运行
  view          查看运行
  watch         监视运行
```

### workflow - 工作流
```
gh workflow <command>

命令：
  disable       禁用工作流
  enable        启用工作流
  list          列出工作流
  run           运行工作流
  view          查看工作流
```

## 附加命令

### alias - 命令别名
```
gh alias <command>

命令：
  delete        删除别名
  import        从 YAML 导入别名
  list          列出别名
  set           创建别名
```

### api - API 请求
```
gh api <endpoint> [flags]

选项：
  -f, --field <key=value>        添加参数字段
  -H, --header <key:value>       添加 HTTP 请求头
  -i, --include                  包含 HTTP 响应头
  -X, --method <string>          HTTP 方法 (default "GET")
      --paginate                 请求所有页面
  -q, --jq <expression>          jq 查询过滤
  -t, --template <string>        模板格式化输出
```

### attestation - 工件认证
```
gh attestation <command>

命令：
  verify        验证工件认证
```

### completion - Shell 补全
```
gh completion <command>

支持：bash, zsh, fish, powershell
```

### config - 配置管理
```
gh config <command>

命令：
  get           获取配置值
  list          列出配置
  set           设置配置值
```

### extension - 扩展管理
```
gh extension <command>

命令：
  create        创建扩展
  exec          执行扩展
  install       安装扩展
  list          列出扩展
  remove        删除扩展
  search        搜索扩展
  upgrade       升级扩展
```

### gpg-key - GPG 密钥
```
gh gpg-key <command>

命令：
  add           添加 GPG 密钥
  delete        删除 GPG 密钥
  list          列出 GPG 密钥
```

### label - 标签管理
```
gh label <command>

命令：
  clone         克隆标签
  create        创建标签
  delete        删除标签
  edit          编辑标签
  list          列出标签
```

### ruleset - 规则集
```
gh ruleset <command>

命令：
  check         检查规则集
  list          列出规则集
  view          查看规则集
```

### search - 搜索
```
gh search <command>

命令：
  code          搜索代码
  commits       搜索提交
  issues        搜索 Issue
  prs           搜索 PR
  repos         搜索仓库
```

### secret - Secrets 管理
```
gh secret <command>

命令：
  delete        删除 Secret
  list          列出 Secret
  set           设置 Secret
```

### ssh-key - SSH 密钥
```
gh ssh-key <command>

命令：
  add           添加 SSH 密钥
  delete        删除 SSH 密钥
  list          列出 SSH 密钥
```

### status - 状态概览
```
gh status [flags]

显示相关 Issue、PR 和通知的汇总信息。
```

### variable - 变量管理
```
gh variable <command>

命令：
  delete        删除变量
  list          列出变量
  set           设置变量
```

## 别名命令

```
co              pr checkout 的别名
```

## 全局标志

```
--help          显示命令帮助
--version       显示 gh 版本
```

## 环境变量

| 变量 | 说明 |
|------|------|
| `GH_TOKEN` | GitHub Personal Access Token |
| `GH_REPO` | 默认仓库 (owner/repo) |
| `GH_HOST` | GitHub Enterprise Server 主机 |
| `GH_EDITOR` | 默认编辑器 |
| `GH_PAGER` | 分页器 |
| `GH_PROMPT_DISABLED` | 禁用交互式提示 |
| `GH_DEBUG` | 启用调试模式 |
| `GH_DEBUG_API` | 启用 API 调试 |
| `GH_NO_UPDATE_NOTIFIER` | 禁用更新通知 |

## 示例

```bash
# 创建 Issue
gh issue create --title "Bug" --body "Description" --label bug

# 创建 PR
gh pr create --base main --head feature-branch

# 批量关闭旧 Issue
gh issue list --state open --label stale | gh issue close --stdin

# 搜索热门仓库
gh search repos "machine learning" --sort stars --order desc
```
