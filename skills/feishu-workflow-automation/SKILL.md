---
name: feishu-workflow-automation
description: Automate document workflows with CI/CD integration. Use when user wants to implement "code update → document generation → Feishu upload" pipeline, set up automated backups, or configure batch operations. Combines feishu-doc-tools for high-performance operations with Feishu-MCP for AI optimization.
---

# Feishu Workflow Automation Skill

## Overview

The **feishu-workflow-automation** skill provides comprehensive workflow automation for Feishu document operations. It enables complete CI/CD integration, automated backups, and streamlined document pipelines from code to documentation to Feishu.

### Key Features

- **Git Hooks Integration**: Automate documentation on code changes
- **CI/CD Pipelines**: GitHub Actions, GitLab CI, Jenkins templates
- **Automated Backups**: Scheduled Wiki and document backups (v0.2.1) ⭐
- **Code-to-Doc Pipeline**: Auto-generate docs from code
- **Batch Operations**: Large-scale document automation
- **Notification Systems**: Status updates and alerts

### Automation Workflow

```
Code Push → Trigger CI → Generate Docs → Upload to Feishu → Notify
     ↓
Git Hook (pre-commit/pre-push)
     ↓
CI Pipeline (GitHub Actions/GitLab CI)
     ↓
Documentation Generation (Swagger/OpenAPI)
     ↓
Feishu Upload (feishu-doc-tools)
     ↓
AI Optimization (Feishu-MCP - optional)
     ↓
Notification (Slack/Email)
```

### Tool Combination

**feishu-doc-tools**: High-performance batch operations
- Upload: 5-10x speedup
- Download: Complete Wiki backup
- Automation: CLI-first design

**Feishu-MCP**: AI-powered optimization (optional)
- Format optimization: 90% efficiency
- Content improvement
- Smart restructuring

## Quick Start

### GitHub Actions Integration

```yaml
name: Upload Docs to Feishu

on:
  push:
    branches: [main]
    paths:
      - 'docs/**'
      - 'api/openapi.yaml'

jobs:
  upload:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Generate API Documentation
        run: |
          npm run generate-docs

      - name: Upload to Feishu
        env:
          FEISHU_APP_ID: ${{ secrets.FEISHU_APP_ID }}
          FEISHU_APP_SECRET: ${{ secrets.FEISHU_APP_SECRET }}
        run: |
          cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/batch_create_docs.py \
            --source-dir docs \
            --recursive \
            --parallel
```

### Git Pre-Commit Hook

```bash
#!/bin/bash
# .git/hooks/pre-commit

# Check documentation
echo "Checking documentation..."

# Generate docs if needed
npm run generate-docs

# Upload to Feishu (if docs changed)
if git diff --name-only HEAD~1 | grep -q "docs/"; then
  cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/batch_create_docs.py \
    --source-dir docs \
    --parallel
fi
```

### Automated Wiki Backup

```bash
#!/bin/bash
# /usr/local/bin/backup-wiki.sh

cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/download_wiki.py \
  --space-name "Knowledge Base" \
  --output /backup/wiki/$(date +%Y%m%d) \
  --parallel

# Keep last 30 days
find /backup/wiki -type d -mtime +30 -exec rm -rf {} \;
```

## Common Scenarios

### Scenario 1: Code Push → API Docs → Feishu

**User**: "Whenever we push API changes, automatically generate and upload docs to Feishu."

**AI Response**:
```yaml
# .github/workflows/api-docs.yml
name: API Documentation to Feishu

on:
  push:
    branches: [main]
    paths:
      - 'src/api/**'
      - 'api/openapi.yaml'

jobs:
  docs:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'

      - name: Generate API Docs
        run: |
          npm install -g swagger-codegen
          swagger-codegen generate -i api/openapi.yaml -o docs/api -l html2

      - name: Convert to Markdown
        run: |
          # Convert HTML to Markdown if needed
          uv run python scripts/html-to-md.py docs/api docs/md

      - name: Upload to Feishu
        env:
          FEISHU_APP_ID: ${{ secrets.FEISHU_APP_ID }}
          FEISHU_APP_SECRET: ${{ secrets.FEISHU_APP_SECRET }}
        run: |
          cd /path/to/feishu-doc-tools
          uv run python scripts/batch_create_docs.py \
            --source-dir docs/md \
            --folder-token "${{ secrets.FEISHU_API_DOCS_FOLDER }}" \
            --parallel \
            --workers 5

      - name: Notify Team
        if: success()
        run: |
          echo "API documentation uploaded successfully"
```

