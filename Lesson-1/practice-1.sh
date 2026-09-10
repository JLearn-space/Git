#!/usr/bin/env bash
# Lesson 1 — Practice: version control basics.
# Run this script from any folder to go through the lesson steps.
set -e

echo "== Step 1. Check Git version =="
git --version

echo ""
echo "== Step 2. Configure your identity =="
git config --global user.name 2>/dev/null || git config --global user.name "Your Name"
git config --global user.email 2>/dev/null || git config --global user.email "your.email@example.com"
echo "user.name  = $(git config --global user.name)"
echo "user.email = $(git config --global user.email)"

echo ""
echo "== Step 3. Show all global settings =="
git config --global --list

echo ""
echo "== Step 4. Create a repository =="
DIR="${TMPDIR:-/tmp}/my-first-repo"
rm -rf "$DIR"
mkdir -p "$DIR"
cd "$DIR"
git init

echo ""
echo "== Step 5. Create a file and check status =="
echo "Hello, Git!" > hello.txt
git status

echo ""
echo "== Finish =="
echo "Repository created at: $DIR"
echo "Next: Lesson 2 — make your first commit with:"
echo "  git add hello.txt"
echo "  git commit -m \"feat: add hello.txt\""