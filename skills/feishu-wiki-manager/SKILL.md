---
name: feishu-wiki-manager
description: Manage Feishu Wiki knowledge base with structure awareness. Use when user wants to create Wiki nodes, preview Wiki structure, batch download Wiki for backup, or organize Wiki documentation. Integrates feishu-doc-tools v0.2.1 for Wiki structure preview and batch download, with Feishu-MCP for AI-assisted editing.
---

# Feishu Wiki Manager Skill

## Overview

The **feishu-wiki-manager** skill provides comprehensive Wiki knowledge base management with structure awareness. It combines the high-performance Wiki operations of **feishu-doc-tools v0.2.1** (including NEW Wiki structure preview and batch download) with the AI-powered editing capabilities of **Feishu-MCP**.

### Key Features

- **Wiki Structure Preview**: NEW in v0.2.1 - visualize Wiki hierarchy as tree structure
- **Batch Wiki Download**: NEW in v0.2.1 - backup entire Wiki spaces locally
- **Parallel Wiki Traversal**: 3-5x performance improvement with parallel processing
- **Batch Wiki Creation**: Create multiple Wiki nodes efficiently
- **AI-Assisted Editing**: Use Feishu-MCP for intelligent content modification
- **Name-Based Resolution**: Use human-readable names instead of IDs (v0.2.1)

### Performance Benchmarks

**Wiki Tree Traversal**:
| Wiki Nodes | Sequential | Parallel (5w) | Speedup |
|------------|-----------|---------------|---------|
| Small (<10) | 1s | 0.3s | 3x |
| Medium (10-50) | 8s | 2s | 4x |
| Large (50-100) | 30s | 6s | 5x |
| Very Large (100+) | 60s+ | 10s | 6x+ |

**Wiki Download**:
| Documents | Time | Throughput |
|-----------|------|------------|
| <10 | 5s | 2 docs/s |
| 10-50 | 30s | 1.5 docs/s |
| 50-100 | 90s | 1 doc/s |
| 100+ | 3min | 0.6 docs/s |

### Tool Selection Strategy

**Use feishu-doc-tools for**:
- Wiki structure preview and visualization
- Batch Wiki creation and upload
- Batch Wiki download for backup
- High-performance operations

**Use Feishu-MCP for**:
- AI-assisted content editing
- Intelligent Wiki node modification
- Format optimization and restructuring

## Quick Start

### Preview Wiki Structure (NEW v0.2.1)

```bash
# Visualize Wiki space as tree structure
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/list_wiki_tree.py \
  --space-name "Knowledge Base" \
  --parallel
```

### Create a Wiki Node

```bash
# Create single Wiki node using name-based parameters
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/create_wiki_doc.py \
  --title "My Wiki Page" \
  --file /path/to/content.md \
  --space-name "Knowledge Base" \
  --parent-node-path "/Parent/Child"
```

### Batch Download Wiki (NEW v0.2.1)

```bash
# Download entire Wiki space for backup
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/download_wiki.py \
  --space-name "Knowledge Base" \
  --output /path/to/backup \
  --parallel
```

### Batch Create Wiki Nodes

```bash
# Create multiple Wiki nodes from folder
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/batch_create_wiki_docs.py \
  --source-dir /path/to/wiki/content \
  --space-name "Knowledge Base" \
  --recursive \
  --parallel
```

## Common Scenarios

### Scenario 1: Preview Wiki Structure Before Upload

**User**: "I want to see the current structure of our Wiki before uploading new content."

**AI Response**:
```bash
# Use list_wiki_tree.py to visualize Wiki structure (NEW in v0.2.1)
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/list_wiki_tree.py \
  --space-name "Knowledge Base" \
  --parallel \
  --workers 5

# Output: Tree structure visualization
# Knowledge Base/
# ├── Engineering/
# │   ├── Backend/
# │   └── Frontend/
# ├── Product/
# │   └── Roadmap/
# └── HR/
#     └── Policies/
```

