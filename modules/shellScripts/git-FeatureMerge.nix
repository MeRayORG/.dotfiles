{ mkBaScript
, config
, pkgs
, aPath
, ...
}:
mkBaScript "git-FeatureMerge"
''
#!/usr/bin/env bash
set -e

# Get current branch
current_branch=$(git symbolic-ref --short HEAD)

# Abort if on main
if [ "$current_branch" = "main" ]; then
  echo "Error: You are on 'main'. Please switch to a feature branch."
  exit 1
fi

# Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
  echo "Error: You have uncommitted changes. Please commit or stash them first."
  exit 1
fi

# Fetch remote changes for the current branch
git fetch origin "$current_branch"

# Abort if remote has changes not in local
if ! git diff --quiet "$current_branch" "origin/$current_branch"; then
  echo "Error: Remote branch has changes you do not have. Pull or rebase first."
  exit 1
fi

# Ask for new commit message
read -rp "Feature message: " new_message
full_message="$new_message [$current_branch]"

# Squash all commits on the current branch into one
git reset --soft $(git merge-base main "$current_branch")
git commit -m "$full_message"

# Merge into main (fast-forward only)
git checkout main
git merge --ff-only "$current_branch"

# Delete feature branch locally and remotely
git branch -D "$current_branch"
git push origin --delete "$current_branch"

echo "Merged Feature '$current_branch' into main."

''