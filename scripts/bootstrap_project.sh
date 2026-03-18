#!/usr/bin/env bash
set -euo pipefail

mkdir -p .claude prompts skills scripts docs

cat > .gitignore <<'GI'
.env
*.pem
*.key
*.p12
node_modules/
.DS_Store
GI

echo "Project bootstrap complete."