### Scenario 2: Automated Wiki Backup (v0.2.1)

**User**: "Set up automatic daily backups of our Wiki knowledge base."

**AI Response**:
```bash
#!/bin/bash
# /usr/local/bin/backup-wiki.sh

set -e

WIKI_SPACE="Knowledge Base"
BACKUP_DIR="/backup/wiki/$(date +%Y%m%d_%H%M%S)"
LOG_FILE="/var/log/wiki-backup.log"

echo "[$(date)] Starting Wiki backup..." >> "$LOG_FILE"

# Download entire Wiki space (NEW in v0.2.1)
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/download_wiki.py \
  --space-name "$WIKI_SPACE" \
  --output "$BACKUP_DIR" \
  --parallel \
  --workers 5 \
  >> "$LOG_FILE" 2>&1

# Create tarball
tar -czf "$BACKUP_DIR.tar.gz" -C /backup/wiki "$(basename $BACKUP_DIR)"

# Cleanup: Keep last 30 days
find /backup/wiki -type d -mtime +30 -exec rm -rf {} \;

echo "[$(date)] Wiki backup completed: $BACKUP_DIR" >> "$LOG_FILE"

# Setup cron job
# crontab -e
# 0 2 * * * /usr/local/bin/backup-wiki.sh
```

### Scenario 3: Git Hook → Doc Validation

**User**: "Validate documentation format before allowing commits."

**AI Response**:
```bash
#!/bin/bash
# .git/hooks/pre-commit

echo "Validating documentation..."

# Check for required frontmatter
find docs -name "*.md" -exec sh -c '
  if ! head -1 "$1" | grep -q "^---"; then
    echo "Error: $1 missing frontmatter"
    exit 1
  fi
' sh {} \;

# Generate docs
npm run generate-docs

# Validate generated docs
cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/batch_create_docs.py \
  --source-dir docs \
  --dry-run \
  --validate-only

if [ $? -ne 0 ]; then
  echo "Documentation validation failed. Please fix errors before committing."
  exit 1
fi

echo "Documentation validation passed."
```

### Scenario 4: CI/CD Pipeline with AI Optimization

**User**: "In CI pipeline, generate docs, upload to Feishu, and optimize with AI."

**AI Response**:
```yaml
# .github/workflows/docs-optimized.yml
name: Docs with AI Optimization

on:
  push:
    branches: [main]
    paths:
      - 'docs/**'

jobs:
  docs:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Generate Documentation
        run: npm run generate-docs

      - name: Upload to Feishu (High Performance)
        env:
          FEISHU_APP_ID: ${{ secrets.FEISHU_APP_ID }}
          FEISHU_APP_SECRET: ${{ secrets.FEISHU_APP_SECRET }}
        run: |
          cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/batch_create_docs.py \
            --source-dir docs \
            --parallel

      - name: Optimize with AI (Optional)
        if: github.ref == 'refs/heads/main'
        env:
          FEISHU_MCP_URL: ${{ secrets.FEISHU_MCP_URL }}
        run: |
          # Use Feishu-MCP for AI optimization
          node scripts/optimize-docs.js

      - name: Notify Team
        if: success()
        uses: 8398a7/action-slack@v3
        with:
          status: ${{ job.status }}
          text: 'Documentation uploaded and optimized to Feishu'
```

### Scenario 5: Batch Document Check

**User**: "Run nightly checks to find outdated or broken documentation."

