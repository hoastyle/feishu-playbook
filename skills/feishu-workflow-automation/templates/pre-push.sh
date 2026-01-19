#!/bin/bash
# Pre-push hook for bulk documentation upload to Feishu
#
# Installation:
#   1. Copy this file to .git/hooks/pre-push
#   2. Make it executable: chmod +x .git/hooks/pre-push
#   3. Configure environment variables in .env

set -e  # Exit on error

echo "🔍 Pre-push: Checking for documentation changes..."

# Get the remote and URL
remote="$1"
url="$2"

# Check if pushing to main/master
current_branch=$(git symbolic-ref --short HEAD)
if [[ "$current_branch" != "main" && "$current_branch" != "master" ]]; then
    echo "ℹ️  Not on main/master branch, skipping Feishu upload"
    exit 0
fi

# Check commits being pushed
while read local_ref local_sha remote_ref remote_sha; do
    if [ "$local_sha" = "0000000000000000000000000000000000000000" ]; then
        # Branch is being deleted, skip
        continue
    fi

    if [ "$remote_sha" = "0000000000000000000000000000000000000000" ]; then
        # New branch, check all commits
        range="$local_sha"
    else
        # Existing branch, check new commits
        range="$remote_sha..$local_sha"
    fi

    # Check if docs were modified in this push
    DOCS_CHANGED=$(git diff --name-only "$range" | grep -E '^docs/.*\.md$' || true)

    if [ -n "$DOCS_CHANGED" ]; then
        echo "📝 Documentation changes detected in commits:"
        git log --oneline "$range" | head -5

        # Ask user if they want to upload
        read -p "Upload all documentation to Feishu before push? [Y/n] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Nn]$ ]]; then
            echo "⏭️  Skipping Feishu upload"
            continue
        fi

        # Upload entire docs folder
        echo "📤 Uploading all documentation to Feishu..."
        python /path/to/feishu-doc-tools/scripts/batch_create_docs.py \
          --source-dir docs \
          --recursive \
          --parallel \
          --workers 5 \
          --folder-token "${FEISHU_FOLDER_TOKEN}" \
          || {
            echo "❌ Upload failed!"
            read -p "Continue with push anyway? [y/N] " -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                exit 1
            fi
          }

        echo "✅ Documentation uploaded to Feishu successfully!"
    fi
done

echo "✨ Pre-push checks complete, proceeding with push..."
exit 0
