#!/usr/bin/env bash
# Lesson 9 — Practice: workflows, rebase and cherry-pick.
set -e

BASE="${TMPDIR:-/tmp}/lesson-9"
rm -rf "$BASE"
mkdir -p "$BASE/app"
cd "$BASE/app"
git init --quiet
echo "line A" > file.txt
git add file.txt
git commit --quiet -m "feat: A"

echo "== Step 1. Feature branch with 2 commits =="
git switch -c feature/photo
echo "photo" > photo.txt
git add photo.txt
git commit --quiet -m "feat: add photo"
echo "gallery" > gallery.txt
git add gallery.txt
git commit --quiet -m "feat: add gallery"

echo ""
echo "== Step 2. main gets a new commit =="
git switch --quiet main
echo "line B" >> file.txt
git commit --quiet -am "fix: typo"

echo ""
echo "== Step 3a. Merge integration (default) =="
git switch --quiet feature/photo
git switch --quiet main
git merge --quiet feature/photo
echo "-- history after merge:"
git log --oneline --graph

echo ""
echo "== Step 3b. Redo with rebase =="
git reset --quiet --hard HEAD~1
git switch --quiet feature/photo
git rebase main
echo "-- history after rebase:"
git log --oneline --graph

echo ""
echo "== Step 4. cherry-pick one commit from another branch =="
git switch -c feature/other
echo "nav" > nav.txt
git add nav.txt
git commit --quiet -m "feat: add nav"
git switch --quiet main
git cherry-pick feature/other
ls
git log --oneline

echo ""
echo "== Step 5. pull --rebase simulating a colleague's push =="
git switch --quiet feature/photo
git checkout --quiet -b temp main
git merge --quiet feature/photo
git checkout --quiet feature/photo
# here feature/photo is already rebased; demonstrate a helper history
echo "colleague work" >> file.txt
git commit --quiet -am "wip: colleague commit"
git rebase temp
echo "-- final history:"
git log --oneline --graph --all

echo ""
echo "== Finish =="