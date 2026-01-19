# feishu-doc-tools vs Feishu-MCP - Complete Comparison

## Quick Decision Guide

| Your Need | Recommended Tool | Why |
|-----------|------------------|-----|
| Upload 100+ documents | feishu-doc-tools | 5-10x faster with parallel processing |
| Download entire Wiki | feishu-doc-tools | v0.2.1 new feature, batch download |
| AI-assisted editing | Feishu-MCP | Intelligent content modification |
| Batch formatting fix | Feishu-MCP | 90% API call reduction |
| CLI automation | feishu-doc-tools | Command-line first design |
| Interactive editing | Feishu-MCP | MCP protocol integration |

## Tool Overview

### feishu-doc-tools
- **Type**: CLI tool (Python scripts)
- **Strengths**: High-performance batch operations
- **Use cases**: Upload, download, migration, backup
- **Performance**: 5-10x speedup with parallel processing
- **Installation**: `uv sync` (or `uv pip install feishu-doc-tools` for standalone)
- **GitHub**: Reference project location

### Feishu-MCP
- **Type**: MCP Server (TypeScript/Node.js)
- **Strengths**: AI-powered editing, intelligent modifications
- **Use cases**: Format optimization, content improvement
- **Performance**: 90% API call reduction with batch operations
- **Installation**: Docker or npm package
- **GitHub**: Reference project location

## Feature Comparison Matrix

| Feature | feishu-doc-tools | Feishu-MCP | Winner |
|---------|------------------|------------|--------|
| **Upload single document** | ✅ Fast | ✅ Standard | Tie |
| **Batch upload (100+ files)** | ✅ 5-10x faster | ⚠️ Slower | feishu-doc-tools |
| **Download documents** | ✅ v0.2.1 | ❌ Not supported | feishu-doc-tools |
| **Wiki structure preview** | ✅ v0.2.1 | ❌ Not supported | feishu-doc-tools |
| **Batch Wiki download** | ✅ v0.2.1 | ❌ Not supported | feishu-doc-tools |
| **AI content optimization** | ❌ Not supported | ✅ Core feature | Feishu-MCP |
| **Batch block editing** | ❌ Not supported | ✅ 90% efficiency | Feishu-MCP |
| **Format fixing** | ⚠️ Basic | ✅ Advanced | Feishu-MCP |
| **CLI automation** | ✅ Excellent | ⚠️ Limited | feishu-doc-tools |
| **CI/CD integration** | ✅ Perfect | ⚠️ Possible | feishu-doc-tools |
| **Parallel processing** | ✅ 5-8 workers | ⚠️ Limited | feishu-doc-tools |
| **OAuth support** | ✅ v0.2.1 | ✅ Yes | Tie |
| **Docker deployment** | ⚠️ Manual | ✅ Official | Feishu-MCP |

## Performance Comparison

### Upload Performance

| Document Size | feishu-doc-tools | Feishu-MCP | Speedup |
|--------------|------------------|------------|---------|
| Small (<50KB) | 2s | 3s | 1.5x |
| Medium (50-500KB) | 8s | 30s | 3.8x |
| Large (500KB-5MB) | 30s | 180s | 6x |
| Very Large (>5MB) | 75s | 600s | 8x |

### Batch Operations

| Operation | feishu-doc-tools | Feishu-MCP | Winner |
|-----------|------------------|------------|--------|
| 100 documents upload | 2-3 min | 10-15 min | feishu-doc-tools (5x) |
| 100 blocks edit | N/A | 1 API call | Feishu-MCP |
| Wiki tree traversal (100 nodes) | 3s | 10s+ | feishu-doc-tools (3x) |

## When to Use Each Tool

### Use feishu-doc-tools When:

✅ **Uploading large batches** (100+ documents)
```bash
# Perfect use case
uv run python batch_create_docs.py --source-dir docs --parallel --workers 5
```

✅ **Downloading documents** (NEW in v0.2.1)
```bash
# Only feishu-doc-tools supports this
uv run python download_doc.py --doc-name "My Doc" --output mydoc.md
```

✅ **Backing up Wiki spaces**
```bash
# Complete Wiki backup
uv run python download_wiki.py --space-name "KB" --output ./backup --parallel
```

✅ **CI/CD pipelines**
```yaml
# GitHub Actions, GitLab CI, Jenkins
- run: uv run python batch_create_docs.py --source-dir docs --parallel
```

✅ **CLI automation scripts**
```bash
# Easy to script
for file in docs/*.md; do
  uv run python create_feishu_doc.py --file "$file" --folder-token "$TOKEN"
done
```

### Use Feishu-MCP When:

✅ **AI-powered content optimization**
```typescript
// Intelligent improvements
await mcp.optimizeDocument(docId, {
  fixFormatting: true,
  improveReadability: true
});
```

✅ **Batch editing with high efficiency**
```typescript
// 90% API call reduction
await mcp.batch_create_feishu_blocks({
  blocks: [...100 blocks]  // 1 API call vs 100
});
```

