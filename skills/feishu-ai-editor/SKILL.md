---
name: feishu-ai-editor
description: AI-assisted editing for Feishu documents with 90% efficiency optimization. Use when user wants to optimize, improve, reformat, or summarize Feishu documents. Leverages Feishu-MCP's batch_create_feishu_blocks for 90% API call reduction and intelligent content modifications.
---

# Feishu AI Editor Skill

## Overview

The **feishu-ai-editor** skill provides AI-assisted editing capabilities for Feishu (Lark) documents with dramatic performance optimizations. It leverages **Feishu-MCP's** batch operations to achieve **90% API call reduction**, making large-scale document editing practical and efficient.

### Key Features

- **Batch Edit Optimization**: 90% API call reduction with `batch_create_feishu_blocks` ⭐
- **AI-Powered Editing**: Intelligent content modification and optimization
- **Rich Content Support**: Text styles, math formulas, tables, diagrams
- **Format Optimization**: Automatic formatting and structure improvement
- **Document Summarization**: AI-powered content summarization
- **Smart Refactoring**: Content reorganization and restructuring

### Performance Optimization

**Single Block Operations** (Slow - Anti-Pattern):
```typescript
// Avoid: Multiple individual calls
for (let i = 0; i < 100; i++) {
  updateBlock(blockId, content); // 100 API calls
}
```

**Batch Operations** (Fast - Recommended):
```typescript
// Recommended: Single batch call
batch_create_blocks({
  blocks: [...100 blocks]  // 1 API call
});
```

**Efficiency Gain**: 90% reduction in API calls

### Supported Content Types

- **Text**: Bold, italic, underline, strikethrough, inline code
- **Colors**: 7 text colors + 7 background colors
- **Headings**: 9 levels (H1-H9)
- **Lists**: Ordered and unordered
- **Code**: 70+ programming languages with syntax highlighting
- **Math**: LaTeX formula support
- **Tables**: Multi-row/column with mixed content
- **Diagrams**: Mermaid, PlantUML
- **Images**: Local paths and CDN URLs
- **Whiteboard**: Canvas and whiteboard content

## Quick Start

### Batch Edit Document (Recommended)

```typescript
// Use batch_create_feishu_blocks for 90% efficiency
await mcp.batch_create_feishu_blocks({
  documentId: "your_document_id",
  parentBlockId: "document_id",
  index: 0,
  blocks: [
    {
      blockType: "text",
      options: {
        text: {
          textStyles: [{ text: "Optimized Title", style: { bold: true } }]
        }
      }
    },
    {
      blockType: "text",
      options: {
        text: {
          textStyles: [{ text: "Improved content..." }]
        }
      }
    }
    // ... more blocks
  ]
});
```

### Optimize Document Format

```typescript
// Get current document structure
const blocks = await mcp.get_feishu_document_blocks({
  documentId: "your_document_id"
});

// Apply AI optimizations
const optimized = optimizeWithAI(blocks);

// Batch update (90% efficiency)
await mcp.batch_create_feishu_blocks({
  documentId: "your_document_id",
  parentBlockId: "document_id",
  index: 0,
  blocks: optimized
});
```

## Common Scenarios

### Scenario 1: Batch Format Optimization

**User**: "Optimize the formatting of this entire document."

**AI Response**:
```typescript
// Step 1: Get document structure
const { blocks } = await mcp.get_feishu_document_blocks({
  documentId: "doc_id"
});

// Step 2: Analyze and optimize
const optimizedBlocks = blocks.map(block => {
  if (block.blockType === "text") {
    return optimizeTextBlock(block);
  }
  return block;
});

// Step 3: Batch update (90% efficiency gain)
await mcp.batch_create_feishu_blocks({
  documentId: "doc_id",
  parentBlockId: "doc_id",
  index: 0,
  blocks: optimizedBlocks
});

// Result: 1 API call instead of N calls
```

### Scenario 2: Fix Inconsistent Heading Levels

**User**: "This document has inconsistent heading levels. Fix them automatically."