**AI Response**:
```bash
#!/bin/bash
# /usr/local/bin/check-docs.sh

DOC_DIR="/path/to/docs"
REPORT_FILE="/var/log/doc-check-$(date +%Y%m%d).log"

echo "Documentation Check Report - $(date)" > "$REPORT_FILE"

# Check for broken links
echo "Checking for broken links..." >> "$REPORT_FILE"
find "$DOC_DIR" -name "*.md" -exec grep -H "http" {} \; | \
  while read line; do
    url=$(echo "$line" | grep -o "http[^\"]*")
    if ! curl -s --head "$url" | head -n 1 | grep "200" > /dev/null; then
      echo "BROKEN: $url" >> "$REPORT_FILE"
    fi
  done

# Check for outdated frontmatter
echo "Checking frontmatter..." >> "$REPORT_FILE"
find "$DOC_DIR" -name "*.md" -exec sh -c '
  if ! head -5 "$1" | grep -q "last_updated"; then
    echo "MISSING DATE: $1" >> "$2"
  fi
' sh {} "$REPORT_FILE" \;

# Send report to Slack if issues found
if [ -s "$REPORT_FILE" ]; then
  curl -X POST -H "Content-Type: application/json" \
    --data "{\"text\": \"Documentation check report:\n$(cat $REPORT_FILE)\"}" \
    "$SLACK_WEBHOOK_URL"
fi
```

### Scenario 6: Multi-Environment Document Sync

**User**: "Sync documentation to different Feishu spaces based on branch."

**AI Response**:
```yaml
# .github/workflows/multi-env-docs.yml
name: Multi-Environment Docs

on:
  push:
    branches: [dev, staging, main]

jobs:
  upload:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Generate Docs
        run: npm run generate-docs

      - name: Upload to Dev Space
        if: github.ref == 'refs/heads/dev'
        env:
          FEISHU_FOLDER: ${{ secrets.FEISHU_DEV_FOLDER }}
        run: |
          cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/batch_create_docs.py \
            --source-dir docs \
            --folder-token "$FEISHU_FOLDER" \
            --parallel

      - name: Upload to Staging Space
        if: github.ref == 'refs/heads/staging'
        env:
          FEISHU_FOLDER: ${{ secrets.FEISHU_STAGING_FOLDER }}
        run: |
          cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/batch_create_docs.py \
            --source-dir docs \
            --folder-token "$FEISHU_FOLDER" \
            --parallel

      - name: Upload to Production Space
        if: github.ref == 'refs/heads/main'
        env:
          FEISHU_FOLDER: ${{ secrets.FEISHU_PROD_FOLDER }}
        run: |
          cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/batch_create_docs.py \
            --source-dir docs \
            --folder-token "$FEISHU_FOLDER" \
            --parallel
```

### Scenario 7: GitLab CI Integration

**User**: "Set up GitLab CI to automatically upload docs to Feishu."

**AI Response**:
```yaml
# .gitlab-ci.yml
stages:
  - build
  - deploy

variables:
  DOCS_DIR: "docs"
  FEISHU_APP_ID: $FEISHU_APP_ID
  FEISHU_APP_SECRET: $FEISHU_APP_SECRET

build:docs:
  stage: build
  script:
    - npm install
    - npm run generate-docs
  artifacts:
    paths:
      - docs/
    only:
      - main
      - develop

deploy:feishu:
  stage: deploy
  dependencies:
    - build:docs
  script:
    - |
      cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/batch_create_docs.py \
        --source-dir $DOCS_DIR \
        --folder-token "$FEISHU_FOLDER_TOKEN" \
        --parallel \
        --workers 5
  only:
    - main
```

### Scenario 8: Jenkins Pipeline

**User**: "Create a Jenkins pipeline for automated documentation deployment."

**AI Response**:
```groovy
// Jenkinsfile
pipeline {
    agent any

    environment {
        FEISHU_APP_ID = credentials('feishu-app-id')
        FEISHU_APP_SECRET = credentials('feishu-app-secret')
        FEISHU_FOLDER = credentials('feishu-folder-token')
    }

    stages {
        stage('Build') {
            steps {
                sh 'npm install'
                sh 'npm run generate-docs'
            }
        }

        stage('Upload to Feishu') {
            steps {
                sh """
                    cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/batch_create_docs.py \
                        --source-dir docs \
                        --folder-token "$FEISHU_FOLDER" \
                        --parallel \
                        --workers 5
                """
            }
        }

        stage('Optimize with AI') {
            when {
                branch 'main'
            }
            steps {
                sh 'node scripts/optimize-docs.js'
            }
        }
    }

    post {
        success {
            emailext(
                subject: "Docs uploaded to Feishu",
                body: "Documentation successfully uploaded.",
                to: "team@example.com"
            )
        }
        failure {
            emailext(
                subject: "Docs upload failed",
                body: "Failed to upload documentation.",
                to: "team@example.com"
            )
        }
    }
}
```

