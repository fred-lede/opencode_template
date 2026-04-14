#!/usr/bin/env bash
# =============================================================================
# OpenCode Template - Enhanced Bootstrap (Bash / POSIX)
# =============================================================================
# Features:
# - Copy template to target directory with safety checks
# - Optional --dry-run and --validate modes
# - Placeholder replacement ({{PROJECT_NAME}}, {{DATE}})
# - Git initialization
# =============================================================================
# Usage:
#   ./bootstrap.sh                            # interactive (uses parent dir name)
#   ./bootstrap.sh --name "my_project"        # use specified name
#   ./bootstrap.sh --dry-run                  # preview only
#   ./bootstrap.sh --validate                 # check prerequisites only
# =============================================================================

set -euo pipefail

# Colors (fallback if terminal doesn't support)
if [ -t 1 ]; then
  RED='\033[0;31m'
  GREEN='\033[0;32m'
  YELLOW='\033[1;33m'
  CYAN='\033[0;36m'
  WHITE='\033[1;37m'
  NC='\033[0m' # No Color
else
  RED=''
  GREEN=''
  YELLOW=''
  CYAN=''
  WHITE=''
  NC=''
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PARENT_DIR="$(dirname "$TEMPLATE_ROOT")"

TARGET_NAME=""
DRY_RUN=false
VALIDATE_ONLY=false

usage() {
  echo "Usage: $0 [OPTIONS]"
  echo ""
  echo "Options:"
  echo "  --name <project>    Set project name (default: parent dir name)"
  echo "  --dry-run           Preview what would be done without making changes"
  echo "  --validate          Run prerequisite checks only"
  echo "  --help              Show this help message"
  echo ""
  echo "Examples:"
  echo "  $0 --name my_project      # Create 'my_project' from template"
  echo "  $0 --dry-run             # Preview copy operation"
  echo "  $0 --validate            # Check if copy would succeed"
  exit 0
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=true; shift;;
    --validate) VALIDATE_ONLY=true; shift;;
    --name) shift; TARGET_NAME="$1"; shift;;
    --name=*) TARGET_NAME="${1#*=}"; shift;;
    --help|-h) usage;;
    *) echo "Unknown option: $1"; exit 1;;
  esac
done

if [ -z "$TARGET_NAME" ]; then
  TARGET_NAME="$(basename "$PARENT_DIR")"
fi

# Sanitize name (remove invalid chars for paths)
TARGET_NAME="$(echo "$TARGET_NAME" | sed 's/[\\/:*?"<>|]/_/g')"
TARGET_PATH="$PARENT_DIR/$TARGET_NAME"

echo -e "${CYAN}============================================${NC}"
echo -e "${CYAN} OpenCode Template Bootstrap (Bash)${NC}"
echo -e "${CYAN}============================================${NC}"
echo ""
echo -e "[Info] Template : ${TEMPLATE_ROOT}"
echo -e "[Info] Target   : ${TARGET_PATH}"
echo ""

# Validation mode
if $VALIDATE_ONLY; then
  echo -e "[${YELLOW}Validate${NC}] Running prerequisite checks..."
  errors=0

  if [ -d "$TARGET_PATH" ]; then
    echo -e "[${RED}X${NC}] Target path already exists: $TARGET_PATH"
    errors=$((errors + 1))
  else
    echo -e "[${GREEN}OK${NC}] Target path is available"
  fi

  required_files=(
    "docs/requirements.md"
    "docs/architecture.md"
    "docs/api_spec.md"
    "docs/database_schema.md"
    "specs/feature_list.md"
    "TASK.md"
    "PROGRESS.md"
    "HANDOFF.md"
  )
  missing=0
  for f in "${required_files[@]}"; do
    if [ ! -f "$TEMPLATE_ROOT/$f" ]; then
      echo -e "[${YELLOW}!${NC}] Missing required file: $f"
      missing=$((missing + 1))
    fi
  done
  if [ $missing -eq 0 ]; then
    echo -e "[${GREEN}OK${NC}] All required template files present"
  else
    echo -e "[${YELLOW}!${NC}] $missing required files missing"
  fi

  if [ $errors -eq 0 ]; then
    echo ""
    echo -e "[${GREEN}Validate${NC}] All checks passed. Safe to proceed."
  else
    echo ""
    echo -e "[${RED}Validate${NC}] Found $errors error(s). Please resolve before proceeding."
  fi
  exit $errors
