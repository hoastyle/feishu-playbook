#!/bin/bash
# Pre-commit hook for automatic documentation upload to Feishu
#
# Installation:
#   1. Copy this file to .git/hooks/pre-commit
#   2. Make it executable: chmod +x .git/hooks/pre-commit
#   3. Configure environment variables in .env

set -e  # Exit on error

echo "🔍 Pre-commit: Checking documentation changes..."

# Check if docs were modified
DOCS_CHANGED=$(git diff --cached --name-only | grep -E '^docs/.*\.md$' || true)

if [ -z "$DOCS_CHANGED" ]; then
    echo "ℹ️  No documentation changes detected, skipping Feishu upload"
    exit 0
fi

echo "📝 Documentation files changed:"
echo "$DOCS_CHANGED"

# Ask user if they want to upload
read -p "Upload changed documentation to Feishu? [y/N] " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "⏭️  Skipping Feishu upload"
    exit 0
fi

# Upload to Feishu
echo "📤 Uploading documentation to Feishu..."

# Export the changed files to a temporary location
TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT

# Copy changed files
for file in $DOCS_CHANGED; do
    mkdir -p "$TEMP_DIR/$(dirname "$file")"
    cp "$file" "$TEMP_DIR/$file"
done

# Upload using feishu-doc-tools
python /path/to/feishu-doc-tools/scripts/batch_create_docs.py \
  --source-dir "$TEMP_DIR/docs" \
  --recursive \
  --parallel \
  --workers 3 \
  --folder-token "${FEISHU_FOLDER_TOKEN}" \
  || {
    echo "❌ Upload failed! Commit aborted."
    exit 1
  }

echo "✅ Documentation uploaded to Feishu successfully!"
echo "✨ Proceeding with commit..."

exit 0