### Scenario 9: Scheduled Document Updates

**User**: "Automatically update documentation from external sources weekly."

**AI Response**:
```bash
#!/bin/bash
# /usr/local/bin/update-external-docs.sh

set -e

# Download external documentation
wget -O /tmp/external-docs.md https://external.com/docs.md

# Convert to our format
uv run python scripts/convert-docs.py /tmp/external-docs.md docs/external.md

# Upload to Feishu
cd /path/to/feishu-doc-tools
uv run python scripts/create_feishu_doc.py \
  --title "External Documentation" \
  --file docs/external.md \
  --folder-token "$FEISHU_FOLDER"

# Cleanup
rm /tmp/external-docs.md

# Add to crontab
# 0 0 * * 0 /usr/local/bin/update-external-docs.sh
```

### Scenario 10: Conditional Deployment

**User**: "Only upload docs if tests pass and specific files changed."

**AI Response**:
```yaml
# .github/workflows/conditional-docs.yml
name: Conditional Documentation Deployment

on:
  push:
    branches: [main]

jobs:
  check:
    runs-on: ubuntu-latest
    outputs:
      should_deploy: ${{ steps.check.outputs.should_deploy }}
    steps:
      - uses: actions/checkout@v3

      - name: Check for Documentation Changes
        id: check
        run: |
          if git diff --name-only HEAD~1 | grep -q "docs/"; then
            echo "should_deploy=true" >> $GITHUB_OUTPUT
          else
            echo "should_deploy=false" >> $GITHUB_OUTPUT
          fi

  test:
    runs-on: ubuntu-latest
    needs: check
    if: needs.check.outputs.should_deploy == 'true'
    steps:
      - uses: actions/checkout@v3
      - name: Run Tests
        run: npm test

  deploy:
    runs-on: ubuntu-latest
    needs: [check, test]
    if: needs.check.outputs.should_deploy == 'true'
    steps:
      - uses: actions/checkout@v3
      - name: Deploy to Feishu
        env:
          FEISHU_APP_ID: ${{ secrets.FEISHU_APP_ID }}
          FEISHU_APP_SECRET: ${{ secrets.FEISHU_APP_SECRET }}
        run: |
          cd /path/to/feishu-doc-tools && uv run python /path/to/feishu-doc-tools/scripts/batch_create_docs.py \
            --source-dir docs \
            --parallel
```

## Best Practices

### 1. Use Environment Variables for Secrets

**Good**: Store secrets in GitHub/GitLab Secrets
```yaml
env:
  FEISHU_APP_ID: ${{ secrets.FEISHU_APP_ID }}
  FEISHU_APP_SECRET: ${{ secrets.FEISHU_APP_SECRET }}
```

**Avoid**: Hardcoded credentials
```bash
FEISHU_APP_ID="123456"  # Never commit this!
```

### 2. Implement Dry-Run Mode

**Recommendation**: Test with `--dry-run` first

```bash
# Test run
uv run python batch_create_docs.py --dry-run --validate-only

# Production run
uv run python batch_create_docs.py --parallel
```

### 3. Use Parallel Processing in CI

**Recommendation**: Always enable `--parallel` in CI/CD

```bash
uv run python batch_create_docs.py \
  --source-dir docs \
  --parallel \
  --workers 5
```

### 4. Implement Error Handling

**Good**: Comprehensive error handling
```bash
set -e  # Exit on error
set -o pipefail  # Exit on pipe failure

trap 'echo "Error on line $LINENO"; exit 1' ERR
```

### 5. Add Logging and Monitoring

**Recommendation**: Log all automation runs

```bash
#!/bin/bash
LOG_FILE="/var/log/doc-upload.log"

echo "[$(date)] Starting documentation upload" >> "$LOG_FILE"

uv run python batch_create_docs.py --parallel >> "$LOG_FILE" 2>&1

if [ $? -eq 0 ]; then
  echo "[$(date)] Upload successful" >> "$LOG_FILE"
else
  echo "[$(date)] Upload failed" >> "$LOG_FILE"
  exit 1
fi
```

### 6. Use Conditional Execution

**Good**: Only run when needed

```yaml
# Only on docs changes
if: contains(github.event.commits[0].modified, 'docs/')

# Only on main branch
if: github.ref == 'refs/heads/main'
```