**AI Response**:
```typescript
// Get document blocks
const { blocks } = await mcp.get_feishu_document_blocks({
  documentId: "doc_id"
});

// Analyze heading hierarchy
const headingLevels = analyzeHeadingHierarchy(blocks);

// Fix inconsistencies
const fixedBlocks = blocks.map(block => {
  if (block.blockType.startsWith("heading")) {
    return normalizeHeadingLevel(block, headingLevels);
  }
  return block;
});

// Batch update all at once
await mcp.batch_create_feishu_blocks({
  documentId: "doc_id",
  parentBlockId: "doc_id",
  index: 0,
  blocks: fixedBlocks
});
```

### Scenario 3: Add Code Syntax Highlighting

**User**: "Add syntax highlighting to all code blocks in this document."

**AI Response**:
```typescript
// Get document blocks
const { blocks } = await mcp.get_feishu_document_blocks({
  documentId: "doc_id"
});

// Identify and enhance code blocks
const enhancedBlocks = blocks.map(block => {
  if (block.blockType === "code") {
    const language = detectProgrammingLanguage(block.options.code.code);
    return {
      ...block,
      options: {
        ...block.options,
        code: {
          ...block.options.code,
          language: getLanguageCode(language) // Auto-detect language
        }
      }
    };
  }
  return block;
});

// Batch update
await mcp.batch_create_feishu_blocks({
  documentId: "doc_id",
  parentBlockId: "doc_id",
  index: 0,
  blocks: enhancedBlocks
});
```

### Scenario 4: Summarize Long Document

**User**: "Create a summary of this 50-page document."

**AI Response**:
```typescript
// Get document content
const { blocks } = await mcp.get_feishu_document_blocks({
  documentId: "doc_id"
});

// Extract text content
const content = blocks
  .filter(b => b.blockType === "text")
  .map(b => b.options.text.textStyles.map(t => t.text).join(""))
  .join("\n");

// Generate summary using AI
const summary = await generateSummary(content);

// Create summary blocks
const summaryBlocks = [
  {
    blockType: "heading1",
    options: {
      heading: { level: 1, content: "Document Summary" }
    }
  },
  {
    blockType: "text",
    options: {
      text: {
        textStyles: [{ text: summary }]
      }
    }
  }
];

// Append to document
await mcp.batch_create_feishu_blocks({
  documentId: "doc_id",
  parentBlockId: "doc_id",
  index: blocks.length,
  blocks: summaryBlocks
});
```

### Scenario 5: Reorganize Document Structure

**User**: "Reorganize this document to have a better flow."

**AI Response**:
```typescript
// Get current structure
const { blocks } = await mcp.get_feishu_document_blocks({
  documentId: "doc_id"
});

// Analyze document structure
const structure = analyzeDocumentStructure(blocks);

// Generate new organization
const reorganizedBlocks = reorganizeContent(blocks, structure);

// Replace entire document
await mcp.batch_create_feishu_blocks({
  documentId: "doc_id",
  parentBlockId: "doc_id",
  index: 0,
  blocks: reorganizedBlocks
});
```

### Scenario 6: Add Table of Contents

**User**: "Generate a table of contents for this document."

**AI Response**:
```typescript
// Get document blocks
const { blocks } = await mcp.get_feishu_document_blocks({
  documentId: "doc_id"
});

// Extract headings
const headings = blocks.filter(b =>
  b.blockType.startsWith("heading")
);

// Generate TOC blocks
const tocBlocks = [
  {
    blockType: "heading1",
    options: { heading: { level: 1, content: "Table of Contents" } }
  },
  ...headings.map(h => ({
    blockType: "text",
    options: {
      text: {
        textStyles: [{
          text: `${"  ".repeat(h.options.heading.level - 1)}• ${h.options.heading.content}`
        }]
      }
    }
  }))
];

// Insert at beginning
await mcp.batch_create_feishu_blocks({
  documentId: "doc_id",
  parentBlockId: "doc_id",
  index: 0,
  blocks: tocBlocks
});
```

### Scenario 7: Standardize Terminology

**User**: "Replace all occurrences of 'user' with 'customer' throughout the document."