### Scenario 2: Backup Entire Wiki Space

**User**: "I need to backup our entire Knowledge Base Wiki to local storage."

**AI Response**:
```bash
# Use download_wiki.py for complete Wiki backup (NEW in v0.2.1)
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/download_wiki.py \
  --space-name "Knowledge Base" \
  --output /path/to/backup \
  --parallel \
  --workers 5

# Expected performance: 100-200 Wiki nodes in 2-5 minutes
# Output: Local directory structure matching Wiki hierarchy
```

### Scenario 3: Create Wiki Node with Parent

**User**: "Create a new Wiki page under 'Engineering/Backend' in our Knowledge Base."

**AI Response**:
```bash
# Create Wiki node with parent path
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/create_wiki_doc.py \
  --title "API Design Guidelines" \
  --file /path/to/api-guidelines.md \
  --space-name "Knowledge Base" \
  --parent-node-path "/Engineering/Backend"

# Alternative: Use parent-token if known
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/create_wiki_doc.py \
  --title "API Design Guidelines" \
  --file /path/to/api-guidelines.md \
  --space-id "your_space_id" \
  --parent-token "parent_node_token"
```

### Scenario 4: Batch Upload Wiki Content

**User**: "I have a folder of Markdown files organized by topic. Upload them to Wiki preserving structure."

**AI Response**:
```bash
# Use batch_create_wiki_docs.py with structure preservation
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/batch_create_wiki_docs.py \
  --source-dir /path/to/wiki/content \
  --space-name "Knowledge Base" \
  --recursive \
  --parallel \
  --workers 5 \
  --preserve-structure

# This will:
# 1. Traverse local directory structure
# 2. Create matching Wiki node hierarchy
# 3. Upload content to corresponding nodes
# 4. Use parallel processing for speed
```

### Scenario 5: Download Specific Wiki Subtree

**User**: "I only need to download the 'Engineering' section of our Wiki."

**AI Response**:
```bash
# First, find the node token for Engineering
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/list_wiki_tree.py \
  --space-name "Knowledge Base" \
  --filter "Engineering"

# Then download from that node
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/download_wiki.py \
  --space-name "Knowledge Base" \
  --root-node-token "engineering_node_token" \
  --output /path/to/backup/engineering \
  --parallel
```

### Scenario 6: Edit Wiki Content with AI

**User**: "Optimize the formatting of this Wiki page using AI."

**AI Response**:
```bash
# Step 1: Get current Wiki content
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/download_doc.py \
  --doc-name "My Wiki Page" \
  --space-name "Knowledge Base" \
  --output /tmp/current.md

# Step 2: Use Feishu-MCP for AI optimization
# (Requires Feishu-MCP server running)
# Use batch_create_feishu_blocks for 90% efficiency improvement

# Step 3: Upload optimized content
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/create_wiki_doc.py \
  --title "My Wiki Page" \
  --file /tmp/optimized.md \
  --space-name "Knowledge Base" \
  --parent-node-token "parent_token"
```

### Scenario 7: Reorganize Wiki Structure

**User**: "I want to reorganize our Wiki structure. Can I preview the changes first?"

**AI Response**:
```bash
# Step 1: Download current Wiki structure
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/list_wiki_tree.py \
  --space-name "Knowledge Base" \
  --output /tmp/current-structure.json

# Step 2: Plan reorganization locally
# Edit /tmp/current-structure.json to design new structure

# Step 3: Create new Wiki nodes with new structure
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/batch_create_wiki_docs.py \
  --source-dir /tmp/new-structure \
  --space-name "Knowledge Base (New)" \
  --parallel

# Step 4: Verify and migrate content
# (Manual process for safety)
```

### Scenario 8: Sync Local Wiki Content to Feishu

**User**: "I've been maintaining Wiki content locally in Git. How do I sync to Feishu Wiki?"