### 7. Implement Notification Systems

**Recommendation**: Notify team of automation results

```bash
# Success notification
curl -X POST "$SLACK_WEBHOOK" \
  -H "Content-Type: application/json" \
  -d '{"text": "✅ Documentation uploaded successfully"}'

# Failure notification
curl -X POST "$SLACK_WEBHOOK" \
  -H "Content-Type: application/json" \
  -d '{"text": "❌ Documentation upload failed"}'
```

### 8. Schedule Backups During Off-Hours

**Recommendation**: Run backups at low-traffic times

```bash
# Crontab: Daily at 2 AM
0 2 * * * /usr/local/bin/backup-wiki.sh
```

## Troubleshooting

### Issue 1: CI Pipeline Fails with Authentication Error

**Error**: `AuthenticationError: Invalid credentials`

**Solution**:
```yaml
# Verify secrets are set
- name: Verify Secrets
  run: |
    echo "FEISHU_APP_ID is set: ${{ secrets.FEISHU_APP_ID != '' }}"
    echo "FEISHU_APP_SECRET is set: ${{ secrets.FEISHU_APP_SECRET != '' }}"
```

### Issue 2: Git Hook Not Executing

**Issue**: Pre-commit hook doesn't run

**Solution**:
```bash
# Make hook executable
chmod +x .git/hooks/pre-commit

# Or use pre-commit framework
pip install pre-commit
```

### Issue 3: Race Condition in CI

**Issue**: Multiple jobs try to upload simultaneously

**Solution**:
```yaml
# Add locking mechanism
jobs:
  upload:
    runs-on: ubuntu-latest
    concurrency:
      group: feishu-upload
      cancel-in-progress: false
```

### Issue 4: Backup Script Fails Silently

**Issue**: Backup fails but no error reported

**Solution**:
```bash
#!/bin/bash
set -e  # Exit on error
set -u  # Exit on undefined variable
set -o pipefail  # Exit on pipe failure

# Or use explicit error checking
if ! uv run python download_wiki.py ...; then
  echo "Backup failed!" >&2
  exit 1
fi
```

### Issue 5: Cron Job Not Running

**Issue**: Scheduled backup doesn't execute

**Solution**:
```bash
# Check cron log
grep CRON /var/log/syslog

# Verify cron syntax
crontab -l

# Test cron job manually
/usr/local/bin/backup-wiki.sh

# Check permissions
ls -la /usr/local/bin/backup-wiki.sh
```

## CI/CD Templates

### GitHub Actions Template

```yaml
name: Upload Documentation to Feishu

on:
  push:
    branches: [main]
    paths:
      - 'docs/**'

jobs:
  upload:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.10'

      - name: Upload to Feishu
        env:
          FEISHU_APP_ID: ${{ secrets.FEISHU_APP_ID }}
          FEISHU_APP_SECRET: ${{ secrets.FEISHU_APP_SECRET }}
          FEISHU_FOLDER: ${{ secrets.FEISHU_FOLDER }}
        run: |
          pip install feishu-doc-tools
          feishu-doc-tools batch-upload \
            --source-dir docs \
            --folder-token "$FEISHU_FOLDER" \
            --parallel
```

### GitLab CI Template

```yaml
image: python:3.10

stages:
  - deploy

deploy:feishu:
  stage: deploy
  script:
    - pip install feishu-doc-tools
    - feishu-doc-tools batch-upload
        --source-dir docs
        --folder-token "$FEISHU_FOLDER_TOKEN"
        --parallel
  only:
    - main
```

### Jenkins Pipeline Template

```groovy
pipeline {
    agent any

    stages {
        stage('Upload to Feishu') {
            steps {
                sh '''
                    pip install feishu-doc-tools
                    feishu-doc-tools batch-upload \
                        --source-dir docs \
                        --folder-token "$FEISHU_FOLDER" \
                        --parallel
                '''
            }
        }
    }
}
```

## Related Skills

- **feishu-doc-sync**: Document upload/download operations
- **feishu-wiki-manager**: Wiki-specific backup and management
- **feishu-ai-editor**: AI-powered document optimization

---

**Last Updated**: 2026-01-19
**Version**: v0.2
**Requires**: feishu-doc-tools v0.2.1+, Feishu-MCP v0.1.8+
