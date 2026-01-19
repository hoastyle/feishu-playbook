---
name: feishu-doc-sync
description: Bidirectional document operations between local Markdown and Feishu. Use when user wants to upload, download, backup, or migrate documents. Supports single file and batch operations with automatic parallel processing (5-10x speedup). Combines feishu-doc-tools for high-performance transfer with Feishu-MCP for AI-assisted editing.
---

# Feishu Document Sync Skill

## Overview

The **feishu-doc-sync** skill provides bidirectional document operations between local Markdown files and Feishu (Lark) documents. It combines the high-performance batch processing capabilities of **feishu-doc-tools** with the AI-powered editing capabilities of **Feishu-MCP**.

### Key Features

- **High-Performance Upload**: 5-10x speedup with parallel processing
- **Document Download**: NEW in v0.2.1 - download single documents or batch download Wiki spaces
- **Batch Operations**: Process entire folders with automatic parallelization
- **Multiple Formats**: Supports Markdown, code blocks, tables, math formulas, Mermaid diagrams
- **Flexible Parameters**: Supports both ID-based and name-based path resolution

### Performance Benchmarks

| Document Size | Serial Time | Parallel Time | Speedup |
|--------------|-------------|---------------|---------|
| Small (<50 blocks) | 3s | 2s | 1.5x |
| Medium (50-200) | 30s | 8s | 3.8x |
| Large (200-1000) | 180s | 30s | 6x |
| Very Large (1000+) | 600s | 75s | 8x |

### Tool Selection

**Primary Tool**: **feishu-doc-tools**
- High-performance batch operations
- Complete download functionality (v0.2.1)
- Parallel processing (5-10x speedup)
- CLI-first design for automation

**Secondary Tool**: **Feishu-MCP** (for AI-assisted editing after upload)
- Intelligent content modification
- Format optimization
- Batch editing with 90% API call reduction

## Quick Start

### Upload a Single Document

```bash
# Using feishu-doc-tools (recommended for performance)
python /path/to/feishu-doc-tools/scripts/create_feishu_doc.py \
  --title "My Document" \
  --file /path/to/document.md \
  --folder-token "your_folder_token"
```

### Batch Upload Entire Folder

```bash
# Using feishu-doc-tools with parallel processing
python /path/to/feishu-doc-tools/scripts/batch_create_docs.py \
  --source-dir /path/to/docs \
  --recursive \
  --parallel \
  --workers 5
```

### Download a Single Document (NEW v0.2.1)

```bash
# Download by document ID
python /path/to/feishu-doc-tools/scripts/download_doc.py \
  --doc-id "your_document_id" \
  --output /path/to/output.md

# Download by document name
python /path/to/feishu-doc-tools/scripts/download_doc.py \
  --doc-name "My Document" \
  --output /path/to/output.md
```

### Batch Download Wiki Space (NEW v0.2.1)

```bash
# Download entire Wiki space for backup
python /path/to/feishu-doc-tools/scripts/download_wiki.py \
  --space-name "My Wiki Space" \
  --output /path/to/backup \
  --parallel
```

## Common Scenarios

### Scenario 1: Upload Documentation Folder

**User**: "I have a folder of Markdown documentation that I want to upload to Feishu."

**AI Response**:
```bash
# Use batch_create_docs.py for high-performance upload
python /path/to/feishu-doc-tools/scripts/batch_create_docs.py \
  --source-dir /path/to/docs \
  --recursive \
  --parallel \
  --workers 5 \
  --folder-token "your_folder_token"

# Expected performance: 50-100 documents in 1-2 minutes
```

### Scenario 2: Download Document for Offline Editing

**User**: "I need to download a Feishu document to edit it offline."

**AI Response**:
```bash
# Use download_doc.py (NEW in v0.2.1)
python /path/to/feishu-doc-tools/scripts/download_doc.py \
  --doc-id "document_id" \
  --output /path/to/document.md

# Alternative: download by document name
python /path/to/feishu-doc-tools/scripts/download_doc.py \
  --doc-name "Document Title" \
  --space-name "My Space" \
  --output /path/to/document.md
```

### Scenario 3: Backup Wiki Space

**User**: "I want to backup our entire Wiki knowledge base to local storage."

**AI Response**:
```bash
# Use download_wiki.py for batch Wiki backup (NEW in v0.2.1)
python /path/to/feishu-doc-tools/scripts/download_wiki.py \
  --space-name "Knowledge Base" \
  --output /path/to/backup \
  --parallel \
  --workers 5

# This will preserve the Wiki structure in local files
# Expected: 100-200 Wiki nodes in 2-5 minutes
```