**AI Response**:
```bash
# Use batch_create_wiki_docs.py for one-way sync (local → Feishu)
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/batch_create_wiki_docs.py \
  --source-dir /path/to/local/wiki \
  --space-name "Knowledge Base" \
  --recursive \
  --parallel \
  --update-existing

# Note: This is one-way sync (local → Feishu)
# For bidirectional sync, consider manual cycles:
# 1. Download from Feishu
# 2. Merge changes locally
# 3. Upload back to Feishu
```

### Scenario 9: Find Wiki Node by Name

**User**: "I need to find a specific Wiki page but only remember the title."

**AI Response**:
```bash
# Use list_wiki_tree.py with search filter
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/list_wiki_tree.py \
  --space-name "Knowledge Base" \
  --search "API Guidelines" \
  --output /tmp/search-results.json

# Alternative: Use Feishu-MCP search
# (Requires Feishu-MCP server)
```

### Scenario 10: Scheduled Wiki Backup

**User**: "Set up automated daily backups of our Wiki."

**AI Response**:
```bash
# Create backup script
cat > /usr/local/bin/backup-wiki.sh << 'EOF'
#!/bin/bash
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/download_wiki.py \
  --space-name "Knowledge Base" \
  --output /backup/wiki/$(date +%Y%m%d) \
  --parallel \
  --workers 5

# Keep last 30 days only
find /backup/wiki -type d -mtime +30 -exec rm -rf {} \;
EOF

chmod +x /usr/local/bin/backup-wiki.sh

# Add to crontab for daily execution at 2 AM
(crontab -l 2>/dev/null; echo "0 2 * * * /usr/local/bin/backup-wiki.sh") | crontab -
```

## Best Practices

### 1. Preview Wiki Structure Before Operations

**Recommendation**: Always visualize Wiki structure before bulk operations

```bash
# Good: Preview first
python list_wiki_tree.py --space-name "Wiki" --parallel

# Then proceed with operations
python batch_create_wiki_docs.py --source-dir docs --space-name "Wiki"
```

### 2. Use Name-Based Parameters for Readability

**Recommendation**: Use `--space-name` and `--parent-node-path` when possible

```bash
# Good: Human-readable
python create_wiki_doc.py \
  --space-name "Knowledge Base" \
  --parent-node-path "/Engineering/Backend"

# Acceptable: ID-based (for scripts)
python create_wiki_doc.py \
  --space-id "123456" \
  --parent-token "abc123"
```

### 3. Leverage Parallel Processing for Large Wikis

**Recommendation**: Enable parallel processing for Wiki spaces with 50+ nodes

```bash
# Good: Parallel processing (3-5x faster)
uv run python download_wiki.py --space-name "Wiki" --parallel --workers 5

# Avoid: Sequential processing (slow)
uv run python download_wiki.py --space-name "Wiki"
```

### 4. Preserve Directory Structure for Batch Uploads

**Recommendation**: Use `--preserve-structure` to maintain Wiki hierarchy

```bash
python batch_create_wiki_docs.py \
  --source-dir /path/to/wiki \
  --space-name "Wiki" \
  --recursive \
  --preserve-structure \
  --parallel
```

### 5. Test Wiki Operations with Small Samples

**Recommendation**: Test with 2-3 nodes before large batch operations

```bash
# Test: Create 2-3 Wiki nodes first
python batch_create_wiki_docs.py \
  --source-dir wiki/test \
  --space-name "Test Wiki" \
  --parallel

# Verify: Check created Wiki nodes

# Proceed: Create full Wiki
python batch_create_wiki_docs.py \
  --source-dir wiki \
  --space-name "Production Wiki" \
  --parallel
```

### 6. Implement Regular Wiki Backups

**Recommendation**: Schedule automated backups for critical Wiki spaces

```bash
# Daily backup script
uv run python download_wiki.py \
  --space-name "Knowledge Base" \
  --output /backup/wiki/$(date +%Y%m%d) \
  --parallel
```

