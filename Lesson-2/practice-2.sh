#!/usr/bin/env bash
# Lesson 2 — Practice: first commit and history.
# Creates a fresh training repository and walks through add/commit/log/mv.
set -e

DIR="${TMPDIR:-/tmp}/lesson-2-repo"
rm -rf "$DIR"
mkdir -p "$DIR"
cd "$DIR"
git init --quiet

echo "== Step 1. Create a file and commit it =="
echo "Hello, Git!" > hello.txt
git add hello.txt
git commit --quiet -m "feat: add hello.txt"
echo "Committed: $(git log --oneline -1)"

echo ""
echo "== Step 2. Modify and commit the change =="
echo "I'm learning Git." >> hello.txt
git add hello.txt
git commit --quiet -m "docs: add a second line"

echo ""
echo "== Step 3. Add a new file =="
echo "About this project." > about.txt
git add about.txt
git commit --quiet -m "feat: add about"

echo ""
echo "== Step 4. Read the history =="
git log --oneline

echo ""
echo "== Step 5. Rename a tracked file =="
git mv about.txt README.txt
git commit --quiet -m "refactor: rename about to README"
git log --oneline --stat

echo ""
echo "== Finish =="
echo "Training repository at: $DIR"