# feishu-playbook 项目计划 v0.2

**基于参考项目最新进展优化**

## 📋 版本历史

### v0.2 (2026-01-19) - 参考项目最新进展集成 ⭐

**重大更新**:
- ✅ 重新设计4个核心Skills架构（场景驱动）
- ✅ 集成feishu-doc-tools v0.2.1的下载功能
- ✅ 增加Wiki结构预览和备份能力
- ✅ 强调性能优化（5-10x加速，90%效率提升）
- ✅ 明确工具选择策略（feishu-doc-tools vs Feishu-MCP）

**Skills架构调整**:
- feishu-upload + feishu-migration → **feishu-doc-sync** (文档双向操作)
- feishu-wiki → **feishu-wiki-manager** (Wiki结构化管理)
- feishu-ai-edit → **feishu-ai-editor** (强调batch优化)
- 新增 **feishu-workflow-automation** (CI/CD集成)

**新增功能**:
- 单文档下载（按ID/名称/路径）
- 批量Wiki下载（备份整个Wiki空间）
- Wiki结构预览（层级树可视化）
- 批量操作性能优化（5-10x加速）

### v0.1 (2026-01-18) - 项目初始化

初始4个Skills: feishu-upload, feishu-migration, feishu-wiki, feishu-ai-edit

---

## 🎯 核心Skills详解 (v0.2)

### 1. feishu-doc-sync

**场景**: 本地Markdown ↔ 飞书文档双向操作

**核心能力**:
- 上传: feishu-doc-tools (5-10x加速)
- 下载: feishu-doc-tools v0.2.1新功能 ⭐
- 明确: 单向操作（上传或下载），不承诺双向同步

### 2. feishu-wiki-manager

**场景**: Wiki知识库结构化管理

**核心能力**:
- 创建: feishu-doc-tools批量创建
- 预览: list_wiki_tree.py结构预览 ⭐
- 备份: download_wiki.py批量下载 ⭐
- 编辑: Feishu-MCP AI辅助

### 3. feishu-ai-editor

**场景**: 飞书文档AI辅助编辑

**核心能力**:
- batch_create_feishu_blocks (90%效率提升) ⭐
- 智能内容修改、格式优化
- 数学公式、图表、表格

### 4. feishu-workflow-automation

**场景**: CI/CD集成和自动化

**核心能力**:
- Git hooks: 代码变更 → 文档生成 → 自动上传
- 定期备份: Wiki空间批量下载 ⭐
- CI/CD模板: GitHub Actions, GitLab CI, Jenkins

---

## 🔧 工具选择指南 (v0.2新增)⭐

| 场景 | 推荐工具 | 理由 |
|------|---------|------|
| 批量上传 | feishu-doc-tools | 5-10x性能 |
| 批量下载 | feishu-doc-tools | v0.2.1新功能 ⭐ |
| Wiki预览 | feishu-doc-tools | v0.2.1新功能 ⭐ |
| AI编辑 | Feishu-MCP | 智能修改 |
| 批量编辑 | Feishu-MCP | 90%效率提升 ⭐ |

**工作流**: 创建/迁移/下载 → feishu-doc-tools | 编辑/维护 → Feishu-MCP

---

## 🚀 实施计划

### Phase 1: 核心Skills (最高优先级)⭐

1. skills/feishu-doc-sync/SKILL.md
2. skills/feishu-wiki-manager/SKILL.md
3. skills/feishu-ai-editor/SKILL.md
4. skills/feishu-workflow-automation/SKILL.md
5. docs/guides/tool-selection.md

### Phase 2: Docker部署

### Phase 3: 文档完善

---

**最后更新**: 2026-01-19
**状态**: ✅ 已优化Skills架构
