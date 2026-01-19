# Example: Download Document for Offline Editing

## Scenario
A technical writer wants to download a Feishu document to edit locally with their preferred Markdown editor.

## User Request
**User**: "I have a document in Feishu called 'Installation Guide' that I want to edit locally in VS Code. How do I download it?"

## AI Agent Response

I'll help you download the document from Feishu to local Markdown using feishu-doc-tools v0.2.1 download feature.

**Step 1: Find the document**

You can download by name (recommended) or by ID:

```bash
# Option 1: Download by name (NEW in v0.2.1)
python /path/to/feishu-doc-tools/scripts/download_doc.py \
  --doc-name "Installation Guide" \
  --output installation-guide.md

# Option 2: Download by ID (if you have it)
python /path/to/feishu-doc-tools/scripts/download_doc.py \
  --doc-id "doccnABCDEF1234567890" \
  --output installation-guide.md
```

## Command Executed

```bash
python /home/user/feishu-doc-tools/scripts/download_doc.py \
  --doc-name "Installation Guide" \
  --output /home/user/projects/docs/installation-guide.md
```

## Expected Output

```
[INFO] Searching for document: "Installation Guide"
[INFO] Found document: Installation Guide (doccnABCDEF1234567890)
[INFO] Downloading document content...
[INFO] Converting to Markdown...

Download Progress:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 100%

Conversion Summary:
┏━━━━━━━━━━━━━━━━━━━┳━━━━━━━━┓
┃ Content Type      ┃ Count  ┃
┡━━━━━━━━━━━━━━━━━━━╇━━━━━━━━┩
│ Headings          │ 12     │
│ Text blocks       │ 45     │
│ Code blocks       │ 8      │
│ Lists             │ 6      │
│ Tables            │ 2      │
│ Images            │ 3      │
└───────────────────┴────────┘

[SUCCESS] Document downloaded successfully!

Output file: /home/user/projects/docs/installation-guide.md
File size: 23.5 KB
Download time: 1.8s
```

## Result

✅ **Successfully downloaded "Installation Guide" to local Markdown**

**File Information**:
- Output path: `/home/user/projects/docs/installation-guide.md`
- File size: 23.5 KB
- Original document ID: `doccnABCDEF1234567890`
- Download time: 1.8 seconds
- Content blocks: 76

**Markdown structure**:
```
installation-guide.md
├── 12 headings (H1-H6)
├── 45 text paragraphs
├── 8 code blocks
├── 6 lists
├── 2 tables
└── 3 images (downloaded separately)
```

## Local Editing Workflow

**Step 1: Open in your editor**
```bash
# Open in VS Code
code installation-guide.md

# Or vim
vim installation-guide.md

# Or any markdown editor
```

**Step 2: Edit locally**
- Make your changes
- Preview in your editor
- Use git for version control (optional)

**Step 3: Upload changes back to Feishu**
```bash
# After editing, upload the updated version
python /path/to/feishu-doc-tools/scripts/create_feishu_doc.py \
  --title "Installation Guide" \
  --file installation-guide.md \
  --folder-token "fldcn1234567890" \
  --overwrite  # Replace existing document
```

## Advanced Usage

### Download with images
```bash
# Download document and all images
python download_doc.py \
  --doc-name "Installation Guide" \
  --output installation-guide.md \
  --download-images \
  --images-dir ./images
```

### Download by path
```bash
# Download using document path
python download_doc.py \
  --doc-path "/Team Docs/Guides/Installation Guide" \
  --output installation-guide.md
```

### Multiple formats
```bash
# Download and convert to different formats
python download_doc.py \
  --doc-name "Installation Guide" \
  --output installation-guide \
  --format markdown,html,pdf
```

## Complete Edit-Upload Cycle

### Full workflow example:

```bash
# 1. Download from Feishu
python download_doc.py \
  --doc-name "Installation Guide" \
  --output guide.md

# 2. Edit locally
vim guide.md

# 3. Preview changes (optional)
grip guide.md  # or use markdown preview tool

# 4. Upload updated version
python create_feishu_doc.py \
  --title "Installation Guide" \
  --file guide.md \
  --folder-token "fldcn1234567890" \
  --overwrite

# 5. Verify upload
python download_doc.py \
  --doc-name "Installation Guide" \
  --output guide-verify.md

# 6. Compare versions
diff guide.md guide-verify.md
```

## Troubleshooting

**If document not found by name**:
```bash
# List all available documents
python /path/to/feishu-doc-tools/scripts/get_root_info.py

# Search with partial name
python download_doc.py \
  --doc-name-pattern "Installation" \
  --list-matches
```

**If download fails with permission error**:
```bash
# Verify you have read access
python /path/to/feishu-doc-tools/scripts/check_permissions.py \
  --doc-name "Installation Guide"

# Try using document ID instead
python download_doc.py \
  --doc-id "doccnABCDEF1234567890" \
  --output guide.md
```

**If images are not downloaded**:
```bash
# Download with explicit image handling
python download_doc.py \
  --doc-name "Installation Guide" \
  --output guide.md \
  --download-images \
  --images-dir ./images \
  --image-format png
```

## Best Practices

1. **Use name-based download**: More readable than ID-based
2. **Version control**: Use git to track your local changes
3. **Regular sync**: Download → Edit → Upload cycle
4. **Backup originals**: Keep a copy before making changes
5. **Test changes**: Preview locally before uploading

## Performance Notes

- Small documents (<100KB): ~1-2 seconds
- Medium documents (100KB-1MB): ~3-5 seconds
- Large documents (>1MB): ~10-15 seconds
- Images: +1-2 seconds per image

## Related Examples

- [01-upload-single-doc.md](./01-upload-single-doc.md) - Upload back after editing
- [06-sync-local-changes.md](./06-sync-local-changes.md) - Keep local and Feishu in sync
- [09-download-and-convert.md](./09-download-and-convert.md) - Advanced conversion
