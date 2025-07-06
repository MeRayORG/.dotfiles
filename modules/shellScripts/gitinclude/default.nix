{ mkBaScript
, config
, pkgs
, aPath
, ...
}@set:
mkBaScript "gitinclude"
''
TARGET_DIR="''${1:-.}"
INCLUDE_FILE="$TARGET_DIR/.gitinclude"

if [[ ! -f "$INCLUDE_FILE" ]]; then
  echo "❌ Error: No '.gitinclude' file found in '$TARGET_DIR'" >&2
  exit 1
fi

# Read file contents, filter out empty lines and comments, convert to space-separated string
FILES=$(grep -vE '^\s*$|^\s*#' "$INCLUDE_FILE" | xargs)

if [[ -z "$FILES" ]]; then
  echo "⚠️  No valid entries in .gitinclude" >&2
  exit 0
fi

# Add all files in a single git command
git -C "$TARGET_DIR" add $FILES
''