fi

# Dry-run mode
if $DRY_RUN; then
  echo -e "[${YELLOW}Dry-Run${NC}] No changes will be made."
  echo ""
  echo -e "[${YELLOW}Dry-Run${NC}] Would perform:"
  echo -e "  1. Copy '${TEMPLATE_ROOT}' to '${TARGET_PATH}'"
  echo -e "  2. Replace {{PROJECT_NAME}} -> '${TARGET_NAME}'"
  echo -e "  3. Replace {{DATE}} -> '$(date +%Y-%m-%d)'"
  echo -e "  4. Initialize git (if not exists)"
  echo ""
  echo -e "To execute, run without ${YELLOW}--dry-run${NC}"
  exit 0
fi

# Confirmation prompt
echo -e "This will create a new project at:"
echo -e "  ${WHITE}${TARGET_PATH}${NC}"
echo ""
read -p "Proceed? (y/N) " confirmation
if [ "$confirmation" != "y" ] && [ "$confirmation" != "Y" ]; then
  echo -e "[${RED}Abort${NC}] Bootstrap cancelled."
  exit 0
fi

# Full execution
echo ""
echo -e "[${CYAN}Step 1/4${NC}] Copying template..."
if ! cp -a "$TEMPLATE_ROOT/." "$TARGET_PATH/"; then
  echo -e "[${RED}Error${NC}] Failed to copy template."
  exit 1
fi
echo -e "[${GREEN}OK${NC}] Template copied"

echo -e "[${CYAN}Step 2/4${NC}] Replacing placeholders..."
replace() {
  local f="$1"
  if [ -f "$f" ]; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
      sed -i '' "s/{{PROJECT_NAME}}/$TARGET_NAME/g" "$f" 2>/dev/null || true
      sed -i '' "s/{{DATE}}/$(date +%Y-%m-%d)/g" "$f" 2>/dev/null || true
    else
      sed -i "s/{{PROJECT_NAME}}/$TARGET_NAME/g" "$f" 2>/dev/null || true
      sed -i "s/{{DATE}}/$(date +%Y-%m-%d)/g" "$f" 2>/dev/null || true
    fi
  fi
}

paths=(
  "$TARGET_PATH/docs/requirements.md"
  "$TARGET_PATH/docs/architecture.md"
  "$TARGET_PATH/docs/api_spec.md"
  "$TARGET_PATH/docs/database_schema.md"
  "$TARGET_PATH/specs/feature_list.md"
  "$TARGET_PATH/TASK.md"
  "$TARGET_PATH/PROGRESS.md"
  "$TARGET_PATH/HANDOFF.md"
)
replaced=0
for p in "${paths[@]}"; do
  replace "$p" && replaced=$((replaced + 1))
done
echo -e "[${GREEN}OK${NC}] Replaced placeholders in $replaced file(s)"

echo -e "[${CYAN}Step 3/4${NC}] Initializing git..."
if [ ! -d "$TARGET_PATH/.git" ]; then
  (cd "$TARGET_PATH" && git init -q && git add . && git commit -q -m "Bootstrap: initial project from OpenCode template")
  echo -e "[${GREEN}OK${NC}] Git initialized with initial commit"
else
  echo -e "[${YELLOW}Skip${NC}] Git already initialized"
fi

echo -e "[${CYAN}Step 4/4${NC}] Finalizing..."
echo ""
echo -e "${GREEN}============================================${NC}"
echo -e "${GREEN} Bootstrap Complete!${NC}"
echo -e "${GREEN}============================================${NC}"
echo ""
echo -e "New project created at:"
echo -e "  ${WHITE}${TARGET_PATH}${NC}"
echo ""
echo -e "Next steps:"
echo -e "  1. cd ${TARGET_NAME}"
echo -e "  2. Edit docs/requirements.md to define your project"
echo -e "  3. Edit docs/architecture.md for system design"
echo -e "  4. Run 'opencode' to start development"
echo ""