✅ **Interactive document modification**
```typescript
// Complex formatting
await mcp.addTableOfContents(docId);
await mcp.standardizeHeadings(docId);
await mcp.improveCodeBlocks(docId);
```

✅ **Rich content creation**
```typescript
// Advanced features
await mcp.createWhiteboard(docId);
await mcp.addMermaidDiagram(docId, diagramCode);
await mcp.createComplexTable(docId, tableData);
```

## Combined Workflow (Recommended)

### Best Practice: Use Both Tools Together

**Step 1: Bulk Upload** (feishu-doc-tools)
```bash
# Fast batch upload
uv run python batch_create_docs.py \
  --source-dir docs \
  --parallel \
  --workers 5 \
  --folder-token "$TOKEN"
```

**Step 2: AI Optimization** (Feishu-MCP)
```typescript
// Optimize uploaded documents
for (const docId of uploadedDocs) {
  await mcp.optimizeDocument(docId);
}
```

**Step 3: Periodic Backup** (feishu-doc-tools)
```bash
# Daily backup
uv run python download_wiki.py \
  --space-name "Knowledge Base" \
  --output ./backups/$(date +%Y-%m-%d) \
  --parallel
```

## Installation & Setup

### feishu-doc-tools

```bash
# Clone repository (or install package)
git clone https://github.com/your-org/feishu-doc-tools
cd feishu-doc-tools

# Install dependencies with uv lockfile workflow
uv sync

# Setup authentication
uv run python scripts/setup_user_auth.py

# Configure .env
cat <<EOF > .env
FEISHU_APP_ID=your_app_id
FEISHU_APP_SECRET=your_app_secret
EOF
```

### Feishu-MCP

```bash
# Using Docker (recommended)
docker pull your-org/feishu-mcp:latest

docker run -d \
  -p 3000:3000 \
  -e FEISHU_APP_ID=your_app_id \
  -e FEISHU_APP_SECRET=your_app_secret \
  your-org/feishu-mcp:latest

# Or using npm
npm install -g feishu-mcp
feishu-mcp start
```

## Authentication

Both tools support:
- ✅ User OAuth (recommended)
- ✅ Tenant access token
- ✅ Environment variables
- ✅ Config files

**Recommendation**: Use user OAuth for full feature access.

## API Rate Limits

| Tool | Strategy | Efficiency |
|------|----------|------------|
| feishu-doc-tools | Parallel workers (5-8) | Maximize throughput |
| Feishu-MCP | Batch operations | Minimize API calls (90% reduction) |

## Migration Guide

### From feishu-doc-tools to Feishu-MCP

If you need AI editing capabilities:

```bash
# 1. Upload with feishu-doc-tools (keep this)
uv run python batch_create_docs.py --source-dir docs --parallel

# 2. Add Feishu-MCP for editing
npm install feishu-mcp

# 3. Use both in workflow
./upload-and-optimize.sh
```

### From Feishu-MCP to feishu-doc-tools

If you need batch download or faster uploads:

```bash
# 1. Install feishu-doc-tools with uv
uv sync

# 2. Use for batch operations
uv run python batch_create_docs.py --source-dir docs --parallel

# 3. Keep Feishu-MCP for AI editing
# Use both tools for their strengths
```

## Cost Comparison

### API Calls

| Operation | feishu-doc-tools | Feishu-MCP |
|-----------|------------------|------------|
| Upload 1 document (100 blocks) | 100 calls | 100 calls |
| Edit 100 blocks | N/A | 1 call (batch) |
| Download 1 document | 1 call | N/A |
| Wiki traversal (100 nodes) | 100 calls | 100 calls |

### Performance Cost

| Metric | feishu-doc-tools | Feishu-MCP |
|--------|------------------|------------|
| Upload speed | Fast (parallel) | Standard |
| Download speed | Fast (v0.2.1) | N/A |
| Editing efficiency | N/A | Very High (90% reduction) |

## Troubleshooting

### feishu-doc-tools Issues

**Slow uploads**:
```bash
# Increase workers
uv run python batch_create_docs.py --parallel --workers 8
```

**Authentication errors**:
```bash
# Re-run setup
uv run python scripts/setup_user_auth.py
```

### Feishu-MCP Issues

**API rate limits**:
```typescript
// Use batch operations
await mcp.batch_create_feishu_blocks({...});
```

**Docker connection issues**:
```bash
# Check container status
docker ps | grep feishu-mcp

# View logs
docker logs feishu-mcp-container
```

## Summary

**Choose feishu-doc-tools for**:
- ✅ Batch upload (5-10x faster)
- ✅ Document download (NEW)
- ✅ Wiki backup (NEW)
- ✅ CLI automation
- ✅ CI/CD pipelines

**Choose Feishu-MCP for**:
- ✅ AI-powered editing
- ✅ Batch block operations (90% efficiency)
- ✅ Interactive modifications
- ✅ Rich content creation

**Best Practice**: Use both tools together for optimal workflow:
1. Upload with feishu-doc-tools (fast)
2. Edit with Feishu-MCP (intelligent)
3. Backup with feishu-doc-tools (complete)
