#!/usr/bin/env bash
set -e

# Antigravity Customizations Setup Script
# Copies or links global rules and skills to ~/.gemini/

DEST_GEMINI="$HOME/.gemini"
DEST_CONFIG="$DEST_GEMINI/config"
DEST_SKILLS="$DEST_CONFIG/skills"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Setting up Antigravity Customizations..."

# 1. Ensure target directories exist
mkdir -p "$DEST_GEMINI"
mkdir -p "$DEST_SKILLS"

# 2. Install Global Rules
echo "==> Installing Global Rules to $DEST_GEMINI/GEMINI.md"
cp "$REPO_DIR/rules/GEMINI.md" "$DEST_GEMINI/GEMINI.md"

# 3. Install Global Skills
echo "==> Installing Global Skills to $DEST_SKILLS"
cp -R "$REPO_DIR/skills/"* "$DEST_SKILLS/"

echo "==> Setup completed successfully!"
echo "    - Rules:  $DEST_GEMINI/GEMINI.md"
echo "    - Skills: $DEST_SKILLS"
