## History, Tags and Releases

> **Connection with the previous lesson:** your project is clean and well-kept. Now let's make it "official": learn to read the project's history, tag versions properly, and publish releases on GitHub — exactly how real software versions work.

---

## Lesson Goal

Master working with the repository history: navigate commits, compare versions, understand semantic versioning, and use tags and GitHub Releases to publish stable versions of a project.

## What You Will Learn by the End of the Lesson

- Read history with `git log` and inspect commits with `git show`.
- Compare commits and versions with `git diff`.
- Number versions correctly — semantic versioning `MAJOR.MINOR.PATCH`.
- Create tags `git tag` and publish them to GitHub.
- Create a GitHub Release with release notes.

---

## Lesson Timeline

| Block | Content |
| --- | --- |
| 1. Reading history | `git log`, `git show`, `git blame` |
| 2. Comparing versions | `git diff` between commits |
| 3. Semantic versioning | MAJOR.MINOR.PATCH rules |
| 4. Tags | Lightweight and annotated tags |
| 5. Releases and CHANGELOG | Publish a version for people |
| 6. Mini-task | Tag a journey |
| 7. Summary and practice | Reinforcement |

---

## Block 1. Reading History

The commit log is the project's diary. Your most important reading commands:

### `git log`

```bash
git log            # full history, who-when-what
git log --oneline  # one line per commit — the everyday view
git log --graph    # branches shown as a tree
git log --stat     # which files changed in each commit
git log -p         # full diff of every commit (long!)
```

Filters come in handy too:

```bash
git log --oneline --author="Javlon"      # only this author's commits
git log --oneline --since="2 weeks ago"  # only recent
git log --oneline -n 5                   # just the last five
git log --oneline -- README.md           # only commits touching README.md
```

**Pro tip:** after `--oneline` add `-g` to see the *reflog* — a log of everything that happened in the repository, including resets and rebases.

### `git show`

View a single commit in detail:

```bash
git show HEAD          # the most recent commit
git show 8f3d2c1       # a specific commit by hash
git show HEAD~1        # the commit before HEAD
```

`HEAD~N` — N commits back (parent chain). `HEAD~1` equals `HEAD^`.

### `git blame`

Who wrote which line:

```bash
git blame README.md
```

Each line shows the commit, author, and date that touched it last. Invaluable when you find a bug and need "who and why changed that line."

---

## Block 2. Comparing Versions

`git diff` answers "what changed between two points?".

```bash
git diff                    # working directory vs index (what isn't staged)
git diff --staged           # index vs last commit (what IS staged)
git diff HEAD               # everything uncommitted, staged and not
git diff 8f3d2c1..4b5a1c2   # between two commits
git diff v1.0.0 v1.1.0      # between two tags
```

Real usage: you receive pull-request feedback and want to see exactly what the reviewer's branch introduces compared to main:

```bash
git diff main..feature/contact
```

Lines starting with `-` were removed, `+` were added. This is the language of code discussion in teams — everyone speaks `git diff`.

---

## Block 3. Semantic Versioning

How do you number versions so everyone understands? Meet **SemVer** — the international standard:

```text
MAJOR.MINOR.PATCH        e.g. 1.4.2
```

| Part | When it increases |
| --- | --- |
| **MAJOR** | Breaking changes — old code may stop working |
| **MINOR** | New features, still backward compatible |
| **PATCH** | Bug fixes only |

Examples:

- `1.0.0` — first public release.
- `1.0.1` — fixed a bug, nothing new.
- `1.1.0` — added a feature.
- `2.0.0` — broke something; everyone who used `1.x` must check.

**Rule of thumb:** if existing users "might break" — the major version grows; if not, minor or patch.

---

## Block 4. Tags

A **git tag** puts a name on a specific commit — like a bookmark in history that never moves.

### Create

```bash
git tag v1.0.0              # lightweight tag
git tag -a v1.0.1 -m "Release 1.0.1"   # annotated tag
```

| Type | Contains | When |
| --- | --- | --- |
| **Lightweight** | just a name pointer | quick marks, drafts |
| **Annotated** | name + author + date + message | real releases — recommended |

### View and navigate

```bash
git tag          # list tags
git tag -l "v1.*" # filter
git show v1.0.0  # see the tagged commit
git diff v1.0.0 v1.1.0   # what changed between releases
```

### Publish to GitHub

Tags don't go to the remote by themselves:

```bash
git push origin v1.0.0        # one tag
git push origin --tags        # all tags
```

Delete a tag (local + remote):

```bash
git tag -d v1.0.0
git push origin --delete v1.0.0
```

**Warning:** a tag should never move — if you need a "new" version, create a new tag. Rewriting tags confuses everyone who already downloaded them.

---

## Block 5. Releases and CHANGELOG

A tag is technical; a **Release** is for people. On GitHub: open the repository → **Releases** → **Draft a new release** → choose an existing tag (or create a new one) → write release notes → publish.

Release notes usually contain:

- what's new (features);
- changes (improvements);
- fixes;
- breaking changes (if the major version grew);
- thanks to contributors.

GitHub automatically generates an archive (`zip`/`tar.gz`) with the tagged code — distribution without the `.git` folder.

### CHANGELOG

Many mature projects keep a `CHANGELOG.md` — a chronological list of releases. The "Keep a Changelog" convention recommends:

```text
## [Unreleased]
- Planned short-term changes

## [1.1.0] - 2026-05-12
### Added
- new feature
### Fixed
- bug description
```

CHANGELOG + tags + releases = a project anyone can understand and use without reading source code.

---

## Block 6. Mini-Task

On a small learning project:

1. View the whole history as a tree: `git log --oneline --graph`.
2. Look at the very first commit with `git show`.
3. Create an annotated tag `v1.0.0` for the current state.
4. "Publish" it to the remote in the simulator script.

**Solution:**

```bash
git log --oneline --graph
git show $(git rev-list --max-parents=0 HEAD)   # the very first commit
git tag -a v1.0.0 -m "Release 1.0.0"
git push origin v1.0.0
```

---

## Lesson Summary

Today you learned:

- **Reading history:** `git log` (with `--graph`, `--stat`, filters), `git show`, `git blame`.
- **`git diff`** — compares commits, tags, and the working directory.
- **SemVer** — when the major, minor, or patch digit grows.
- **Tags** — lightweight and annotated; how to push and delete them.
- **Releases** on GitHub: notes, archives, and the `CHANGELOG.md` convention.

---

## Practice

Turn "tidy-project" from the previous lesson into a versioned project:

1. Create 3–4 commits, simulating feature development (e.g., add `index.html`, then a style fix).
2. Look at the history: `git log --oneline --graph`.
3. Compare two commits: `git diff <hash-1>..<hash-2>`.
4. Create annotated tags: `v1.0.0` after "stable enough", then `v1.0.1` after a bugfix.
5. Simulate publishing: `git push origin --tags` (in the practice script the remote is local).
6. Write a `CHANGELOG.md` with entries for both versions.

The `practice-8.sh` script walks through the whole scenario:

---

[Next lesson: Git Workflows →](../../Lesson-9/en/Git%20Workflows.md)