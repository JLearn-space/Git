#!/usr/bin/env bash
# Lesson 10 — Practice: pre-push checks for the final portfolio project.
set -e

PROJECT="$1"
PROJECT="${PROJECT:-$PWD}"

echo "== Checking project structure =="
cd "$PROJECT"
for needed in index.html css/style.css; do
    test -f "$needed" || { echo "MISSING required file: $needed"; exit 1; }
    echo "found: $needed"
done

echo ""
echo "== Checking relative paths in index.html =="
if grep -q 'href="css/style.css"' index.html; then
    echo "OK: stylesheet uses a relative path"
else
    echo "WARNING: css link is not a relative path (css/style.css)"
fi

echo ""
echo "== Checking no absolute local paths leak into the page =="
if grep -q '/Users/\|C:\\\|file://' index.html css/style.css; then
    echo "WARNING: absolute local path found — the site won't work on GitHub Pages"
else
    echo "OK: no absolute local paths"
fi

echo ""
echo "== Checking git is initialized =="
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "OK: inside a git work tree"
    echo ""
    echo "-- Who is the author? (should be set from lesson 1):"
    git config user.name 2>/dev/null || echo "user.name NOT SET"
    git config user.email 2>/dev/null || echo "user.email NOT SET"
    echo ""
    echo "-- Status:"
    git status --short || true
    echo ""
    echo "-- Last commit:"
    git log --oneline -1 2>/dev/null || echo "no commits yet"
else
    echo "WARNING: not a git repository — run 'git init' before pushing"
fi

echo ""
echo "== Finish =="
echo "If everything looks right: git init && git add . && git commit -m \"feat: portfolio\" && git push -u origin main"