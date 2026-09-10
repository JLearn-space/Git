#!/usr/bin/env bash
# Lesson 8 — Practice: history, tags and releases.
set -e

BASE="${TMPDIR:-/tmp}/lesson-8"
rm -rf "$BASE"
mkdir -p "$BASE"
git init --bare -b master "$BASE/release.git" --quiet

echo "== Step 1. Build a small project history =="
mkdir -p "$BASE/app"
cd "$BASE/app"
git init --quiet
git branch -M master
echo "version 1" > app.txt
git add app.txt
git commit --quiet -m "feat: initial app"
echo "version 2" >> app.txt
git commit --quiet -am "fix: small correction"
echo "version 3 feature" >> app.txt
git commit --quiet -am "feat: add feature"

git remote add origin "$BASE/release.git"
git push --quiet origin master

echo ""
echo "== Step 2. Read the history =="
git log --oneline --graph

echo ""
echo "== Step 3. Compare two commits =="
git diff HEAD~2..HEAD -- app.txt

echo ""
echo "== Step 4. Tag a release (annotated) and publish =="
git tag -a v1.0.0 -m "Release 1.0.0"
git push --quiet origin v1.0.0

echo ""
echo "== Step 5. Bugfix -> v1.0.1 =="
echo "bug fixed" >> app.txt
git commit --quiet -am "fix: critical bug"
git tag -a v1.0.1 -m "Release 1.0.1"
git push --quiet origin v1.0.1

echo ""
echo "== Step 6. Tags and release diff =="
git tag
git diff v1.0.0 "v1.0.1" --stat
git show v1.0.0 --oneline --no-patch

echo ""
echo "== Step 7. Write a CHANGELOG =="
cat > CHANGELOG.md <<'EOF'
## [Unreleased]
- planned improvement

## [1.0.1] - today
### Fixed
- critical bug

## [1.0.0] - today
### Added
- initial app
EOF
git add CHANGELOG.md
git commit --quiet -m "docs: add changelog"

echo ""
echo "== Finish =="
echo "Remote with tags: $BASE/release.git"
echo "CHANGELOG:"
cat CHANGELOG.md