### Scenario 4: Upload and AI Optimize

**User**: "Upload this document and then optimize its formatting with AI."

**AI Response**:
```bash
# Step 1: Upload using feishu-doc-tools
python /path/to/feishu-doc-tools/scripts/create_feishu_doc.py \
  --title "My Document" \
  --file /path/to/document.md \
  --folder-token "your_folder_token"

# Step 2: Use Feishu-MCP for AI optimization
# (Requires Feishu-MCP server running)
# Use batch_create_feishu_blocks for 90% efficiency improvement
```

### Scenario 5: Migrate Documentation from Git to Feishu

**User**: "We want to migrate all our README.md files from GitHub to Feishu."

**AI Response**:
```bash
# Step 1: Clone repository
git clone https://github.com/your-org/repo.git /tmp/repo

# Step 2: Find all README files
find /tmp/repo -name "README.md" -type f

# Step 3: Batch upload to Feishu
python /path/to/feishu-doc-tools/scripts/batch_create_docs.py \
  --source-dir /tmp/repo \
  --file-pattern "README.md" \
  --recursive \
  --parallel \
  --folder-token "your_folder_token"

# Step 4: Clean up
rm -rf /tmp/repo
```

### Scenario 6: Synchronize Local Changes to Feishu

**User**: "I've updated several Markdown files locally. How do I sync them to Feishu?"

**AI Response**:
```bash
# Note: This is a one-way sync (local → Feishu)
# Bidirectional sync is not supported due to complexity

# Option 1: Upload all modified files
python /path/to/feishu-doc-tools/scripts/batch_create_docs.py \
  --source-dir /path/to/docs \
  --recursive \
  --parallel

# Option 2: Upload specific files
python /path/to/feishu-doc-tools/scripts/batch_create_docs.py \
  --files file1.md,file2.md,file3.md \
  --folder-token "your_folder_token"

# For bidirectional workflows, consider manual upload/download cycles
```

### Scenario 7: Download Document by Path

**User**: "I need to download a document from a specific folder path in Feishu."

**AI Response**:
```bash
# Use download_doc.py with path (NEW in v0.2.1)
python /path/to/feishu-doc-tools/scripts/download_doc.py \
  --doc-path "/Folder/Subfolder/Document Name" \
  --space-name "My Space" \
  --output /path/to/document.md
```

### Scenario 8: Batch Upload with Custom Folder Structure

**User**: "I want to upload documents but preserve the local folder structure."

**AI Response**:
```bash
# Use batch_create_docs.py with --preserve-structure
python /path/to/feishu-doc-tools/scripts/batch_create_docs.py \
  --source-dir /path/to/docs \
  --recursive \
  --parallel \
  --preserve-structure \
  --folder-token "root_folder_token"

# This will create matching folders in Feishu
```

### Scenario 9: Download and Convert to Markdown

**User**: "Download a Feishu document and convert it to clean Markdown."

**AI Response**:
```bash
# Step 1: Download document
python /path/to/feishu-doc-tools/scripts/download_doc.py \
  --doc-id "document_id" \
  --output /path/to/document.md

# Step 2: The downloaded file is already in Markdown format
# No additional conversion needed

# Optional: Clean up the Markdown
# Use standard Markdown tools if needed
```

### Scenario 10: Batch Upload with Error Handling

**User**: "Upload hundreds of documents but handle any errors gracefully."

**AI Response**:
```bash
# Use batch_create_docs.py with error handling
python /path/to/feishu-doc-tools/scripts/batch_create_docs.py \
  --source-dir /path/to/docs \
  --recursive \
  --parallel \
  --workers 5 \
  --continue-on-error \
  --error-log /path/to/errors.log \
  --success-log /path/to/success.log

# This will continue even if some uploads fail
# Check error.log for failed uploads
```

## Best Practices

### 1. Use Parallel Processing for Batch Operations

**Recommendation**: Always enable `--parallel` flag for batch operations

```bash
# Good: Parallel processing (5-10x faster)
python batch_create_docs.py --source-dir docs --parallel --workers 5

# Avoid: Serial processing (slow)
python batch_create_docs.py --source-dir docs
```

### 2. Choose the Right Tool for the Job

