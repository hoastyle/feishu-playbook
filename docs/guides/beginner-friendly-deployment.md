# 飞书文档工具快速上手指南

**研发部专用版本** - 10分钟从零到完成

---

## 🎯 这份指南适合谁？

- ✅ 研发部需要使用飞书文档工具的开发者
- ✅ 需要将本地文档同步到飞书的工程师
- ✅ 需要使用 AI 辅助编辑飞书文档的用户
- ✅ 需要配置 CI/CD 自动化文档上传的开发者

**预计完成时间**: 10-15 分钟  
**难度级别**: ⭐☆☆☆☆ (新手友好)

**前提条件**:
- ✅ 飞书应用已创建完成
- ✅ 已获得 `FEISHU_APP_ID` 和 `FEISHU_APP_SECRET`
- ✅ 已安装 Python 3.10+
- ✅ 已安装 Docker（用于 Feishu-MCP）
- ✅ 已安装 Claude Code

---

## 📋 目录

1. [快速开始](#1-快速开始) - 3分钟完成基础配置
2. [部署 feishu-doc-tools](#2-部署-feishu-doc-tools) - 命令行工具
3. [部署 Feishu-MCP](#3-部署-feishu-mcp) - AI 编辑服务
4. [激活 MCP 服务](#4-激活-mcp-服务) - 在 Claude Code 中使用
5. [使用方法](#5-使用方法) - 常见操作示例
6. [常见问题](#6-常见问题) - 快速故障排查

---

## 1. 快速开始

### 认证模式说明

**本指南仅使用用户认证（User Authentication）**

为什么？
- ✅ 使用你自己的飞书权限，无需额外配置
- ✅ 可以访问你个人的 Wiki 空间
- ✅ 支持 Wiki 文档搜索
- ✅ 文档归属明确（属于你个人）

### 工具对比

| 工具 | 主要用途 | 部署方式 | 适用场景 |
|------|---------|---------|---------|
| **feishu-doc-tools** | 批量上传/下载文档 | Python + uv | CI/CD、自动化脚本、批量操作 |
| **Feishu-MCP** | AI 辅助编辑文档 | Docker | Claude Code 中智能编辑 |

**推荐**: 两个工具都安装，配合使用效果最佳

---

## 2. 部署 feishu-doc-tools

### 步骤 1: 安装 uv（如果未安装）

```bash
# macOS/Linux
curl -LsSf https://astral.sh/uv/install.sh | sh

# 或使用 pip
pip install uv
```

### 步骤 2: 克隆项目

```bash
# 克隆项目
git clone https://github.com/hoastyle/feishu-doc-tools.git
cd feishu-doc-tools
```

### 步骤 3: 使用 uv 安装依赖

**现代 lockfile 工作流**（推荐）:

```bash
# 使用 uv sync 自动管理依赖
# uv 会自动创建虚拟环境并安装依赖
uv sync
```

如果你有 `uv.lock` 文件，uv 会使用它来确保可重现的安装。如果没有，uv 会自动生成。

### 步骤 4: 配置环境变量

```bash
# 复制配置模板
cp .env.example .env

# 编辑配置文件
nano .env  # 或使用 vim、code 等
```

**在 .env 文件中填写**:

```bash
# 必填项 - 从飞书管理员获取
FEISHU_APP_ID=cli_a9e09cc76d345bb4
FEISHU_APP_SECRET=你的应用密钥

# 认证模式 - 使用用户认证
FEISHU_AUTH_MODE=user

# 必填 - 用户认证刷新令牌（步骤 5 会自动填充）
FEISHU_USER_REFRESH_TOKEN=

# 可选 - 默认文件夹（如果需要）
FEISHU_DEFAULT_FOLDER=fldcnxxxxx
```

保存并退出: `Ctrl+X`，然后 `Y`，然后 `Enter`

### 步骤 5: 配置用户认证

**重要**: 首次使用需要完成 OAuth 授权

#### 5.1 配置重定向 URI（飞书开放平台）

1. 访问: https://open.feishu.cn/app
2. 选择你的应用
3. 点击 **"开发配置"** → **"安全设置"** → **"重定向 URL"**
4. 添加: `http://localhost:3333/callback`
5. 点击 **"保存"**

⚠️ **注意**:
- 没有尾部斜杠: `http://localhost:3333/callback/` ❌
- 协议正确: `https://localhost:3333/callback` ❌
- 端口正确: 3333

#### 5.2 运行 OAuth 设置脚本

```bash
# 使用 uv run 运行脚本（推荐）
# 无需手动激活虚拟环境，uv 会自动处理
uv run python scripts/setup_user_auth.py
```

#### 5.3 完成授权

1. 脚本会生成一个授权 URL
2. 复制 URL 到浏览器打开
3. 登录飞书账号
4. 授权应用
5. 浏览器会跳转到 `http://localhost:3333/callback?code=xxx&state=yyy`
   - ⚠️ **如果看到"验证失败"页面，没关系！**
   - 只要 URL 中包含 `code=xxx` 参数即可
   - 继续下一步
6. 复制完整的 `code` 参数值（包括 `code=` 部分）
7. 回到终端，粘贴授权码
8. 脚本会自动完成剩余配置并更新 `.env` 文件

**预期输出**:
```
✓ User authentication configured successfully
✓ Refresh token saved to .env file
✓ You can now use feishu-doc-tools with your personal permissions
```

### 步骤 6: 测试连接

```bash
# 使用 uv run 运行测试脚本
uv run python scripts/test_api_connectivity.py
```

**成功输出**:
```
✓ Authentication successful
✓ Block format conversion successful
```

**完成！** 现在你可以使用 feishu-doc-tools 了。

---

## 3. 部署 Feishu-MCP

### 步骤 1: 克隆项目

```bash
# 克隆项目
git clone https://github.com/cso1z/Feishu-MCP.git
cd Feishu-MCP
```

### 步骤 2: 配置环境变量

```bash
# 复制配置模板
cp .env.example .env

# 编辑配置文件
nano .env
```

**在 .env 中填写**:

```bash
# 必填 - 从飞书管理员获取（与 feishu-doc-tools 相同）
FEISHU_APP_ID=cli_a9e09cc76d345bb4
FEISHU_APP_SECRET=你的应用密钥

# 认证类型 - 使用用户认证
FEISHU_AUTH_TYPE=user

# User Refresh Token（User 模式必需）
FEISHU_USER_REFRESH_TOKEN=你的刷新令牌

# 服务端口
PORT=3333

# 可选 - 日志级别
LOG_LEVEL=info
```

### 步骤 3: 获取 User Refresh Token

**方法 1**: 复制 feishu-doc-tools 的令牌（推荐）

```bash
# 从 feishu-doc-tools 的 .env 文件中复制
cat ../feishu-doc-tools/.env | grep FEISHU_USER_REFRESH_TOKEN

# 将值复制到 Feishu-MCP 的 .env 文件
```

**方法 2**: 重新运行 OAuth（如果令牌过期）

```bash
cd ../feishu-doc-tools
uv run python scripts/setup_user_auth.py

# 复制生成的 refresh token 到 Feishu-MCP 的 .env
```

### 步骤 4: 启动服务

```bash
# 启动服务
docker compose up -d

# 查看日志
docker compose logs -f

# 按 Ctrl+C 退出日志查看
```

**预期日志输出**:
```
feishu-mcp-1  | INFO:     Started server process [1]
feishu-mcp-1  | INFO:     Waiting for application startup.
feishu-mcp-1  | INFO:     Application startup complete.
feishu-mcp-1  | INFO:     Uvicorn running on http://0.0.0.0:3333
```

### 步骤 5: 验证服务

```bash
# 健康检查
curl http://localhost:3333/mcp

# 预期输出: MCP 服务器信息
```

**完成！** Feishu-MCP 服务已启动。

---

## 4. 激活 MCP 服务

### 在 Claude Code 中使用（User 模式）

**重要**: User 模式下需要 `userKey` 参数用于会话隔离

#### 方式 1: 命令行添加（推荐）

```bash
claude mcp add --transport http feishu-user \
  http://localhost:3333/mcp?userKey=your_email@company.com \
  --env FEISHU_APP_ID=cli_xxxxx \
  --env FEISHU_APP_SECRET=xxxxx \
  --env FEISHU_AUTH_TYPE=user \
  --env FEISHU_USER_REFRESH_TOKEN=xxxxx
```

#### 方式 2: 手动编辑 JSON

**项目级配置** (推荐):

```bash
# 在项目根目录创建 .mcp.json
nano .mcp.json
```

**用户级配置**:

```bash
# 在用户主目录创建 .claude.json
nano ~/.claude.json
```

**配置内容**:

```json
{
  "mcpServers": {
    "feishu-user": {
      "type": "http",
      "url": "http://localhost:3333/mcp?userKey=your_email@company.com",
      "env": {
        "FEISHU_APP_ID": "cli_a9e09cc76d345bb4",
        "FEISHU_APP_SECRET": "你的应用密钥",
        "FEISHU_AUTH_TYPE": "user",
        "FEISHU_USER_REFRESH_TOKEN": "你的刷新令牌"
      }
    }
  }
}
```

### 🔑 userKey 的重要性

**User 模式下为什么需要 userKey？**

| 原因 | 说明 |
|------|------|
| 会话隔离 | 区分不同用户的 MCP 连接 |
| Token 管理 | 每个用户有独立的 refresh_token |
| 权限隔离 | 确保操作以正确用户身份执行 |
| 并发支持 | 多用户同时使用时不会混乱 |

**userKey 的推荐格式**:

```bash
# 推荐 1：使用飞书邮箱（最推荐）
userKey=zhangsan@company.com

# 推荐 2：使用员工 ID
userKey=emp001

# 推荐 3：使用 Open ID
userKey=ou_xxxxx

# ❌ 不推荐：使用随机字符串（难以识别）
userKey=a1b2c3d4
```

### ⚠️ User 模式的注意事项

1. **userKey 必须唯一**

   | 场景 | userKey 示例 |
   |------|-------------|
   | 单人使用 | userKey=my@email.com |
   | 多人共享（不推荐） | 每人使用不同的 userKey |
   | 团队协作 | 每人使用自己的邮箱 |

2. **Refresh Token 会过期**

   Refresh Token 有效期：约 30 天

   自动刷新机制：
   - ✅ Feishu-MCP 会自动刷新 access_token
   - ⚠️ 但 refresh_token 本身也会过期，需要重新授权

   如何重新授权：
   ```bash
   cd feishu-doc-tools
   uv run python scripts/setup_user_auth.py
   ```

3. **权限配置**

   User 模式需要额外的权限：
   - 文档访问权限（用户个人文档）
   - Wiki 知识库权限
   - 文件夹权限

### 📊 Tenant vs User 模式对比（Claude Code）

| 特性 | Tenant 模式 | User 模式 |
|------|-----------|----------|
| 身份 | 应用（bot） | 用户（个人） |
| userKey | ❌ 不需要 | ✅ 必须 |
| App Secret | ✅ 需要 | ✅ 需要 |
| Refresh Token | ❌ 不需要 | ✅ 需要 |
| OAuth 授权 | ❌ 不需要 | ✅ 一次性 |
| 权限范围 | 应用权限 | 用户权限（更大） |
| 文档所有权 | 归应用所有 | 归用户所有 |
| 推荐场景 | 自动化操作 | 个人文档管理 |

### ✅ 验证 User 模式配置

```bash
# 1. 检查 MCP 服务器状态
claude mcp get feishu-user

# 2. 在 Claude Code 中测试
# 输入：请列出我的飞书文档

# 3. 检查是否以用户身份运行
# 创建的文档应该显示为您（用户）是所有者
```

---

## 5. 使用方法

### feishu-doc-tools 常用命令

**使用 `uv run` 运行所有脚本**（无需激活虚拟环境）:

#### 上传单个文档

```bash
cd feishu-doc-tools

# 上传 README.md 到飞书文档
uv run python scripts/create_feishu_doc.py README.md --title "项目说明文档"

# 预期输出:
# ✓ Document created successfully
# Document URL: https://xxx.feishu.cn/docx/doxcnxxxxx
```

#### 批量上传文件夹

```bash
# 上传整个 docs 文件夹
uv run python scripts/batch_create_docs.py ./docs --folder 你的文件夹ID

# 预期输出:
# Processing: 50 documents
# ✓ Uploaded: 50/50 documents in 2m 15s
```

#### 下载文档

```bash
# 下载单个文档（推荐方式）
uv run python scripts/download_doc.py \
  --space-name "你的空间名" \
  --doc-name "文档标题" \
  -o output.md

# 或使用文档 ID
uv run python scripts/download_doc.py \
  --doc-id "doxcnxxxxx" \
  -o output.md
```

#### 备份 Wiki 空间

```bash
# 备份整个 Wiki 空间
uv run python scripts/download_wiki.py \
  --space-name "Wiki名称" \
  --output ./backup

# 预期输出:
# ✓ Downloaded 73 nodes, 156 images (45.2 MB) in 2m 15s
```

#### 预览 Wiki 结构

```bash
# 查看 Wiki 树形结构
uv run python scripts/list_wiki_tree.py --space-name "Wiki名称"

# 预期输出:
# Wiki: 技术文档
# ├── 后端开发
# │   ├── API 设计
# │   └── 数据库设计
# └── 前端开发
#     ├── React 组件
#     └── 状态管理
```

### Feishu-MCP 使用示例

在 Claude Code 对话中:

#### 创建新文档

```
请在飞书中创建一个新文档，标题是"会议记录 - 2026-01-19"
内容包括:
- 参会人员: 张三、李四、王五
- 会议主题: 项目进度同步
- 决议事项: 1. xxx 2. xxx
```

#### 优化现有文档

```
请优化这个飞书文档的格式:
https://xxx.feishu.cn/docx/doxcnxxxxx

具体需求:
1. 统一标题层级
2. 添加代码高亮
3. 优化表格格式
```

#### 批量编辑

```
请在这个文档的所有代码块中添加语法高亮:
https://xxx.feishu.cn/docx/doxcnxxxxx
```

#### 创建 Wiki 节点

```
请在"技术文档" Wiki 空间创建一个新节点:
- 父节点: "后端开发"
- 节点标题: "微服务架构设计"
- 内容: [粘贴你的内容]
```

#### 生成文档摘要

```
请为这个文档生成 200 字的摘要:
https://xxx.feishu.cn/docx/doxcnxxxxx
```

---

## 6. 常见问题

### 问题 1: uv 安装失败

**错误信息**:
```
Error: uv command not found
```

**解决方案**:

```bash
# 使用官方安装脚本
curl -LsSf https://astral.sh/uv/install.sh | sh

# 重新加载 shell 配置
source ~/.bashrc  # 或 source ~/.zshrc

# 验证安装
uv --version
```

---

### 问题 2: uv sync 失败

**错误信息**:
```
Error: No lockfile found, uv.lock will be created
```

**解决方案**:

这是正常提示，uv 会自动创建 `uv.lock` 文件。

```bash
# 继续等待 uv 完成依赖安装
# 首次运行可能需要 1-2 分钟
```

---

### 问题 3: OAuth 授权失败

**错误信息**:
```
错误码: 20029 - redirect_uri 请求不合法
```

**解决方案**:

1. 检查重定向 URI 配置
   - 访问: https://open.feishu.cn/app
   - 选择你的应用
   - 开发配置 → 安全设置 → 重定向 URL
   - 确保是: `http://localhost:3333/callback`
   - ⚠️ 注意:
     - 没有尾部斜杠
     - 使用 `http` 不是 `https`
     - 端口是 `3333`

2. 删除并重新添加重定向 URI
   - 有时候重新添加可以解决问题

**重要**: 如果看到"验证失败"页面，没关系！只要 URL 中包含 `code=xxx` 参数即可继续。

---

### 问题 4: Refresh Token 过期

**错误信息**:
```
AuthenticationError: Invalid refresh token
```

**解决方案**:

```bash
cd feishu-doc-tools

# 重新运行 OAuth 设置
uv run python scripts/setup_user_auth.py

# 完成授权后，新的 refresh token 会自动保存到 .env

# 复制新的 token 到 Feishu-MCP 的 .env
```

**注意**: Refresh token 有效期 30 天，过期后需要重新授权。

---

### 问题 5: Feishu-MCP 服务无法启动

**错误信息**:
```
Error: Port 3333 already in use
```

**解决方案**:

```bash
# 查看占用端口的进程
lsof -i :3333

# 或
netstat -tlnp | grep 3333
```

**方案 1**: 杀掉占用进程
```bash
kill -9 [进程ID]
docker compose up -d
```

**方案 2**: 更换端口
```bash
nano .env
# 修改 PORT=3334
docker compose up -d
```

---

### 问题 6: MCP 服务激活失败

**现象**: Claude Code 中无法使用 Feishu MCP

**解决方案**:

1. **检查服务状态**
   ```bash
   curl http://localhost:3333/mcp
   ```

2. **检查配置格式**
   ```json
   {
     "mcpServers": {
       "feishu-user": {
         "type": "http",
         "url": "http://localhost:3333/mcp?userKey=your_email@company.com",
         "env": {
           "FEISHU_APP_ID": "cli_xxxxx",
           "FEISHU_APP_SECRET": "xxxxx",
           "FEISHU_AUTH_TYPE": "user",
           "FEISHU_USER_REFRESH_TOKEN": "xxxxx"
         }
       }
     }
   }
   ```
   
   ⚠️ **注意**:
   - 使用 `type: "http"` 而不是仅 `url`
   - URL 中必须包含 `userKey` 参数
   - `userKey` 必须唯一

3. **重启 Claude Code**
   - 完全退出 Claude Code
   - 重新打开

4. **查看 MCP 日志**
   ```bash
   cd Feishu-MCP
   docker compose logs -f
   ```

---

### 问题 7: 文档下载失败

**错误信息**:
```
DocumentNotFoundError: Document not found
```

**解决方案**:

1. **验证文档 URL 正确**
   ```bash
   # 使用正确的参数
   uv run python scripts/download_doc.py \
     --space-name "你的空间名" \
     --doc-name "文档标题" \
     -o output.md
   ```

2. **验证访问权限**
   - 确保你有该文档的访问权限
   - User 模式使用你个人的权限

---

### 问题 8: Wiki 操作失败

**错误信息**:
```
PermissionError: Insufficient permissions
```

**解决方案**:

1. **确认你有 Wiki 访问权限**
   - 在飞书中检查是否能访问该 Wiki 空间

2. **使用正确的 space-name**
   ```bash
   # 列出你可访问的 Wiki 空间
   uv run python scripts/list_wiki_tree.py --list-spaces
   ```

---

## 7. 快速测试命令

### 测试 feishu-doc-tools

```bash
cd feishu-doc-tools

# 测试连接
uv run python scripts/test_api_connectivity.py

# 创建测试文档
echo "# 测试文档" > test.md
uv run python scripts/create_feishu_doc.py test.md --title "测试文档"

# 下载测试
uv run python scripts/download_doc.py --doc-id "doxcnxxxxx" -o test_output.md
```

### 测试 Feishu-MCP

```bash
cd Feishu-MCP

# 健康检查
curl http://localhost:3333/mcp

# 查看日志
docker compose logs -f

# 重启服务
docker compose restart
```

### 测试 MCP 集成

在 Claude Code 中:

```
请帮我列出最近的 5 个飞书文档
```

如果看到文档列表，说明集成成功。

---

## 8. 下一步

### 学习资源

1. **feishu-doc-tools 完整文档**:
   - 项目 GitHub: https://github.com/hoastyle/feishu-doc-tools
   - 用户认证指南: `docs/user/USER_AUTH_GUIDE.md`
   - 故障排查: `docs/user/TROUBLESHOOTING.md`

2. **Feishu-MCP 完整文档**:
   - 项目 GitHub: https://github.com/cso1z/Feishu-MCP
   - 运维指南: `OPERATIONS.md`

3. **本项目 Skills**:
   - `skills/feishu-doc-sync/SKILL.md` - 文档同步
   - `skills/feishu-wiki-manager/SKILL.md` - Wiki 管理
   - `skills/feishu-ai-editor/SKILL.md` - AI 编辑
   - `skills/feishu-workflow-automation/SKILL.md` - 自动化

### 进阶使用

- [ ] 配置 CI/CD 自动上传文档
- [ ] 设置定期 Wiki 备份
- [ ] 集成到现有开发流程
- [ ] 使用 AI 辅助优化文档格式

---

## 9. 获取帮助

### 诊断工具

```bash
# feishu-doc-tools 诊断
cd feishu-doc-tools
uv run python scripts/diagnose_auth_flow.py
uv run python scripts/diagnose_app_status.py
uv run python scripts/test_api_connectivity.py

# Feishu-MCP 日志
cd Feishu-MCP
docker compose logs
```

### 社区支持

- 提 Issue 到 GitHub 仓库
- 联系飞书应用管理员
- 参考项目文档的"故障排查"章节

---

## 🎉 恭喜！

如果你成功运行了测试命令并看到成功提示，说明你已经完成了部署！

现在可以:
- ✅ 使用 feishu-doc-tools 批量上传/下载文档
- ✅ 在 Claude Code 中 AI 辅助编辑飞书文档
- ✅ 备份和管理 Wiki 空间
- ✅ 集成到自动化流程

**下一步**: 根据你的具体需求，开始使用飞书文档工具！

---

**最后更新**: 2026-01-19  
**版本**: v3.0 - 研发部专用版本（优化 lockfile 工作流）  
**配套项目**: feishu-playbook Phase 1.5 Complete
