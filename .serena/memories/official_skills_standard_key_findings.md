# 官方 Skills 标准 - 关键结论

**Review 日期**: 2026-01-18
**来源**: 分析 `/home/howie/Software/utility/Reference/skills`

## 核心发现

官方 Skills **不是单文件模式**，而是**主文件 + 可选目录**的灵活结构。

## 标准结构

```
skills/
└── skill-name/
    ├── SKILL.md           # 主文件（必需），全大写
    ├── examples/          # 示例目录（可选）
    ├── scripts/           # 脚本目录（可选）
    ├── reference/         # 参考文档（可选）
    └── templates/         # 模板目录（可选）
```

## 必需元素

1. **SKILL.md**（全大写命名）
2. **YAML frontmatter**（name, description）
   ```yaml
   ---
   name: skill-name
   description: Clear description of what this skill does and when to use it
   license: Optional (if applicable)
   ---
   ```

## 可选目录

- `examples/` - 示例文档
- `scripts/` - 辅助脚本
- `reference/` - 参考文档
- `templates/` - 模板文件

## 设计原则

1. **自描述性**: AI 可以直接读取和理解
2. **标准化**: 统一的参数命名和返回格式
3. **实用性**: 包含可运行的示例
4. **可组合**: Skills 可以相互引用
5. **上下文感知**: 根据用户输入决定激活

## 关键差异

| 方面 | 错误理解 | 正确标准 |
|------|---------|---------|
| 主文件 | skill.md（小写） | SKILL.md（大写） |
| 结构 | 单文件 | 主文件 + 可选目录 |
| Frontmatter | 缺失 | YAML（必需） |

## 实施建议

1. ✅ 所有 Skills 使用 SKILL.md 作为主文件
2. ✅ SKILL.md 必须包含 YAML frontmatter
3. ✅ 可选目录使用标准名称（examples/, scripts/, reference/）
4. ✅ 核心内容放在 SKILL.md 中
5. ✅ 详细示例和参考文档可放入可选目录

## 参考示例

**docx Skill**（官方）:
```
docx/
├── SKILL.md (main file)
├── docx-js.md (reference)
├── ooxml.md (reference)
├── ooxml/ (directory)
└── scripts/ (directory)
```

---

**状态**: ✅ 已整合到主计划
**下一步**: Phase 1 - 创建核心 Skills（feishu-upload, feishu-migration, feishu-wiki, feishu-ai-edit）
