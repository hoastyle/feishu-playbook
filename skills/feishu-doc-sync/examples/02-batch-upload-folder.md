# Example: Batch Upload Documentation Folder

## Scenario
A team has a `/docs` folder with 50+ Markdown files and wants to upload everything to Feishu efficiently.

## User Request
**User**: "We have a documentation folder with about 50 Markdown files. I need to upload all of them to Feishu. What's the fastest way to do this?"

## AI Agent Response

I'll help you batch upload the entire folder using feishu-doc-tools with parallel processing for 5-10x speedup.

**Step 1: Check folder structure**
```bash
# See what's in the docs folder
tree docs -L 2
# or
find docs -name "*.md" | head -20
```

**Step 2: Batch upload with parallel processing**
```bash
python /path/to/feishu-doc-tools/scripts/batch_create_docs.py \
  --source-dir docs \
  --recursive \
  --parallel \
  --workers 5 \
  --folder-token "fldcnxxxxxxxxxxx"
```

## Command Executed

```bash
python /home/user/feishu-doc-tools/scripts/batch_create_docs.py \
  --source-dir /home/user/project/docs \
  --recursive \
  --parallel \
  --workers 5 \
  --folder-token "fldcn1234567890abcdef"
```

## Expected Output

```
[INFO] Scanning directory: /home/user/project/docs
[INFO] Found 52 Markdown files
[INFO] Starting parallel upload with 5 workers...

Progress:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 100% 52/52

Upload Summary:
┏━━━━━━━━━━━━━━━━━━━┳━━━━━━━━┓
┃ Status            ┃ Count  ┃
┡━━━━━━━━━━━━━━━━━━━╇━━━━━━━━┩
│ ✅ Success        │ 50     │
│ ⚠️  Warning       │ 2      │
│ ❌ Failed         │ 0      │
│ Total             │ 52     │
└───────────────────┴────────┘

Performance:
- Total time: 1m 45s
- Average: 2.0s per file
- Throughput: ~30 files/min
- Speedup: 5.7x (vs serial: 9m 50s)

Warnings:
- docs/old/deprecated.md: File is empty, skipped
- docs/images/diagram.md: File is not valid Markdown, skipped

[SUCCESS] Batch upload completed!
View all documents at: https://example.feishu.cn/drive/folder/fldcn1234567890
```

## Result

✅ **Successfully uploaded 50 documents in 1 minute 45 seconds**

**Upload Statistics**:
- Total files: 52
- Successfully uploaded: 50
- Skipped: 2 (empty or invalid)
- Total time: 1m 45s
- Average time per file: 2.0s
- **Performance gain**: 5.7x faster than serial upload

**Documents created**:
All documents are now available in the Feishu folder:
https://example.feishu.cn/drive/folder/fldcn1234567890

## Performance Comparison

| Method | Time | Throughput | Speedup |
|--------|------|------------|---------|
| Serial upload | 9m 50s | 5 files/min | 1x |
| Parallel (5 workers) | 1m 45s | 30 files/min | **5.7x** ⭐ |

## Next Steps

**Recommended actions**:

1. **Verify uploads**: Check the Feishu folder to ensure all files are present
2. **Handle warnings**: Review skipped files and fix issues
3. **Organize structure**: Arrange documents in logical folders

**Organize uploaded documents**:
```bash
# If you want to maintain folder structure
python batch_create_docs.py \
  --source-dir docs \
  --maintain-structure \
  --parallel
```

## Advanced Usage

### Custom folder structure
```bash
# Upload with custom mapping
python batch_create_docs.py \
  --source-dir docs \
  --folder-mapping "api:fldcn111,guides:fldcn222" \
  --parallel
```

### Dry run mode
```bash
# Test before actual upload
python batch_create_docs.py \
  --source-dir docs \
  --dry-run \
  --validate-only
```

### With error logging
```bash
# Log errors to file
python batch_create_docs.py \
  --source-dir docs \
  --parallel \
  --error-log upload_errors.log
```

## Troubleshooting

**If some uploads fail**:
```bash
# Check error log
cat upload_errors.log

# Retry failed uploads only
python batch_create_docs.py \
  --retry-failed upload_errors.log \
  --parallel
```

**If parallel upload is too aggressive**:
```bash
# Reduce number of workers
python batch_create_docs.py \
  --source-dir docs \
  --parallel \
  --workers 3  # Reduce from 5 to 3
```

**If rate limit errors occur**:
```bash
# Add delay between uploads
python batch_create_docs.py \
  --source-dir docs \
  --parallel \
  --workers 3 \
  --rate-limit-delay 0.5  # 500ms delay
```

## Performance Optimization Tips

1. **Optimal worker count**: 5-8 workers for most cases
2. **Network bandwidth**: Ensure stable internet connection
3. **File size**: Group small files together, handle large files separately
4. **Rate limits**: Be mindful of Feishu API rate limits

## Related Examples

- [01-upload-single-doc.md](./01-upload-single-doc.md) - Upload single file
- [05-migrate-docs-from-git.md](./05-migrate-docs-from-git.md) - Migrate from Git
- [08-batch-upload-with-error-handling.md](./08-batch-upload-with-error-handling.md) - Advanced error handling
