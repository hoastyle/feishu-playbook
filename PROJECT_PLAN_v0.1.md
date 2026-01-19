# feishu-playbook 项目初始化计划

## 📋 项目概述

**项目名称**: feishu-playbook
**项目定位**: 研发团队的文档自动化平台 + AI Skills 库
**核心价值**:
1. 降低文档构建和整理成本
2. 降低团队间信息差
3. 文档规范化、标准化
4. **AI Skills 标准化模块，提升使用率**

**目标用户**: 研发团队（开发者、技术文档编写者）

## 🎯 核心目标

### 1. 文档构建更简单、成本更低
- 提供标准化模板和脚手架
- AI 辅助生成文档内容
- 一键上传到飞书指定位置

### 2. 文档构建更完整、更规范
- **利用大模型能力**生成高质量文档
- **AI Skills 标准化模块**确保文档格式统一
- 自动检查文档完整性

### 3. 流程自动化、规范化
- **代码更新 → 文档更新 → 自动上传**的完整链路
- CI/CD 集成能力
- 团队协作标准化

### 4. AI Skills 核心价值（重要！）
- **标准化、规范化使用**：降低学习成本
- **提升使用率**：让 AI Agent 快速掌握核心功能
- **支持日常研发场景**：本地生成文档 → 对话上传
- **可以单独存在**：作为独立的 Skills 库供 AI 使用

### 5. 与现有工具集成（重要！）
- **API 文档生成工具**: Swagger/OpenAPI → Skills 集成
- **代码分析工具**: 自动提取代码注释 → 生成文档
- **Markdown 工具**: 已有文档 → 飞书格式转换
- **CI/CD 平台**: GitHub Actions, GitLab CI, Jenkins 等

### 6. 批量操作支持（重要！）
- **批量上传**: 一次对话上传多个文档
- **批量迁移**: 整个文件夹的迁移
- **批量更新**: 统一更新多个文档的某个部分
- **批量检查**: 检查多个文档的完整性

### 7. 团队协作模式（混合模式）
- **集中式场景**: 团队共用空间，统一文件夹结构
- **分布式场景**: 各团队独立空间，统一操作方式
- **灵活切换**: 根据 Project 配置自动选择模式

## 🔍 官方 Skills 标准（重要）⭐

### 什么是 Skills？

**定义**: Skills 是包含指令、脚本和资源的文件夹，Claude 动态加载它们来提高特定任务的性能。

**核心价值**:
- 教导 Claude 以可重复的方式完成特定任务
- 提供标准化的操作流程
- 支持自定义和扩展

### 官方 Skills 标准结构

```
skills/
└── skill-name/
    ├── SKILL.md           # 主文件（必需），全大写
    ├── examples/          # 示例目录（可选）
    ├── scripts/           # 脚本目录（可选）
    ├── reference/         # 参考文档（可选）
    └── templates/         # 模板目录（可选）
```

**关键特征**:
- ✅ SKILL.md 主文件（全大写命名，必需）
- ✅ YAML frontmatter（name, description）
- ✅ 可选的辅助目录（examples/, scripts/, reference/ 等）
- ✅ 灵活的结构设计

### YAML Frontmatter 规范（必需）

```yaml
---
name: skill-name
description: Clear description of what this skill does and when to use it
license: Optional (if applicable)
---
```

**必需字段**:
- `name`: 唯一标识符（小写，连字符）
- `description`: 完整描述和触发条件

**可选字段**:
- `license`: 许可证信息

### 内容章节标准

```markdown
# Skill Name

## Overview
[简要说明技能的用途]

## Quick Start
[快速开始示例]

## Common Scenarios
[常见场景，5-10 个]

## Best Practices
[最佳实践和注意事项]

## Troubleshooting
[常见错误和解决方案]
```

### 设计原则

1. **自描述性**: AI 可以直接读取和理解
2. **标准化**: 统一的参数命名和返回格式
3. **实用性**: 包含可运行的示例
4. **可组合**: Skills 可以相互引用
5. **上下文感知**: 根据用户输入决定激活

## 🔍 当前计划分析与优化

### 关键差异对比