**Use feishu-doc-tools for**:
- Batch upload/download operations
- High-performance requirements
- Large documents (1000+ blocks)
- Automated scripts and CI/CD

**Use Feishu-MCP for**:
- AI-assisted content editing
- Interactive document modification
- Batch editing with 90% efficiency improvement
- Complex formatting optimization

### 3. Leverage Name-Based Parameters (v0.2.1)

**Recommendation**: Use human-readable names instead of IDs when possible

```bash
# Good: Name-based (easier to read)
python download_doc.py --doc-name "My Document" --space-name "My Space"

# Acceptable: ID-based (faster for scripts)
python download_doc.py --doc-id "abc123"
```

### 4. Preserve Folder Structure for Large Projects

**Recommendation**: Use `--preserve-structure` for complex documentation

```bash
python batch_create_docs.py \
  --source-dir docs \
  --recursive \
  --preserve-structure \
  --folder-token "root_token"
```

### 5. Implement Error Handling for Production

**Recommendation**: Always use error logging for critical workflows

```bash
python batch_create_docs.py \
  --source-dir docs \
  --parallel \
  --continue-on-error \
  --error-log errors.log \
  --success-log success.log
```

### 6. Use Appropriate Worker Counts

**Recommendation**: Adjust worker count based on document size

```bash
# Small documents: More workers
python batch_create_docs.py --workers 10 --source-dir small-docs

# Large documents: Fewer workers
python batch_create_docs.py --workers 3 --source-dir large-docs

# Default: 5 workers (balanced)
python batch_create_docs.py --workers 5 --source-dir docs
```

### 7. Plan for One-Way Sync Workflows

**Important**: Bidirectional sync is not supported

**Recommended Pattern**: Manual upload/download cycles
```bash
# Upload cycle
python batch_create_docs.py --source-dir docs --parallel

# Make changes locally or in Feishu

# Download cycle (if needed)
python download_wiki.py --space-name "Wiki" --output backup/
```

### 8. Test with Small Batches First

**Recommendation**: Always test with a small subset before large operations

```bash
# Test: Upload 2-3 documents first
python batch_create_docs.py \
  --source-dir docs/test \
  --parallel

# Verify: Check uploaded documents

# Proceed: Upload full folder
python batch_create_docs.py \
  --source-dir docs \
  --parallel
```

## Troubleshooting

### Issue 1: Upload Fails with Authentication Error

**Error**: `AuthenticationError: Invalid app credentials`

**Solution**:
```bash
# Check environment variables
echo $FEISHU_APP_ID
echo $FEISHU_APP_SECRET

# Or verify .env file
cat /path/to/feishu-doc-tools/.env

# Re-run setup if needed
python /path/to/feishu-doc-tools/scripts/setup_user_auth.py
```

### Issue 2: Download Fails - Document Not Found

**Error**: `DocumentNotFoundError: Document not found`

**Solution**:
```bash
# Verify document exists
python /path/to/feishu-doc-tools/scripts/get_root_info.py

# Use name-based search instead
python download_doc.py \
  --doc-name "Document Title" \
  --space-name "My Space" \
  --output output.md
```

### Issue 3: Parallel Upload is Slow

**Issue**: Parallel upload is not faster than serial

**Solution**:
```bash
# Adjust worker count
python batch_create_docs.py \
  --source-dir docs \
  --parallel \
  --workers 10  # Increase workers

# Or decrease if network is bottleneck
python batch_create_docs.py \
  --source-dir docs \
  --parallel \
  --workers 3  # Decrease workers
```

### Issue 4: Folder Structure Not Preserved

**Issue**: Uploaded files are in wrong folders

**Solution**:
```bash
# Use --preserve-structure flag
python batch_create_docs.py \
  --source-dir docs \
  --recursive \
  --preserve-structure \
  --folder-token "root_token"
```

### Issue 5: Downloaded Markdown Has Wrong Format

**Issue**: Downloaded document doesn't look like expected Markdown

**Solution**:
```bash
# Check if document was converted
# Feishu documents are block-based, not line-based

# Use feishu_to_md.py for better conversion
python /path/to/feishu-doc-tools/scripts/feishu_to_md.py \
  --input /path/to/raw.json \
  --output /path/to/document.md
```

### Issue 6: Batch Upload Partially Fails

**Issue**: Some documents uploaded, some failed

**Solution**:
```bash
# Check error log
cat /path/to/errors.log

# Re-upload failed documents only
python batch_create_docs.py \
  --files failed1.md,failed2.md \
  --folder-token "your_token"
```

