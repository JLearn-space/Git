#!/usr/bin/env bash
# Lesson 6 — Practice: teamwork flow.
# Simulates two developers sharing one remote (no internet needed).
set -e

BASE="${TMPDIR:-/tmp}/lesson-6"
rm -rf "$BASE"
mkdir -p "$BASE"

echo "== Step 1. Shared remote on our machine =="
git init --bare -b master "$BASE/team.git" --quiet

echo "== Step 2. Developer A sets up the project =="
mkdir -p "$BASE/dev-a"
cd "$BASE/dev-a"
git init --quiet
git branch -M master
echo "<h1>Home</h1>" > index.html
git add index.html
git commit --quiet -m "feat: add home page"
git remote add origin "$BASE/team.git"
git push --quiet origin master

echo "== Step 3. Developer B clones and makes a feature branch =="
git clone --quiet "$BASE/team.git" "$BASE/dev-b"
cd "$BASE/dev-b"
git switch -c feature/contact
echo "<h1>Contact</h1>" > contact.html
git add contact.html
git commit --quiet -m "feat: add contact page"
git push --quiet -u origin feature/contact

echo "== Step 4. Developer A reviews the incoming branch (the 'PR') =="
cd "$BASE/dev-a"
git fetch --quiet origin
echo "-- New branch available:"
git branch -r
echo "-- What it would merge:"
git log master..origin/feature/contact --oneline

echo "== Step 5. Reviewer merges (approves) the PR =="
git merge --quiet origin/feature/contact
git push --quiet origin master

echo "== Step 6. Developer B syncs and cleans up =="
cd "$BASE/dev-b"
git switch --quiet master
git pull --quiet
git branch -d feature/contact
git push origin --delete feature/contact

echo ""
echo "== Final state =="
git log --oneline --graph --all

echo ""
echo "== Finish =="
echo "On a real project the 'PR' step happens on github.com — same branch flow."