# Example: Upload with AI Optimization

## Scenario
A documentation team wants to upload technical documentation and have AI automatically optimize formatting, fix inconsistencies, and improve readability.

## User Request
**User**: "I have a technical spec document that needs to be uploaded to Feishu. The formatting is messy and inconsistent. Can you upload it and clean it up automatically?"

## AI Agent Response

I'll help you upload the document using feishu-doc-tools and then optimize it with Feishu-MCP's AI capabilities for a polished result.

This is a two-step process:
1. **Upload**: Fast bulk upload with feishu-doc-tools
2. **Optimize**: AI-powered formatting with Feishu-MCP

**Step 1: Upload the document**
```bash
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/create_feishu_doc.py \
  --title "Technical Specification" \
  --file technical-spec.md \
  --folder-token "fldcnxxxxxxxxxxx"
```

**Step 2: AI optimization** (using Feishu-MCP)
```typescript
// Use feishu-ai-editor skill for optimization
// See: skills/feishu-ai-editor/SKILL.md
```

## Command Executed

### Step 1: Upload
```bash
cd $(dirname /home/user/feishu-doc-tools/scripts/create_feishu_doc.py) && uv run python /home/user/feishu-doc-tools/scripts/create_feishu_doc.py \
  --title "Technical Specification v2.0" \
  --file /home/user/docs/technical-spec.md \
  --folder-token "fldcn1234567890abcdef"
```

### Step 2: AI Optimization
```typescript
// Get document structure
const doc = await mcp.get_feishu_document_blocks({
  documentId: "doccnABCDEF1234567890"
});

// Apply AI optimizations
const optimized = await optimizeDocument(doc, {
  fixHeadingLevels: true,
  standardizeFormatting: true,
  addCodeHighlighting: true,
  improveReadability: true
});

// Batch update with 90% API efficiency
await mcp.batch_create_feishu_blocks({
  documentId: "doccnABCDEF1234567890",
  parentBlockId: "doccnABCDEF1234567890",
  index: 0,
  blocks: optimized.blocks
});
```

## Expected Output

### Step 1: Upload Output
```
[INFO] Reading file: /home/user/docs/technical-spec.md
[INFO] File size: 35.8 KB
[INFO] Parsing Markdown content...
[INFO] Creating Feishu document...
[SUCCESS] Document created successfully!

Document ID: doccnABCDEF1234567890
URL: https://example.feishu.cn/docx/doccnABCDEF1234567890
Upload time: 3.2s
```

### Step 2: AI Optimization Output
```
[INFO] Analyzing document structure...
[INFO] Detected issues:
  - Inconsistent heading levels (H2 → H4 skip)
  - Mixed code formatting (inline vs blocks)
  - 8 long paragraphs need splitting
  - Missing table of contents

[INFO] Applying AI optimizations...

Optimizations Applied:
┏━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━┓
┃ Optimization            ┃ Count  ┃
┡━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━┩
│ Heading levels fixed    │ 12     │
│ Code blocks added       │ 8      │
│ Paragraphs split        │ 8      │
│ TOC added               │ 1      │
│ List formatting fixed   │ 5      │
│ Table formatting        │ 3      │
└─────────────────────────┴────────┘

[INFO] Batch updating document...
[INFO] API calls: 1 (vs 37 individual calls)
[INFO] API efficiency: 97% reduction

[SUCCESS] Document optimized!
Optimization time: 2.8s
Total blocks updated: 156
```

## Result

✅ **Successfully uploaded and optimized "Technical Specification"**

**Upload Statistics**:
- Original file: 35.8 KB
- Upload time: 3.2s
- Document ID: `doccnABCDEF1234567890`

**AI Optimization Results**:
- Issues fixed: 37
- Blocks updated: 156
- Optimization time: 2.8s
- API efficiency: 97% reduction (1 call vs 37 calls)

**Before vs After**:

| Aspect | Before | After |
|--------|--------|-------|
| Heading structure | Inconsistent (H2→H4 skip) | Logical hierarchy ✅ |
| Code formatting | Mixed (inline + blocks) | Properly highlighted ✅ |
| Paragraph length | 8 long paragraphs | Well-structured ✅ |
| Table of contents | Missing | Auto-generated ✅ |
| List formatting | Inconsistent bullets | Standardized ✅ |
| Table formatting | Plain text | Proper tables ✅ |

## Complete Workflow Script