### Issue 7: Wiki Download is Incomplete

**Issue**: Not all Wiki nodes were downloaded

**Solution**:
```bash
# Check Wiki structure first
python /path/to/feishu-doc-tools/scripts/list_wiki_tree.py \
  --space-name "My Wiki"

# Re-run download with verbose output
python download_wiki.py \
  --space-name "My Wiki" \
  --output backup/ \
  --verbose
```

### Issue 8: Permission Denied Error

**Error**: `PermissionError: Insufficient permissions`

**Solution**:
```bash
# Verify user authentication
python /path/to/feishu-doc-tools/scripts/verify_user_auth.py

# Check folder permissions
python /path/to/feishu-doc-tools/scripts/list_folders.py

# Use correct authentication mode
# For Wiki operations, user authentication is required
```

## Performance Optimization Tips

### 1. Use Batch Operations

**Single Document**: Use `create_feishu_doc.py`
**Multiple Documents**: Use `batch_create_docs.py` with `--parallel`

### 2. Optimize Worker Count

- **CPU-bound**: Set workers = CPU cores
- **Network-bound**: Set workers = 5-10
- **Mixed**: Set workers = 3-5 (default)

### 3. Use Name-Based Resolution Sparingly

**ID-based**: Faster (single API call)
**Name-based**: Slower (search required)

Use name-based for human interaction, ID-based for scripts.

### 4. Leverage Connection Pooling

feishu-doc-tools automatically uses connection pooling (1.2-1.5x improvement).

No additional configuration needed.

### 5. Use Appropriate File Patterns

```bash
# Good: Specific file types
python batch_create_docs.py --file-pattern "*.md"

# Avoid: All files
python batch_create_docs.py --file-pattern "*"
```

## Reference

### feishu-doc-tools Commands

**Upload**:
- `create_feishu_doc.py` - Single document upload
- `batch_create_docs.py` - Batch folder upload

**Download** (NEW v0.2.1):
- `download_doc.py` - Single document download
- `download_wiki.py` - Batch Wiki download
- `feishu_to_md.py` - Format conversion

**Wiki**:
- `list_wiki_tree.py` - Wiki structure preview
- `create_wiki_doc.py` - Create Wiki node
- `batch_create_wiki_docs.py` - Batch Wiki creation

**Utility**:
- `get_root_info.py` - Workspace information
- `list_folders.py` - Folder structure
- `test_api_connectivity.py` - Connection test

### Feishu-MCP Tools

**Core Operations**:
- `create_feishu_document` - Create document or Wiki node
- `get_feishu_document_info` - Get document metadata
- `get_feishu_document_blocks` - Get block structure
- `batch_create_feishu_blocks` - Batch block creation (90% efficiency) ⭐

**Editing**:
- `update_feishu_block_text` - Update block content
- `delete_feishu_document_blocks` - Delete blocks
- `upload_and_bind_image_to_block` - Upload images

### Performance Benchmarks

**Upload Performance** (feishu-doc-tools):
| Size | Serial | Parallel (5w) | Speedup |
|------|--------|---------------|---------|
| <50 blocks | 3s | 2s | 1.5x |
| 50-200 | 30s | 8s | 3.8x |
| 200-1000 | 180s | 30s | 6x |
| 1000+ | 600s | 75s | 8x |

**Download Performance** (feishu-doc-tools v0.2.1):
| Docs | Time | Throughput |
|------|------|------------|
| <10 | 5s | 2 docs/s |
| 10-50 | 30s | 1.5 docs/s |
| 50-100 | 90s | 1 doc/s |
| 100+ | 3min | 0.6 docs/s |

**Wiki Traversal Performance**:
| Nodes | Sequential | Parallel (5w) | Speedup |
|-------|-----------|---------------|---------|
| <10 | 1s | 0.3s | 3x |
| 10-50 | 8s | 2s | 4x |
| 50-100 | 30s | 6s | 5x |
| 100+ | 60s+ | 10s | 6x+ |

## Related Skills

- **feishu-wiki-manager**: Wiki-specific operations with structure awareness
- **feishu-ai-editor**: AI-powered document editing and optimization
- **feishu-workflow-automation**: CI/CD integration and automated backups

---

**Last Updated**: 2026-01-19
**Version**: v0.2
**Requires**: feishu-doc-tools v0.2.1+, Feishu-MCP v0.1.8+
