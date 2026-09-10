#!/usr/bin/env bash
# Lesson 4 — Practice: undoing changes.
# Creates a fresh training repository and walks through restore/reset/revert/stash.
set -e

DIR="${TMPDIR:-/tmp}/lesson-4-repo"
rm -rf "$DIR"
mkdir -p "$DIR"
cd "$DIR"
git init --quiet

echo "== Setup: a base commit =="
echo "Line 1" > notes.txt
git add notes.txt
git commit --quiet -m "feat: add notes"

echo ""
echo "== Step 1. Discard an unstaged edit =="
echo "Line 2 (accidental)" >> notes.txt
git diff --stat
git restore notes.txt
echo "Restored content: $(cat notes.txt)"

echo ""
echo "== Step 2. Unstage a file =="
echo "secret" > draft.txt
git add draft.txt
git restore --staged draft.txt
git status --short

echo ""
echo "== Step 3. Cancel a commit with revert =="
echo "done" >> notes.txt
git add notes.txt
git commit --quiet -m "docs: update notes"
git revert HEAD --no-edit --quiet
git log --oneline

echo ""
echo "== Step 4. Stash unfinished work =="
echo "half-done" >> notes.txt
git stash push -m "draft" --quiet
git status --short
git stash pop --quiet
echo "Uncommitted change survived: $(tail -1 notes.txt)"

echo ""
echo "== Finish =="
echo "Training repository at: $DIR"