**AI Response**:
```typescript
// Get document blocks
const { blocks } = await mcp.get_feishu_document_blocks({
  documentId: "doc_id"
});

// Apply terminology changes
const standardizedBlocks = blocks.map(block => {
  if (block.blockType === "text") {
    const textStyles = block.options.text.textStyles.map(style => ({
      ...style,
      text: style.text.replace(/\buser\b/g, "customer")
    }));
    return { ...block, options: { ...block.options, text: { textStyles } } };
  }
  return block;
});

// Batch update
await mcp.batch_create_feishu_blocks({
  documentId: "doc_id",
  parentBlockId: "doc_id",
  index: 0,
  blocks: standardizedBlocks
});
```

### Scenario 8: Enhance Code Examples

**User**: "Improve the formatting of all code examples in this document."

**AI Response**:
```typescript
// Get document blocks
const { blocks } = await mcp.get_feishu_document_blocks({
  documentId: "doc_id"
});

// Enhance code blocks
const enhancedBlocks = blocks.map(block => {
  if (block.blockType === "code") {
    const code = block.options.code.code;
    const language = block.options.code.language;

    // Format code with prettier or similar
    const formatted = formatCode(code, language);

    return {
      ...block,
      options: {
        ...block.options,
        code: { ...block.options.code, code: formatted }
      }
    };
  }
  return block;
});

// Batch update
await mcp.batch_create_feishu_blocks({
  documentId: "doc_id",
  parentBlockId: "doc_id",
  index: 0,
  blocks: enhancedBlocks
});
```

### Scenario 9: Add Callout Boxes

**User**: "Convert important notes into callout boxes."

**AI Response**:
```typescript
// Get document blocks
const { blocks } = await mcp.get_feishu_document_blocks({
  documentId: "doc_id"
});

// Find and convert notes
const calloutBlocks = blocks.map(block => {
  if (block.blockType === "text" && isNote(block)) {
    return {
      blockType: "text",
      options: {
        text: {
          textStyles: [{
            text: extractNoteText(block),
            style: {
              bold: false,
              background_color: 4 // Yellow background
            }
          }]
        },
        align: 1 // Left align
      }
    };
  }
  return block;
});

// Batch update
await mcp.batch_create_feishu_blocks({
  documentId: "doc_id",
  parentBlockId: "doc_id",
  index: 0,
  blocks: calloutBlocks
});
```

### Scenario 10: Merge Duplicate Sections

**User**: "This document has duplicate sections. Merge them."

**AI Response**:
```typescript
// Get document blocks
const { blocks } = await mcp.get_feishu_document_blocks({
  documentId: "doc_id"
});

// Identify duplicate sections
const duplicates = findDuplicateSections(blocks);

// Merge duplicates
const mergedBlocks = mergeDuplicateSections(blocks, duplicates);

// Replace document
await mcp.batch_create_feishu_blocks({
  documentId: "doc_id",
  parentBlockId: "doc_id",
  index: 0,
  blocks: mergedBlocks
});
```

## Best Practices

### 1. Always Use Batch Operations (Critical!)⭐

**Recommended**: Single batch call
```typescript
await mcp.batch_create_feishu_blocks({
  blocks: [...100 blocks]
});
```

**Avoid**: Multiple individual calls
```typescript
for (const block of blocks) {
  await mcp.createBlock(block); // 100x slower
}
```

**Performance**: 90% API call reduction

### 2. Group Related Edits

**Good**: Single batch with all changes
```typescript
await mcp.batch_create_feishu_blocks({
  blocks: [
    headingBlock,
    contentBlock1,
    contentBlock2,
    ...
  ]
});
```

**Avoid**: Multiple batches for related changes
```typescript
await mcp.batch_create_feishu_blocks({ blocks: [headingBlock] });
await mcp.batch_create_feishu_blocks({ blocks: [contentBlock1] });
await mcp.batch_create_feishu_blocks({ blocks: [contentBlock2] });
```

### 3. Use Appropriate Block Types

Match block type to content:
- `heading` - Headings (H1-H9)
- `text` - Paragraphs and inline content
- `code` - Code blocks
- `list` - Ordered and unordered lists
- `table` - Tabular data
- `image` - Images
- `mermaid` - Diagrams