### 7. Use Appropriate Tools for Wiki vs Documents

**Important**: Wiki nodes are different from regular documents

| Feature | Wiki Node | Regular Document |
|---------|-----------|------------------|
| Container | Can contain child nodes | Cannot contain children |
| ID Types | node_token + obj_token | Only document_id |
| Operations | Use Wiki-specific tools | Use document tools |
| Permissions | Wiki-specific permissions | Folder permissions |

### 8. Combine Tools for Complete Workflows

**Recommended Pattern**:
```bash
# Step 1: Preview structure (feishu-doc-tools)
python list_wiki_tree.py --space-name "Wiki"

# Step 2: Download content (feishu-doc-tools)
uv run python download_wiki.py --space-name "Wiki" --output backup/

# Step 3: Edit with AI (Feishu-MCP)
# Use Feishu-MCP for intelligent content modification

# Step 4: Upload back (feishu-doc-tools)
python batch_create_wiki_docs.py --source-dir backup/ --space-name "Wiki"
```

## Troubleshooting

### Issue 1: Wiki Structure Preview Fails

**Error**: `WikiSpaceNotFoundError: Wiki space not found`

**Solution**:
```bash
# List available Wiki spaces
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/get_root_info.py

# Verify space name
python list_wiki_tree.py \
  --space-name "Correct Space Name" \
  --parallel
```

### Issue 2: Parent Node Not Found

**Error**: `ParentNodeNotFoundError: Parent node not found`

**Solution**:
```bash
# Preview Wiki structure to find correct path
python list_wiki_tree.py \
  --space-name "Wiki" \
  --output structure.json

# Use exact path from structure
python create_wiki_doc.py \
  --parent-node-path "/Exact/Path/From/Tree"
```

### Issue 3: Wiki Download is Incomplete

**Issue**: Not all Wiki nodes were downloaded

**Solution**:
```bash
# Check Wiki structure first
python list_wiki_tree.py --space-name "Wiki"

# Re-run with verbose output
uv run python download_wiki.py \
  --space-name "Wiki" \
  --output backup/ \
  --verbose \
  --parallel
```

### Issue 4: Batch Wiki Creation Fails Midway

**Issue**: Some Wiki nodes created, some failed

**Solution**:
```bash
# Check error log
cat /path/to/wiki-upload-errors.log

# Re-run failed nodes only
python batch_create_wiki_docs.py \
  --source-dir failed/nodes \
  --space-name "Wiki" \
  --continue-on-error
```

### Issue 5: Permission Denied for Wiki Operations

**Error**: `PermissionError: Insufficient Wiki permissions`

**Solution**:
```bash
# Verify user authentication (required for Wiki)
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/verify_user_auth.py

# Wiki operations require user authentication, not tenant authentication
# Run setup if needed
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/setup_user_auth.py
```

### Issue 6: Wiki Structure Tree is Too Large

**Issue**: Tree output is overwhelming

**Solution**:
```bash
# Filter to specific subtree
python list_wiki_tree.py \
  --space-name "Wiki" \
  --root-node-path "/Engineering" \
  --max-depth 3

# Or export to JSON for programmatic analysis
python list_wiki_tree.py \
  --space-name "Wiki" \
  --output wiki-structure.json
```

### Issue 7: Parallel Wiki Operations are Slow

**Issue**: Parallel processing is not faster

**Solution**:
```bash
# Adjust worker count
uv run python download_wiki.py \
  --space-name "Wiki" \
  --workers 10 \
  --parallel

# Or decrease if network is bottleneck
uv run python download_wiki.py \
  --space-name "Wiki" \
  --workers 3 \
  --parallel
```

### Issue 8: Wiki Node Confusion (node_token vs obj_token)

**Issue**: Not sure which ID to use for Wiki operations

