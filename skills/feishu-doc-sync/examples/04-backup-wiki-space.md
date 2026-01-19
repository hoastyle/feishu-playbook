# Example: Backup Wiki Space

## Scenario
An IT admin needs to backup an entire Wiki knowledge base before a major update, ensuring all documentation is safely stored locally.

## User Request
**User**: "We're planning a major update to our Knowledge Base Wiki next week. I need to backup everything first - all pages, subpages, everything. How do I do a complete backup?"

## AI Agent Response

I'll help you backup the entire Wiki space using feishu-doc-tools v0.2.1's batch download feature with parallel processing.

**Step 1: Preview Wiki structure first (recommended)**
```bash
# See what you're backing up
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/list_wiki_tree.py \
  --space-name "Knowledge Base" \
  --parallel
```

**Step 2: Batch download entire Wiki**
```bash
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/download_wiki.py \
  --space-name "Knowledge Base" \
  --output /backups/knowledge-base-2026-01-19 \
  --parallel \
  --preserve-structure
```

## Command Executed

```bash
# Step 1: Preview structure
cd $(dirname /home/user/feishu-doc-tools/scripts/list_wiki_tree.py) && uv run python /home/user/feishu-doc-tools/scripts/list_wiki_tree.py \
  --space-name "Knowledge Base" \
  --parallel \
  --output wiki-structure.json

# Step 2: Download everything
cd $(dirname /home/user/feishu-doc-tools/scripts/download_wiki.py) && uv run python /home/user/feishu-doc-tools/scripts/download_wiki.py \
  --space-name "Knowledge Base" \
  --output /home/user/backups/kb-backup-2026-01-19 \
  --parallel \
  --workers 5 \
  --preserve-structure \
  --download-images
```

## Expected Output

### Step 1: Preview Output
```
[INFO] Fetching Wiki space: Knowledge Base
[INFO] Space ID: 7481234567890
[INFO] Starting parallel tree traversal...

Wiki Structure:
Knowledge Base (73 nodes)
├── Engineering (25 nodes)
│   ├── Backend (12 nodes)
│   │   ├── API Documentation
│   │   ├── Database Schema
│   │   └── ...
│   ├── Frontend (8 nodes)
│   └── DevOps (5 nodes)
├── Product (18 nodes)
│   ├── Requirements
│   ├── Design Specs
│   └── ...
└── Operations (30 nodes)
    ├── Runbooks
    ├── Incident Reports
    └── ...

[SUCCESS] Wiki structure saved to: wiki-structure.json
Total nodes: 73
Traversal time: 3.2s (parallel)
```

### Step 2: Backup Output
```
[INFO] Starting Wiki backup...
[INFO] Source: Knowledge Base (73 nodes)
[INFO] Destination: /home/user/backups/kb-backup-2026-01-19
[INFO] Parallel download with 5 workers

Download Progress:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 100% 73/73

Backup Summary:
┏━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━┓
┃ Category                ┃ Count  ┃
┡━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━┩
│ Wiki nodes downloaded   │ 73     │
│ Markdown files created  │ 73     │
│ Images downloaded       │ 156    │
│ Total size              │ 45.2MB │
│ Failed downloads        │ 0      │
└─────────────────────────┴────────┘

Performance:
- Total time: 2m 15s
- Average: 1.8s per node
- Throughput: ~32 nodes/min
- Speedup: 4.5x (vs serial: 10m 8s)

[SUCCESS] Wiki backup completed!
Backup location: /home/user/backups/kb-backup-2026-01-19
```

## Result

✅ **Successfully backed up entire Knowledge Base Wiki**

**Backup Statistics**:
- Total wiki nodes: 73
- Markdown files: 73
- Images: 156
- Total size: 45.2 MB
- Backup time: 2m 15s
- **Performance**: 4.5x faster than serial backup

**Backup Structure**:
```
kb-backup-2026-01-19/
├── Engineering/
│   ├── Backend/
│   │   ├── API-Documentation.md
│   │   ├── Database-Schema.md
│   │   └── images/
│   ├── Frontend/
│   └── DevOps/
├── Product/
│   ├── Requirements.md
│   ├── Design-Specs.md
│   └── images/
├── Operations/
│   ├── Runbooks/
│   └── Incident-Reports/
├── wiki-structure.json   # Full hierarchy
└── backup-manifest.json  # Backup metadata
```

## Backup Verification

