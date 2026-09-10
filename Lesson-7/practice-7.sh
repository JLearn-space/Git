#!/usr/bin/env bash
# Lesson 7 — Practice: .gitignore and project hygiene.
set -e

BASE="${TMPDIR:-/tmp}/lesson-7"
rm -rf "$BASE"
mkdir -p "$BASE/tidy-project"
cd "$BASE/tidy-project"

echo "== Step 1. Init a project =="
git init --quiet

echo "== Step 2. Write .gitignore =="
cat > .gitignore <<'EOF'
.DS_Store
.vscode/
build/
*.log
!important.log
.env
.env.*
!.env.example
EOF

echo "== Step 3. Add project files (empty folders keep .gitkeep) =="
mkdir -p src images build
touch src/.gitkeep images/.gitkeep
echo "tidy-project" > README.md
echo "API_KEY=" > .env.example
echo "DEBUG_KEY=supersecret" > .env
echo "something" > debug.log
echo "important" > important.log

echo "-- git status:"
git status --short

echo ""
echo "== Step 4. Check: env, debug.log, build/ must be hidden =="
git check-ignore .env debug.log build/ && echo "OK: locked out"

echo "== Step 5. Commit the clean set =="
git add .
git status --short
git commit --quiet -m "chore: initial tidy project"
echo "-- committed files:"
git ls-files

echo ""
echo "== Step 6. Proving .gitignore guards NEW files only =="
echo "oops already tracked" > .env.example
git add .env.example
git commit --quiet -m "docs: fill example"
git ls-files | grep -E "(^\\.env$|^\\.env\\.example$)" && echo "note: tracked files stay tracked"

echo ""
echo "== Finish =="
echo "Repo ready at: $BASE/tidy-project"