**Solution**:
```bash
# Remember:
# - node_token: Use for creating child nodes, traversing hierarchy
# - obj_token: Use for editing document content

# Get both tokens from list_wiki_tree.py
python list_wiki_tree.py \
  --space-name "Wiki" \
  --output wiki-details.json

# Output includes both tokens for each node
```

## Wiki vs Document: Key Differences

### Conceptual Differences

**Wiki Nodes**:
- Act as containers for other nodes
- Have hierarchical structure
- Two types of IDs: `node_token` and `obj_token`
- Represent knowledge base structure

**Regular Documents**:
- Standalone documents
- Flat structure (folders only)
- Single document ID
- Represent individual files

### Operation Differences

| Operation | Wiki Node | Regular Document |
|-----------|-----------|------------------|
| Create | `create_wiki_doc.py` | `create_feishu_doc.py` |
| List | `list_wiki_tree.py` | `list_folders.py` |
| Download | `download_wiki.py` | `download_doc.py` |
| Batch Create | `batch_create_wiki_docs.py` | `batch_create_docs.py` |

### ID System

**Wiki Node IDs**:
```python
{
  "node_token": "used_for_creating_children",
  "obj_token": "used_for_editing_content"
}
```

**Regular Document IDs**:
```python
{
  "document_id": "used_for_all_operations"
}
```

## Performance Optimization Tips

### 1. Use Parallel Wiki Traversal

**Sequential**: 1s per level
**Parallel**: 0.3s per level (3x speedup)

```bash
python list_wiki_tree.py --space-name "Wiki" --parallel --workers 5
```

### 2. Optimize Worker Count

- **Small Wikis (<50 nodes)**: 3-5 workers
- **Medium Wikis (50-100 nodes)**: 5-10 workers
- **Large Wikis (100+ nodes)**: 10-20 workers

### 3. Leverage Connection Pooling

feishu-doc-tools automatically uses connection pooling (1.2-1.5x improvement).

### 4. Use Incremental Backups

Instead of full Wiki backup, backup only changed nodes:

```bash
# Get last backup timestamp
LAST_BACKUP=$(date -d "7 days ago" +%Y%m%d)

# Download only recent changes (if supported by API)
uv run python download_wiki.py \
  --space-name "Wiki" \
  --output backup/incremental \
  --modified-after "$LAST_BACKUP"
```

## Reference

### feishu-doc-tools Wiki Commands

**Wiki Structure** (NEW v0.2.1):
- `list_wiki_tree.py` - Preview Wiki structure as tree
- `download_wiki.py` - Batch download Wiki space

**Wiki Creation**:
- `create_wiki_doc.py` - Create single Wiki node
- `batch_create_wiki_docs.py` - Batch create Wiki nodes

**Wiki Utilities**:
- `get_root_info.py` - List available Wiki spaces
- WikiOperations library - Shared Wiki operations

### Feishu-MCP Wiki Tools

**Core Operations**:
- `create_feishu_document` - Create Wiki node (with wikiContext)
- `get_feishu_document_info` - Get Wiki node metadata
- `get_feishu_document_blocks` - Get Wiki content blocks

**Editing**:
- `batch_create_feishu_blocks` - Batch edit Wiki content
- `update_feishu_block_text` - Update specific block

### Parameter Reference

**Name-Based Parameters** (v0.2.1):
- `--space-name`: Human-readable Wiki space name
- `--wiki-path`: Path to Wiki node (e.g., "/Engineering/Backend")
- `--parent-node-path`: Path to parent node

**ID-Based Parameters**:
- `--space-id`: Numeric Wiki space ID
- `--parent-node-token`: Parent node's token
- `--node-token`: Specific Wiki node token

## Related Skills

- **feishu-doc-sync**: General document upload/download operations
- **feishu-ai-editor**: AI-powered content editing and optimization
- **feishu-workflow-automation**: Automated Wiki backups and CI/CD integration

---

**Last Updated**: 2026-01-19
**Version**: v0.2
**Requires**: feishu-doc-tools v0.2.1+, Feishu-MCP v0.1.8+
