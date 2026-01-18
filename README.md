# feishu-playbook

> 研发团队的文档自动化平台 + AI Skills 库

## 🎯 项目定位

feishu-playbook 是一个集成 Feishu-MCP 和 feishu-doc-tools 的操作手册和最佳实践集合，帮助研发团队：

1. **降低文档构建成本** - 利用 AI 和自动化工具
2. **文档规范化** - 统一的模板和格式
3. **流程自动化** - 代码更新 → 文档更新 → 飞书上传
4. **AI Skills 模块** - 让 AI Agent 快速掌握飞书操作

## 📚 快速开始

### AI Skills（核心）

AI Skills 是本项目的核心，提供标准化的飞书文档操作能力：

- **feishu-upload** - 文档上传（支持批量）
- **feishu-migration** - 批量迁移
- **feishu-wiki** - Wiki 管理
- **feishu-ai-edit** - AI 辅助编辑

详见 [skills/](./skills/) 目录。

### 工作流脚本

自动化脚本支持日常研发场景：

- `workflows/migrate-and-optimize.sh` - 批量迁移 + AI 优化
- `workflows/backup-wiki.sh` - Wiki 备份
- `workflows/sync-docs.sh` - 文档同步

### CI/CD 集成

实现代码到文档到飞书的自动化链路：

- `workflows/ci-integration/` - CI/CD 集成脚本
- `examples/ci-templates/` - GitHub Actions/GitLab CI/Jenkins 模板

## 🔧 参考项目

- **Feishu-MCP**: `/home/howie/Software/utility/Reference/Feishu-MCP`
- **feishu-doc-tools**: `/home/howie/Software/utility/Reference/feishu-doc-tools`

## 📖 文档

- [操作手册](./docs/playbooks/)
- [使用指南](./docs/guides/)
- [故障排查](./docs/troubleshooting/)

## 🚀 快速上手

1. 阅读 [skills/feishu-upload/skill.md](./skills/feishu-upload/skill.md) 了解如何上传文档
2. 通过对话与 AI 交互，完成文档操作
3. 参考 [examples/](./examples/) 中的示例和模板

## 📝 许可证

MIT License