### Automated upload + optimize script
```bash
#!/bin/bash
# upload-and-optimize.sh

# Configuration
DOC_TITLE="$1"
DOC_FILE="$2"
FOLDER_TOKEN="$3"

# Step 1: Upload
echo "📤 Uploading document..."
UPLOAD_RESULT=$(cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/create_feishu_doc.py \
  --title "$DOC_TITLE" \
  --file "$DOC_FILE" \
  --folder-token "$FOLDER_TOKEN" \
  --json-output)

# Extract document ID
DOC_ID=$(echo "$UPLOAD_RESULT" | jq -r '.document_id')
echo "✅ Uploaded: $DOC_ID"

# Step 2: AI Optimization
echo "🤖 Optimizing with AI..."
node optimize-document.js "$DOC_ID"

echo "✨ Complete! Document ready."
```

### Node.js optimization script
```typescript
// optimize-document.js
import { FeishuMCP } from 'feishu-mcp';

async function optimizeDocument(documentId: string) {
  const mcp = new FeishuMCP();

  // Get current structure
  const doc = await mcp.get_feishu_document_blocks({ documentId });

  // Apply optimizations
  const optimizations = {
    fixHeadingLevels: true,
    addCodeHighlighting: true,
    improveTableFormatting: true,
    addTableOfContents: true,
    splitLongParagraphs: true,
    standardizeLists: true
  };

  const optimized = await applyAIOptimizations(doc, optimizations);

  // Batch update (90% API efficiency)
  await mcp.batch_create_feishu_blocks({
    documentId,
    parentBlockId: documentId,
    index: 0,
    blocks: optimized.blocks
  });

  console.log('✅ Optimization complete!');
}

// Run
const docId = process.argv[2];
optimizeDocument(docId);
```

## Advanced Optimization Options

### Custom optimization rules
```typescript
const optimizations = {
  // Heading structure
  fixHeadingLevels: true,
  maxHeadingLevel: 4,

  // Code formatting
  addCodeHighlighting: true,
  detectLanguage: true,
  wrapLongLines: true,

  // Readability
  splitLongParagraphs: true,
  maxParagraphLength: 300,

  // Structure
  addTableOfContents: true,
  tocDepth: 3,

  // Lists
  standardizeLists: true,
  preferBullets: 'disc',

  // Tables
  improveTableFormatting: true,
  addTableHeaders: true,

  // Links
  convertTextToLinks: true,
  validateLinks: true
};
```

### Batch upload + optimize multiple files
```bash
#!/bin/bash
# batch-upload-optimize.sh

FOLDER_TOKEN="fldcn1234567890"

for file in docs/*.md; do
  echo "Processing: $file"

  # Upload
  DOC_ID=$(uv run python create_feishu_doc.py \
    --title "$(basename "$file" .md)" \
    --file "$file" \
    --folder-token "$FOLDER_TOKEN" \
    --json-output | jq -r '.document_id')

  # Optimize
  node optimize-document.js "$DOC_ID"

  echo "✅ Complete: $DOC_ID"
  sleep 1  # Rate limit protection
done
```

## Performance Comparison

| Operation | Manual | Automated | Savings |
|-----------|--------|-----------|---------|
| Upload | 3.2s | 3.2s | - |
| Heading fixes | 5 min | 0.5s | 99% ⭐ |
| Code formatting | 3 min | 0.3s | 99% ⭐ |
| Table formatting | 4 min | 0.4s | 99% ⭐ |
| Overall | 12+ min | 4.4s | **99.4%** ⭐ |

## Troubleshooting

**If optimization fails**:
```bash
# Check if document was uploaded
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/get_doc_info.py \
  --doc-id "doccnABCDEF1234567890"

# Retry optimization only
node optimize-document.js "doccnABCDEF1234567890"
```

**If some optimizations are too aggressive**:
```typescript
// Disable specific optimizations
const optimizations = {
  fixHeadingLevels: true,
  addCodeHighlighting: true,
  splitLongParagraphs: false,  // Disable this one
};
```

**If API rate limit is hit**:
```typescript
// Add delay between operations
await sleep(1000);  // 1 second delay
```

## Best Practices

1. **Upload first, optimize second**: Separate concerns for reliability
2. **Use batch operations**: 90% API efficiency with batch_create_feishu_blocks
3. **Test optimizations**: Run on sample doc first
4. **Version control**: Keep original markdown in git
5. **Automate common patterns**: Create reusable optimization scripts

## Related Examples

- [01-upload-single-doc.md](./01-upload-single-doc.md) - Upload without optimization
- [02-batch-upload-folder.md](./02-batch-upload-folder.md) - Batch upload
- See also: [skills/feishu-ai-editor/examples/](../../feishu-ai-editor/examples/) - More AI optimization examples