| 方面 | 官方标准 | 当前计划 | 优化方案 |
|------|---------|---------|---------|
| **主文件** | SKILL.md（大写） | skill.md（小写） | ✅ 使用 SKILL.md |
| **Frontmatter** | YAML (name, description) | 缺失 | ✅ 添加标准 frontmatter |
| **辅助目录** | examples/, scripts/, reference/（可选） | 平铺的 .md 文件 | ✅ 使用标准目录名 |
| **触发机制** | description 中定义 | 不明确 | ✅ 明确触发条件 |

### 标准 Skill 结构示例

```
skills/feishu-upload/
├── SKILL.md                 # 主文件（必需）
│   ├── YAML frontmatter
│   │   ├── name: feishu-upload
│   │   └── description: Upload markdown documents to Feishu...
│   └── 核心内容
│       ├── Overview
│       ├── Quick Start
│       ├── Common Scenarios
│       ├── Best Practices
│       └── Troubleshooting
├── examples/                # 示例目录（可选）
│   ├── single-upload.md
│   └── batch-upload.md
├── scripts/                 # 脚本目录（可选）
└── reference/               # 参考文档（可选）
    ├── best-practices.md
    └── batch-operations.md
```

### YAML Frontmatter 模板

**feishu-upload/SKILL.md**:
```yaml
---
name: feishu-upload
description: Upload markdown documents to Feishu. Use when user wants to upload, create, publish, or sync documents to Feishu. Supports both single file and batch upload with automatic parallel processing.
---

# Feishu Upload Skill
...
```

**feishu-migration/SKILL.md**:
```yaml
---
name: feishu-migration
description: Batch migrate markdown documents to Feishu. Use when user wants to migrate entire folders, batch upload multiple files, or synchronize local documents with Feishu. Uses feishu-doc-tools for high-performance parallel processing.
---
```

**feishu-wiki/SKILL.md**:
```yaml
---
name: feishu-wiki
description: Manage Feishu Wiki knowledge base. Use when user wants to create Wiki nodes, organize Wiki structure, batch upload to Wiki, or maintain Wiki documentation. Integrates both feishu-doc-tools for creation and Feishu-MCP for editing.
---
```

## 📁 优化后的项目结构

```
feishu-playbook/
├── README.md                    # 项目概述和快速开始
├── skills/                      # AI Skills 模块（核心！）⭐
│   ├── feishu-upload/          # 飞书上传 Skills
│   │   ├── SKILL.md            # 主文件（必需）
│   │   ├── examples/           # 示例目录（可选）
│   │   ├── scripts/            # 脚本目录（可选）
│   │   └── reference/          # 参考文档（可选）
│   ├── feishu-migration/       # 飞书迁移 Skills
│   │   ├── SKILL.md            # 主文件
│   │   └── examples/           # 示例目录
│   ├── feishu-wiki/            # Wiki 管理 Skills
│   │   ├── SKILL.md            # 主文件
│   │   └── reference/          # 参考文档
│   ├── feishu-ai-edit/         # AI 辅助编辑 Skills
│   │   ├── SKILL.md            # 主文件
│   │   └── examples/           # 示例目录
│   └── integrations/           # 工具集成 Skills ⭐
│       ├── swagger-docs/       # Swagger/OpenAPI 集成
│       ├── code-analysis/      # 代码分析工具集成
│       └── markdown-tools/     # Markdown 工具集成
├── workflows/                   # 工作流脚本
│   ├── migrate-and-optimize.sh
│   ├── backup-wiki.sh
│   ├── sync-docs.sh
│   └── ci-integration/         # CI/CD 集成 ⭐
├── config/                      # 配置文件 ⭐
│   ├── project-config.yaml
│   ├── team-config.yaml
│   └── integration-config.yaml
├── docs/                        # 文档目录
│   ├── playbooks/
│   ├── guides/
│   └── troubleshooting/
└── examples/                    # 示例和模板
    ├── ci-templates/           # CI/CD 模板 ⭐
    └── config-templates/
```

**核心目录说明**：
- `skills/` - AI Skills 定义，每个包含 SKILL.md 主文件（必需）
  - 可选目录：examples/, scripts/, reference/, templates/
  - `integrations/` - 与现有工具的集成 Skills
