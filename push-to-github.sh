#!/usr/bin/env bash
# Publish this folder to GitHub. Idempotent and verbose. Safe to re-run.
# Usage (from Git Bash, inside the engineering-skills folder):
#   ./push-to-github.sh

# ─── EDIT THESE ───────────────────────────────────────────────
ORG="ibrahim-hayeck"                 # your GitHub org OR username
REPO="claude-sdlc-skills"  # the repo name on GitHub
PROTO="ssh"                   # "ssh" or "https"
VISIBILITY="private"          # "private" or "public" (used only if we create the repo)
NAME="Ibrahim Hayeck"
EMAIL="ibrahim.hayeck@telus.com"
# ──────────────────────────────────────────────────────────────

# Do NOT use set -e here — we want every step to log, even on failure.
set -uo pipefail
step(){ echo ""; echo "── $* ──────────────────────────────"; }
die(){ echo ""; echo "✗ $*"; exit 1; }

if [ "$PROTO" = "https" ]; then URL="https://github.com/$ORG/$REPO.git"
else URL="git@github.com:$ORG/$REPO.git"; fi

cd "$(dirname "$0")" || die "cannot cd to script dir"
echo "Repo folder : $(pwd)"
echo "Target      : $ORG/$REPO  ($PROTO)"
echo "Remote URL  : $URL"

step "1. init"
[ -d .git ] || git init
git config user.name  >/dev/null 2>&1 || git config user.name  "$NAME"
git config user.email >/dev/null 2>&1 || git config user.email "$EMAIL"

step "2. commit"
if ! git rev-parse --verify HEAD >/dev/null 2>&1; then
  git add . && git commit -m "engineering-skills v0.1.0"
elif [ -n "$(git status --porcelain)" ]; then
  git add . && git commit -m "update engineering-skills"
else
  echo "nothing to commit"
fi
git branch -M main

step "3. origin"
if git remote get-url origin >/dev/null 2>&1; then git remote set-url origin "$URL"
else git remote add origin "$URL"; fi
echo "origin = $(git remote get-url origin)"

step "4. check auth + repo exists"
if [ "$PROTO" = "ssh" ]; then
  echo "testing ssh (a greeting = success, even though it 'exits 1'):"
  ssh -T git@github.com 2>&1 | sed 's/^/  ssh: /'
fi

if git ls-remote "$URL" >/dev/null 2>&1; then
  echo "✓ remote repo found"
else
  echo "✗ remote repo NOT found (missing, or no access)."
  if command -v gh >/dev/null 2>&1; then
    step "4b. creating repo with gh"
    gh repo create "$ORG/$REPO" --"$VISIBILITY" --source=. --remote=origin --push \
      && { echo "✓ created and pushed via gh"; echo ""; echo "Install: /plugin marketplace add $ORG/$REPO ; /plugin install engineering-skills@engineering-tools"; exit 0; } \
      || die "gh could not create $ORG/$REPO — check you're logged in ('gh auth status') and can create repos in '$ORG'."
  else
    echo ""
    echo "The GitHub CLI (gh) isn't installed, so I can't create it for you. Do ONE of:"
    echo "  • Create an EMPTY repo (no README/license) at: https://github.com/new"
    echo "      owner = $ORG   name = $REPO"
    echo "  • Or install gh (https://cli.github.com), run 'gh auth login', then re-run this script."
    echo "  • If '$ORG' isn't your org, set ORG to your own GitHub username at the top."
    die "repo must exist before pushing."
  fi
fi

step "5. push"
if git push -u origin main; then
  echo ""
  echo "✓ Done. Teammates can now run:"
  echo "    /plugin marketplace add $ORG/$REPO"
  echo "    /plugin install engineering-skills@engineering-tools"
else
  die "push failed — see the git error above (usually auth or access to '$ORG')."
fi