### 4. Leverage Text Styles

Use rich text styling for emphasis:
```typescript
{
  blockType: "text",
  options: {
    text: {
      textStyles: [
        { text: "Bold text", style: { bold: true } },
        { text: "Italic text", style: { italic: true } },
        { text: "Code", style: { inline_code: true } },
        { text: "Highlight", style: { background_color: 4 } }
      ]
    }
  }
}
```

### 5. Optimize Batch Size

**Recommended**: 50-100 blocks per batch
- Balances API limits with efficiency
- Feishu API limit: 50 blocks per batch
- Auto-batching handles larger sets

### 6. Preserve Document Structure

When editing, maintain document hierarchy:
```typescript
const { blocks } = await mcp.get_feishu_document_blocks({
  documentId: "doc_id"
});

// Preserve structure when modifying
const modifiedBlocks = blocks.map(block => {
  // Modify but keep block type and position
  return modifyBlock(block);
});

await mcp.batch_create_feishu_blocks({
  parentBlockId: "doc_id",
  index: 0, // Replace from beginning
  blocks: modifiedBlocks
});
```

### 7. Use User Authentication

For Wiki editing, user authentication is required:
```typescript
// Configure Feishu-MCP with user auth
{
  "mcpServers": {
    "feishu-mcp": {
      "url": "http://localhost:3333/sse?userKey=unique_user_key"
    }
  }
}
```

### 8. Handle Errors Gracefully

```typescript
try {
  await mcp.batch_create_feishu_blocks({
    blocks: largeBlockSet
  });
} catch (error) {
  // Auto-batching handles large sets
  // Log errors for manual review
  console.error("Batch edit failed:", error);
}
```

## Troubleshooting

### Issue 1: Batch Operation is Slow

**Issue**: Batch operations are not faster than individual calls

**Solution**:
```typescript
// Ensure you're using batch_create_feishu_blocks
// Not individual block creation

// Good: Batch operation
await mcp.batch_create_feishu_blocks({ blocks: [...] });

// Avoid: Individual operations
for (const block of blocks) {
  await mcp.createBlock(block);
}
```

### Issue 2: Block Order is Wrong

**Issue**: Blocks appear in wrong order

**Solution**:
```typescript
// Specify correct index
await mcp.batch_create_feishu_blocks({
  parentBlockId: "doc_id",
  index: 0, // Insert at beginning
  blocks: newBlocks
});

// Or append to end
const { blocks } = await mcp.get_feishu_document_blocks({
  documentId: "doc_id"
});

await mcp.batch_create_feishu_blocks({
  parentBlockId: "doc_id",
  index: blocks.length, // Append
  blocks: newBlocks
});
```

### Issue 3: Text Styles Not Applied

**Issue**: Text formatting doesn't appear

**Solution**:
```typescript
// Ensure textStyles array is properly formatted
{
  blockType: "text",
  options: {
    text: {
      textStyles: [
        {
          text: "Bold text",
          style: { bold: true } // style object required
        }
      ]
    }
  }
}
```

### Issue 4: Code Highlighting Not Working

**Issue**: Code blocks don't have syntax highlighting

**Solution**:
```typescript
// Specify correct language code
{
  blockType: "code",
  options: {
    code: {
      code: "function hello() {}",
      language: 30 // 30 = JavaScript
    }
  }
}

// Language codes: 1=PlainText, 30=JavaScript, 49=Python, etc.
```

### Issue 5: Wiki Edit Permission Denied

**Error**: `PermissionError: Insufficient permissions`

**Solution**:
```typescript
// Wiki editing requires user authentication
// Ensure Feishu-MCP is configured with user auth

// Check MCP server configuration
{
  "mcpServers": {
    "feishu-mcp": {
      "url": "http://localhost:3333/sse?userKey=YOUR_KEY"
    }
  }
}

// Run user auth setup
# In feishu-doc-tools
python scripts/setup_user_auth.py
```

### Issue 6: Large Document Edit Fails

**Error**: `RequestTooLargeError: Document too large`

