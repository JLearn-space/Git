#!/usr/bin/env bash
# Lesson 5 — Practice: remote repositories.
# Simulates a remote (no internet needed) using a local "bare" repository.
set -e

BASE="${TMPDIR:-/tmp}/lesson-5"
rm -rf "$BASE"
mkdir -p "$BASE"

echo "== Step 1. Create a 'remote' on our machine (bare repository) =="
# A bare repository stores history only, no working directory — exactly like GitHub.
git init --bare -b master "$BASE/remote.git" --quiet

echo "== Step 2. Create a local repository =="
mkdir -p "$BASE/local"
cd "$BASE/local"
git init --quiet
git branch -M master
echo "Hello, GitHub!" > hello.txt
git add hello.txt
git commit --quiet -m "feat: add hello"

echo "== Step 3. Connect and push =="
git remote add origin "$BASE/remote.git"
git push -u origin master

echo ""
echo "== Step 4. A second developer clones the remote =="
git clone --quiet "$BASE/remote.git" "$BASE/colleague"
cd "$BASE/colleague"
echo "-- colleague sees:" && ls && git log --oneline

echo "== Step 5. Colleague pushes a change =="
echo "Colleague's line" >> hello.txt
git add hello.txt
git commit --quiet -m "docs: add colleague line"
git push --quiet origin master

echo ""
echo "== Step 6. We pull the change =="
cd "$BASE/local"
git pull --quiet
echo "Our hello.txt now:" && cat hello.txt
git log --oneline --graph

echo ""
echo "== Finish =="
echo "Simulated remote: $BASE/remote.git"
echo "Real-world equivalent: replace the local path with https://github.com/<user>/<repo>.git"