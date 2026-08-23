#!/usr/bin/env bash
set -e

# Unified AI Agents Customizations Setup Script
# Installs and syncs Global Rules and Skills across:
# 1. Google Antigravity (~/.gemini)
# 2. Cursor (~/.cursor)
# 3. Pi Agent (~/.pi)

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RULES_FILE="$REPO_DIR/rules/GEMINI.md"
SKILLS_DIR="$REPO_DIR/skills"

echo "========================================================"
echo "==> Setting up Unified AI Agent Customizations..."
echo "========================================================"

# ------------------------------------------------------------------
# 1. Google Antigravity Setup
# ------------------------------------------------------------------
DEST_GEMINI="$HOME/.gemini"
DEST_GEMINI_SKILLS="$DEST_GEMINI/config/skills"

echo "==> [1/3] Syncing to Google Antigravity (~/.gemini)..."
mkdir -p "$DEST_GEMINI" "$DEST_GEMINI_SKILLS"
cp "$RULES_FILE" "$DEST_GEMINI/GEMINI.md"
rm -rf "$DEST_GEMINI_SKILLS"/*
cp -R "$SKILLS_DIR"/* "$DEST_GEMINI_SKILLS/"
echo "    ✓ Antigravity rules & skills updated."

# ------------------------------------------------------------------
# 2. Cursor Setup
# ------------------------------------------------------------------
DEST_CURSOR="$HOME/.cursor"
DEST_CURSOR_RULES="$DEST_CURSOR/rules"
DEST_CURSOR_SKILLS="$DEST_CURSOR/skills"

if [ -d "$DEST_CURSOR" ]; then
    echo "==> [2/3] Syncing to Cursor (~/.cursor)..."
    mkdir -p "$DEST_CURSOR_RULES" "$DEST_CURSOR_SKILLS"
    # Clean old rules/skills
    rm -rf "$DEST_CURSOR_RULES"/* "$DEST_CURSOR_SKILLS"/* "$DEST_CURSOR"/skills-pruned-* 2>/dev/null || true
    cp "$RULES_FILE" "$DEST_CURSOR_RULES/GEMINI.md"
    cp -R "$SKILLS_DIR"/* "$DEST_CURSOR_SKILLS/"
    echo "    ✓ Cursor rules & skills updated."
else
    echo "==> [2/3] Skipping Cursor (~/.cursor not found)."
fi

# ------------------------------------------------------------------
# 3. Pi Agent Setup
# ------------------------------------------------------------------
DEST_PI="$HOME/.pi/agent"
DEST_PI_SKILLS="$DEST_PI/skills"

if [ -d "$HOME/.pi" ]; then
    echo "==> [3/3] Syncing to Pi Agent (~/.pi)..."
    mkdir -p "$DEST_PI" "$DEST_PI_SKILLS"
    rm -rf "$DEST_PI_SKILLS"/*
    cp "$RULES_FILE" "$DEST_PI/APPEND_SYSTEM.md"
    cp -R "$SKILLS_DIR"/* "$DEST_PI_SKILLS/"
    echo "    ✓ Pi system prompt & skills updated."
else
    echo "==> [3/3] Skipping Pi (~/.pi not found)."
fi

echo "========================================================"
echo "==> All AI agents are now synchronized with unified skills!"
echo "========================================================"