**Solution**:
```typescript
// Split into smaller batches
const chunks = chunkArray(blocks, 50);

for (const chunk of chunks) {
  await mcp.batch_create_feishu_blocks({
    blocks: chunk
  });
}

// Or rely on auto-batching (built-in)
await mcp.batch_create_feishu_blocks({
  blocks: largeBlockSet // Auto-splits into 50-block batches
});
```

### Issue 7: Special Characters Not Displaying

**Issue**: Special characters appear incorrectly

**Solution**:
```typescript
// Properly escape special characters in text
{
  blockType: "text",
  options: {
    text: {
      textStyles: [{
        text: "Use * for bold, _ for italic, and ` for code"
        // No markdown escaping needed - use plain text
      }]
    }
  }
}
```

### Issue 8: Table Not Rendering Correctly

**Issue**: Table structure is malformed

**Solution**:
```typescript
// Ensure proper table structure
await mcp.create_feishu_table({
  documentId: "doc_id",
  parentBlockId: "doc_id",
  index: 0,
  tableConfig: {
    rowSize: 3,
    columnSize: 3,
    cells: [
      {
        coordinate: { row: 0, column: 0 },
        content: { blockType: "text", options: { text: { textStyles: [{ text: "Header" }] } } }
      },
      // ... more cells
    ]
  }
});
```

## Performance Optimization

### Batch vs Individual Operations

**Scenario**: Update 100 blocks

**Individual Operations**:
```
100 API calls × 100ms = 10,000ms (10 seconds)
```

**Batch Operation**:
```
1 API call × 500ms = 500ms (0.5 seconds)
```

**Speedup**: 20x faster

### Auto-Batching

Feishu-MCP automatically splits large requests:
```typescript
// This request with 200 blocks
await mcp.batch_create_feishu_blocks({
  blocks: [...200 blocks]
});

// Automatically splits into:
// - 4 batches of 50 blocks each
// - 4 API calls instead of 200
// - 98% reduction in API calls
```

## Reference

### Feishu-MCP Core Tools

**Batch Operations** (Recommended):
- `batch_create_feishu_blocks` - Create/update multiple blocks (90% efficiency) ⭐
- `create_feishu_table` - Create complex tables

**Single Operations** (Use sparingly):
- `update_feishu_block_text` - Update single block
- `delete_feishu_document_blocks` - Delete blocks

**Document Operations**:
- `get_feishu_document_blocks` - Get document structure
- `get_feishu_document_info` - Get document metadata

**Advanced Features**:
- `upload_and_bind_image_to_block` - Upload images
- `fill_whiteboard_with_plantuml` - Create diagrams

### Block Type Reference

**Text Blocks**:
- `text` - Rich text content
- `heading1` through `heading9` - Headings
- `code` - Code blocks
- `list` - Ordered/unordered lists

**Structured Content**:
- `table` - Tables with mixed content
- `image` - Image placeholders
- `mermaid` - Mermaid diagrams
- `whiteboard` - Whiteboard/Canvas content

### Text Style Reference

**Styling Options**:
```typescript
{
  bold: boolean,
  italic: boolean,
  underline: boolean,
  strikethrough: boolean,
  inline_code: boolean,
  text_color: number, // 0-7
  background_color: number // 0-7
}
```

**Color Codes**:
- 0: Black (default)
- 1: Gray
- 2: Brown
- 3: Orange
- 4: Yellow
- 5: Green
- 6: Blue
- 7: Purple

### Language Codes

Common programming languages:
- 1: PlainText
- 7: Bash
- 27: Go
- 28: Groovy
- 30: JavaScript
- 49: Python
- 53: Rust
- 57: Scala
- 60: Shell
- 61: Swift
- 63: TypeScript
- 66: YAML

## Related Skills

- **feishu-doc-sync**: Upload/download operations for content preparation
- **feishu-wiki-manager**: Wiki-specific operations
- **feishu-workflow-automation**: CI/CD integration for automated editing

---

**Last Updated**: 2026-01-19
**Version**: v0.2
**Requires**: Feishu-MCP v0.1.8+
**Performance**: 90% API call reduction with batch operations
