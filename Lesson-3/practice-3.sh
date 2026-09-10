#!/usr/bin/env bash
# Lesson 3 — Practice: branches, merging and conflicts.
# Creates a fresh training repository and recreates the whole class flow.
set -e

DIR="${TMPDIR:-/tmp}/lesson-3-repo"
rm -rf "$DIR"
mkdir -p "$DIR"
cd "$DIR"
git init --quiet
git branch -M master

echo "== Step 1. Base commit =="
echo "<h1>Home</h1>" > index.html
git add index.html
git commit --quiet -m "feat: add home page"

echo "== Step 2. Create and switch to feature/contact =="
git switch -c feature/contact
echo "<h1>Contact</h1>" > contact.html
git add contact.html
git commit --quiet -m "feat: add contact page"

echo "== Step 3. Fast-forward merge =="
git switch --quiet master
git merge --quiet feature/contact
git log --oneline --graph

echo "== Step 4. Both branches move forward =="
echo "<footer>Footer</footer>" >> index.html
git add index.html
git commit --quiet -m "feat: add footer to home"

git switch --quiet feature/contact
echo "<h1>Contact</h1><p>Write to us.</p>" > contact.html
git add contact.html
git commit --quiet -m "feat: extend contact page"

echo "== Step 5. Real merge =="
git switch --quiet master
git merge --quiet feature/contact --no-edit
git log --oneline --graph

echo "== Step 6. Honest conflict =="
git switch --quiet master
echo "<p>Version from master</p>" > page.html
git add page.html
git commit --quiet -m "feat: write page on master"

git switch --quiet feature/contact
echo "<p>Version from feature</p>" > page.html
git add page.html
git commit --quiet -m "feat: write page on feature"

git switch --quiet master
if git merge feature/contact --no-edit 2>&1 | grep -q CONFLICT; then
  echo "-- Conflict! Inspect page.html:"
  cat page.html
  echo "-- Resolving: keep both lines --"
  echo "<p>Version from master</p>" > page.html
  echo "<p>Version from feature</p>" >> page.html
  git add page.html
  git commit --quiet -m "merge: resolve conflict in page.html"
fi

echo "== Step 7. Delete the merged branch =="
git branch -d feature/contact
git log --oneline --graph

echo ""
echo "== Finish =="
echo "Training repository at: $DIR"