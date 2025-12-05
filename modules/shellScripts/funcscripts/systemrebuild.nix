{ config, ...}:
''
message="$@"

if [ -z "$message" ]; then
    echo "Usage: $0 [message]"
    exit 1
fi

cd ${config.mods.flakeDir}

git add -A .

currentgen=$(readlink /nix/var/nix/profiles/system | grep -o '[0-9]*')
nextgen=$((currentgen + 1))


# 1. Ensure Git working tree is clean
if ! git diff-index --quiet HEAD --; then
    echo "Git working directory not clean — commit or stash first"
    exit 1
fi


# 2. Build the system without switching
if ! sudo nixos-rebuild build  --flake . --option warn-dirty false ; then
    echo "Rebuild failed — aborting."
    exit 1
fi

# 3. Find last commit starting with '{'
last_marker_commit=$(git log --grep="^{" -n 1 --pretty=format:%H)
if [ -z "$last_marker_commit" ]; then
    echo "No previous commit starting with '{' found — aborting."
    exit 1
fi


# Soft reset to last marker commit
git reset --soft "$last_marker_commit"

# Gather previous commit messages since last marker
commit_msgs=$(git log --pretty=%B "$last_marker_commit..HEAD")

# Commit everything
git commit -m "{$nextgen} $message\n\n$commit_msgs"

# Switch/activate the new system
sudo nixos-rebuild switch --flake . --option warn-dirty false

echo "Version {$nextgen}"

''