- `workflows/` - 自动化脚本，支持日常研发场景
- `config/` - 配置文件，支持混合协作模式
- `examples/ci-templates/` - CI/CD 配置模板

## 🚀 实现阶段

### Phase 1: AI Skills 核心模块（优先级：最高）⭐

**目标**: 让 AI Agent（Claude/Cursor/Windsurf）快速掌握飞书文档操作能力

**文件清单**:
1. **skills/feishu-upload/SKILL.md** ⭐
   - YAML frontmatter（name, description）
   - 核心内容：Overview, Quick Start, Common Scenarios, Best Practices, Troubleshooting

2. **skills/feishu-upload/examples/**（可选）
   - `single-upload.md` - 单文件上传示例
   - `batch-upload.md` - 批量上传示例

3. **skills/feishu-upload/reference/**（可选）
   - `best-practices.md` - 最佳实践和注意事项
   - `batch-operations.md` - 批量操作专题

4. **skills/feishu-migration/SKILL.md**（同样结构）
5. **skills/feishu-wiki/SKILL.md**（同样结构）
6. **skills/feishu-ai-edit/SKILL.md**（同样结构）

**核心设计原则**:
- ✅ **自描述**: AI 可以直接读取和理解
- ✅ **标准化**: 统一的参数命名和返回格式
- ✅ **示例驱动**: 丰富的对话示例
- ✅ **可组合**: 多个 Skills 可以组合使用

**验证标准**:
- [ ] 每个 Skill 都有 SKILL.md 主文件（大写）
- [ ] SKILL.md 包含 YAML frontmatter（name, description）
- [ ] 示例覆盖 80% 的常见场景
- [ ] AI 能够读取并理解如何使用
- [ ] 支持 Claude/Cursor/Windsurf 等工具

### Phase 2: 工作流脚本（优先级：高）

**目标**: 支持日常研发场景的自动化脚本

**文件清单**:
1. **workflows/migrate-and-optimize.sh**
   - 批量迁移 Markdown 文档到飞书
   - 调用 feishu-doc-tools 进行上传
   - 可选：调用 Feishu-MCP 进行 AI 优化

2. **workflows/backup-wiki.sh**
   - 批量下载 Wiki 文档
   - 保存到本地备份目录
   - 支持增量备份

3. **workflows/sync-docs.sh**
   - 双向同步本地和飞书文档
   - 智能冲突检测和合并

**验证标准**:
- [ ] 脚本可执行，有完整的错误处理
- [ ] 支持参数配置（目标位置、文件路径等）
- [ ] 操作手册清晰易懂

### Phase 3: CI/CD 集成（优先级：高）

**目标**: 实现"代码更新 → 文档更新 → 自动上传"的自动化链路

**文件清单**:
1. **workflows/ci-integration/git-push-hook.sh**
   - Git push 钩子脚本
   - 检测代码变更
   - 触发文档生成和上传

2. **workflows/ci-integration/auto-upload.sh**
   - 自动上传生成的文档
   - 支持多种文档类型（API 文档、README 等）

3. **examples/ci-templates/github-actions.yml**
   - GitHub Actions 配置模板
   - GitLab CI 配置模板

**验证标准**:
- [ ] Git push 自动触发文档更新和上传
- [ ] CI/CD pipeline 成功上传到飞书
- [ ] 支持主流 CI/CD 平台

### Phase 4: Docker Compose 部署（优先级：中）⚠️

**目标**: 一键部署环境

**文件清单**:
1. **docker-compose.yml** - 同时启动 Feishu-MCP 和 feishu-doc-tools
2. **docs/guides/deployment.md** - 部署指南

**验证标准**:
- [ ] `docker-compose up -d` 成功启动
- [ ] 健康检查通过

### Phase 5: 文档和最佳实践（优先级：中）

**文件清单**:
1. **docs/guides/skills-usage.md** - Skills 使用指南（核心文档）
2. **docs/guides/architecture.md** - 架构说明
3. **docs/guides/comparison.md** - 工具对比
4. **docs/troubleshooting/common-errors.md** - 故障排查

**验证标准**:
- [ ] 文档覆盖主要场景
- [ ] 包含完整示例

## 🔧 关键技术决策

### 1. 批量操作设计（核心！）⭐

**批量操作模式**:

1. **批量上传**:
   ```
   输入：文件夹路径或文件列表
   处理：并行上传（5-10 workers）
   输出：上传结果汇总（成功/失败统计）
   ```

2. **批量迁移**:
   ```
   输入：源文件夹 + 目标位置
   处理：
     - 遍历源文件夹
     - 过滤文件类型（.md, .txt）
     - 并行上传
   输出：迁移报告（URL 映射表）
   ```

### 2. CI/CD 全自动链路设计（核心！）⭐

**完整流程**:
```
Git Push → 触发 CI Pipeline → 文档生成 → 飞书上传 → 通知
```

**配置文件示例**:
```yaml
# config/project-config.yaml
project:
  name: "我的项目"
  collaboration_mode: "centralized"  # or "distributed"

feishu:
  space_id: "123456"
  folder_token: "abc123"
  wiki_space_id: "789012"

automation:
  auto_upload: true
  ai_optimize: true
  notify_on_success: true

integrations:
  swagger:
    enabled: true
    source: "api/openapi.yaml"
    target: "API 文档"
```

### 3. 混合协作模式设计

**集中式模式**:
```yaml
collaboration_mode: "centralized"
feishu:
  space_id: "团队共享空间"
  folder_structure: "统一规范"
```

**分布式模式**:
```yaml
collaboration_mode: "distributed"
teams:
  frontend:
    space_id: "前端团队空间"
  backend:
    space_id: "后端团队空间"
```

## 📝 实现清单

### Phase 1 - AI Skills 核心模块（最高优先级）⭐

**feishu-upload Skill**:
1. `skills/feishu-upload/SKILL.md` - 主文件（必需）⭐
   - YAML frontmatter (name, description)
   - 核心内容：Overview, Quick Start, Common Scenarios, Best Practices, Troubleshooting
2. `skills/feishu-upload/examples/` - 示例目录（可选）
   - `single-upload.md` - 单文件上传示例
   - `batch-upload.md` - 批量上传示例
3. `skills/feishu-upload/reference/` - 参考文档（可选）
   - `best-practices.md` - 最佳实践
   - `batch-operations.md` - 批量操作专题

**feishu-migration Skill**:
2. `skills/feishu-migration/SKILL.md` - 主文件（必需）
3. `skills/feishu-migration/examples/` - 示例目录（可选）

**feishu-wiki Skill**:
4. `skills/feishu-wiki/SKILL.md` - 主文件（必需）
5. `skills/feishu-wiki/reference/` - 参考文档（可选）

**feishu-ai-edit Skill**:
6. `skills/feishu-ai-edit/SKILL.md` - 主文件（必需）
7. `skills/feishu-ai-edit/examples/` - 示例目录（可选）

**Skills 使用指南**:
8. `docs/guides/skills-usage.md` - 如何使用 Skills（核心文档）

**工具集成 Skills**（新增）⭐:
9. `skills/integrations/swagger-docs/SKILL.md` - OpenAPI 集成（主文件）
10. `skills/integrations/code-analysis/SKILL.md` - 代码分析集成（主文件）
11. `skills/integrations/markdown-tools/SKILL.md` - Markdown 工具集成（主文件）

### Phase 2 - 工作流脚本（高优先级）

**基础脚本**:
1. `workflows/migrate-and-optimize.sh`
2. `workflows/backup-wiki.sh`
3. `workflows/sync-docs.sh`

**操作手册**:
4. `docs/playbooks/batch-migration.md`
5. `docs/playbooks/wiki-management.md`
6. `docs/playbooks/ai-editing.md`

### Phase 3 - CI/CD 集成（高优先级）

**CI/CD 脚本**:
1. `workflows/ci-integration/git-push-hook.sh` - Git push 钩子
2. `workflows/ci-integration/auto-doc-gen.sh` - 自动文档生成 ⭐
3. `workflows/ci-integration/auto-upload.sh` - 自动上传脚本
4. `workflows/ci-integration/notify.sh` - 结果通知脚本 ⭐

**配置模板**:
5. `examples/ci-templates/github-actions.yml` - GitHub Actions ⭐
6. `examples/ci-templates/gitlab-ci.yml` - GitLab CI ⭐
7. `examples/ci-templates/jenkinsfile` - Jenkins ⭐

**配置文件**（新增）⭐:
8. `config/project-config.yaml` - 项目配置模板
9. `config/team-config.yaml` - 团队配置模板
10. `config/integration-config.yaml` - 工具集成配置

**操作手册**:
11. `docs/playbooks/ci-automation.md` - CI/CD 自动化手册 ⭐
12. `docs/guides/batch-operations.md` - 批量操作指南 ⭐

### Phase 4 - Docker Compose（中优先级）⚠️

1. `docker-compose.yml`
2. `.env.example`
3. `docs/guides/deployment.md`

### Phase 5 - 文档完善（中优先级）

1. `README.md` - 项目概述
2. `docs/guides/architecture.md` - 架构说明
3. `docs/guides/comparison.md` - 工具对比
4. `docs/troubleshooting/common-errors.md` - 故障排查

### Serena 项目初始化

**语言类型**: Markdown
**项目类型**: 知识库 + AI Skills 库 + 自动化工具集

## ✅ 验证计划

### Phase 1 验证（AI Skills 核心）⭐
- [ ] 每个 Skill 都有 SKILL.md 主文件（大写命名）
- [ ] SKILL.md 包含标准 YAML frontmatter（name, description）
- [ ] 示例文档包含 10+ 对话场景（含批量操作）⭐
- [ ] AI 能够读取 SKILL.md 并理解如何使用
- [ ] 支持 Claude/Cursor/Windsurf 等工具
- [ ] 可选目录结构规范（examples/, scripts/, reference/）
- [ ] 工具集成 Skills 可用（Swagger、代码分析）⭐

### Phase 2 验证（工作流脚本）
- [ ] 脚本可执行，有错误处理
- [ ] 支持参数配置
- [ ] 操作手册清晰易懂

### Phase 3 验证（CI/CD 集成）
- [ ] Git push 自动触发文档生成和上传 ⭐
- [ ] CI/CD pipeline 成功上传到飞书
- [ ] 配置文件支持集中式和分布式模式 ⭐
- [ ] 支持主流 CI/CD 平台（GitHub Actions, GitLab CI, Jenkins）⭐
- [ ] 批量操作在 CI/CD 环境中正常工作 ⭐

### Phase 4 验证（Docker Compose）
- [ ] docker-compose up -d 成功启动
- [ ] 两个服务健康检查通过

### Phase 5 验证（文档完善）
- [ ] 文档覆盖主要场景
- [ ] 包含完整示例
- [ ] README 内容完整
- [ ] .env.example 格式正确
- [ ] 文档结构清晰

## 🎯 成功标准

### 核心成功指标
1. **AI 能够快速上手**: AI Agent 读取 Skills 后能立即执行飞书文档操作
2. **日常研发效率提升**: 开发者通过对话即可完成文档上传
3. **文档构建成本降低**: 从代码到文档到飞书的自动化链路
4. **团队协作标准化**: 统一的文档规范和流程

### 具体验证标准
1. **新用户**可以在 5 分钟内通过对话上传第一个文档
2. **常用场景**有对应的 Skill 支持（上传、迁移、Wiki、编辑）
3. **批量操作**可以在一次对话中处理多个文档 ⭐
4. **CI/CD 集成**能够全自动同步文档到飞书 ⭐
5. **工具集成**支持 Swagger/OpenAPI、代码分析等 ⭐
6. **项目结构**清晰，易于扩展新的 Skills
7. **混合协作模式**支持集中式和分布式场景 ⭐

## 📊 参考资料

- Feishu-MCP 项目: `/home/howie/Software/utility/Reference/Feishu-MCP`
- feishu-doc-tools 项目: `/home/howie/Software/utility/Reference/feishu-doc-tools`
- 官方 Skills 库: `/home/howie/Software/utility/Reference/skills`
- 官方文档: https://support.claude.com/en/articles/12512198-creating-custom-skills

---

**最后更新**: 2026-01-18
**状态**: ✅ 已根据官方 Skills 标准优化