```bash
# Verify backup completeness
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/verify_backup.py \
  --backup-dir /home/user/backups/kb-backup-2026-01-19 \
  --space-name "Knowledge Base"

# Expected output:
# ✅ All 73 wiki nodes verified
# ✅ All 156 images present
# ✅ Backup is complete and valid
```

## Restore Options

### Option 1: Selective restore
```bash
# Restore specific section only
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/batch_create_wiki_docs.py \
  --source-dir /backups/kb-backup-2026-01-19/Engineering \
  --space-name "Knowledge Base" \
  --parent-node-path "/Engineering" \
  --parallel
```

### Option 2: Full restore to new space
```bash
# Create new Wiki space and restore everything
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/restore_wiki_backup.py \
  --backup-dir /backups/kb-backup-2026-01-19 \
  --new-space-name "Knowledge Base (Restored)" \
  --parallel
```

## Automated Backup Schedule

### Daily backup script
```bash
#!/bin/bash
# wiki-backup-daily.sh

DATE=$(date +%Y-%m-%d)
BACKUP_DIR="/backups/wiki/daily/$DATE"

# Backup Wiki
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/download_wiki.py \
  --space-name "Knowledge Base" \
  --output "$BACKUP_DIR" \
  --parallel \
  --workers 5 \
  --preserve-structure \
  --download-images

# Verify backup
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/verify_backup.py \
  --backup-dir "$BACKUP_DIR" \
  --space-name "Knowledge Base"

# Compress backup
tar -czf "$BACKUP_DIR.tar.gz" "$BACKUP_DIR"

# Clean up old backups (keep last 30 days)
find /backups/wiki/daily -type f -name "*.tar.gz" -mtime +30 -delete

echo "Backup completed: $BACKUP_DIR.tar.gz"
```

### Cron schedule
```bash
# Add to crontab
# Backup every day at 2 AM
0 2 * * * /path/to/wiki-backup-daily.sh >> /var/log/wiki-backup.log 2>&1
```

## Advanced Features

### Incremental backup
```bash
# Only backup changed nodes since last backup
uv run python download_wiki.py \
  --space-name "Knowledge Base" \
  --output /backups/kb-incremental \
  --incremental \
  --since "2026-01-15" \
  --parallel
```

### Backup with metadata
```bash
# Include full metadata (authors, timestamps, comments)
uv run python download_wiki.py \
  --space-name "Knowledge Base" \
  --output /backups/kb-full \
  --include-metadata \
  --include-comments \
  --parallel
```

### Multi-space backup
```bash
# Backup multiple Wiki spaces
for space in "Knowledge Base" "Product Docs" "Engineering Wiki"; do
  uv run python download_wiki.py \
    --space-name "$space" \
    --output "/backups/$space-$(date +%Y-%m-%d)" \
    --parallel
done
```

## Troubleshooting

**If backup is slow**:
```bash
# Increase worker count
uv run python download_wiki.py \
  --space-name "Knowledge Base" \
  --output /backups/kb \
  --parallel \
  --workers 8  # Increase from default 5
```

**If some nodes fail to download**:
```bash
# Check error log
cat /backups/kb-backup/download-errors.log

# Retry failed nodes only
uv run python download_wiki.py \
  --space-name "Knowledge Base" \
  --output /backups/kb \
  --retry-failed download-errors.log \
  --parallel
```

**If images are missing**:
```bash
# Download images separately
uv run python download_wiki_images.py \
  --wiki-backup /backups/kb-backup \
  --images-dir /backups/kb-backup/images \
  --parallel
```

## Best Practices

1. **Preview first**: Always preview structure before backup
2. **Verify backup**: Run verification after backup completes
3. **Compress backups**: Use tar.gz to save space
4. **Automate**: Set up scheduled backups with cron
5. **Test restore**: Periodically test restore process
6. **Document backup**: Keep backup logs and manifests
7. **Off-site copy**: Store backups in different location

## Performance Optimization

| Wiki Size | Serial Time | Parallel (5w) | Speedup |
|-----------|-------------|---------------|---------|
| Small (<20 nodes) | 30s | 10s | 3x |
| Medium (20-100 nodes) | 3m | 40s | 4.5x |
| Large (100-500 nodes) | 15m | 3m | 5x |
| Very Large (500+ nodes) | 60m+ | 10m | 6x+ |

## Related Examples

- [01-upload-single-doc.md](./01-upload-single-doc.md) - Upload after restore
- [02-batch-upload-folder.md](./02-batch-upload-folder.md) - Restore from backup
- See also: [skills/feishu-wiki-manager/examples/](../../feishu-wiki-manager/examples/)
