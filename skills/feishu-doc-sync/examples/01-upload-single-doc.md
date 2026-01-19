# Example: Upload Single Document

## Scenario
A developer wants to upload a README.md file to Feishu for team documentation.

## User Request
**User**: "I have a README.md file that documents our API. I want to upload it to Feishu so the team can access it easily."

## AI Agent Response

I'll help you upload the README.md to Feishu using feishu-doc-tools for optimal performance.

**Step 1: Verify the file**
```bash
# Check if file exists
ls -lh README.md
```

**Step 2: Get folder token** (if you don't have it)
```bash
# List available folders
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/get_root_info.py
```

**Step 3: Upload the document**
```bash
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/create_feishu_doc.py \
  --title "API Documentation" \
  --file README.md \
  --folder-token "fldcnxxxxxxxxxxx"
```

## Command Executed

```bash
cd $(dirname /home/user/feishu-doc-tools/scripts/create_feishu_doc.py) && uv run python /home/user/feishu-doc-tools/scripts/create_feishu_doc.py \
  --title "API Documentation" \
  --file /home/user/project/README.md \
  --folder-token "fldcn1234567890abcdef"
```

## Expected Output

```
[INFO] Reading file: /home/user/project/README.md
[INFO] File size: 15.2 KB
[INFO] Parsing Markdown content...
[INFO] Creating Feishu document...
[INFO] Uploading content blocks...
[INFO] Progress: ████████████████████ 100% (25/25 blocks)
[SUCCESS] Document created successfully!

Document Details:
- Title: API Documentation
- Document ID: doccnABCDEF1234567890
- URL: https://example.feishu.cn/docx/doccnABCDEF1234567890
- Blocks: 25
- Upload time: 2.3s
```

## Result

✅ **Successfully uploaded README.md to Feishu**

**Document Information**:
- Title: API Documentation
- Document ID: `doccnABCDEF1234567890`
- URL: https://example.feishu.cn/docx/doccnABCDEF1234567890
- Upload time: 2.3 seconds
- Blocks created: 25

## Next Steps

**Recommended actions**:

1. **Share the document**: Copy the URL and share with team
2. **Set permissions**: Configure who can view/edit the document
3. **Add to folder**: Organize in appropriate folder structure

**Optional enhancements**:
```bash
# If you want to optimize the document with AI
# Use feishu-ai-editor skill after upload
# See: skills/feishu-ai-editor/examples/
```

## Troubleshooting

**If upload fails with authentication error**:
```bash
# Verify credentials
echo $FEISHU_APP_ID
echo $FEISHU_APP_SECRET

# Re-authenticate if needed
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/setup_user_auth.py
```

**If file not found error**:
```bash
# Use absolute path
uv run python create_feishu_doc.py \
  --file /absolute/path/to/README.md \
  --title "API Documentation" \
  --folder-token "fldcn1234567890"
```

## Performance Notes

- File size: 15.2 KB
- Processing time: 2.3 seconds
- Blocks created: 25
- No optimization needed (file is small)

For larger files (>1MB), consider using `--parallel` flag in batch operations.

## Related Examples

- [02-batch-upload-folder.md](./02-batch-upload-folder.md) - Upload entire folder
- [04-upload-with-ai-optimize.md](./04-upload-with-ai-optimize.md) - Upload and optimize
- [08-batch-upload-with-error-handling.md](./08-batch-upload-with-error-handling.md) - Handle errors
