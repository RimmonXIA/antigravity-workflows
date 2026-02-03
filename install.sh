#!/bin/bash
# Antigravity Workflows Installer
# Usage: ./install.sh [--global] [--uninstall]

set -e

# --- Configuration ---
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MANIFEST_FILE=".antigravity_manifest"
GLOBAL_ROOT="$HOME/.gemini/antigravity"
DATE_STR=$(date "+%Y-%m-%d %H:%M:%S")

# --- Colors ---
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# --- Defaults ---
MODE="install"
SCOPE="local"
TARGET_DIR="$(pwd)"
FORCE=false

# --- Statistics ---
CNT_INSTALLED=0
CNT_SKIPPED=0
CNT_CONFLICT=0
CNT_REMOVED=0
CNT_MISSING=0


# --- Argument Parsing ---
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --global) SCOPE="global"; TARGET_DIR="$GLOBAL_ROOT"; ;;
        --uninstall) MODE="uninstall"; ;;
        -y|--yes) FORCE=true ;;
        -h|--help)
            echo "Usage: ./install.sh [--global] [--uninstall] [--yes]"
            echo "  --global    Install to global user scope (~/.gemini/antigravity)"
            echo "  --uninstall Remove installed files"
            echo "  --yes       Skip confirmation prompts"
            exit 0
            ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_err() { echo -e "${RED}[ERROR]${NC} $1"; }

# --- Helper Functions ---

# install_file <source_rel_path> <target_base>
install_file() {
    local rel_path=$1
    local src="$REPO_ROOT/$rel_path"
    local dest="$2/$rel_path"
    local dest_dir
    dest_dir=$(dirname "$dest")

    # Global Mapping Special Cases
    if [[ "$SCOPE" == "global" ]]; then
        if [[ "$rel_path" == .agent/workflows/* ]]; then
            # Map .agent/workflows/X -> global_workflows/X
            local fname=$(basename "$rel_path")
            dest="$GLOBAL_ROOT/global_workflows/$fname"
            dest_dir=$(dirname "$dest")
        elif [[ "$rel_path" == .agent/skills/* ]]; then
            # Map .agent/skills/X -> global_skills/X
            # Need to handle directories recursively or just mapping structure
            # rel_path is like .agent/skills/skill-name/SKILL.md
            # We want ~/.gemini/antigravity/global_skills/skill-name/SKILL.md
            local subpath="${rel_path#.agent/skills/}"
            dest="$GLOBAL_ROOT/global_skills/$subpath"
            dest_dir=$(dirname "$dest")
        elif [[ "$rel_path" == .agent/rules/* ]]; then
             # Global Rules go to GEMINI.md, skipping specific rules file copy for now
             # Or we could warn.
             log_warn "Skipping rule $rel_path for global install (Manual update of GEMINI.md required)"
             return
        fi
    fi
    
    # 1. Ensure dest dir exists
    mkdir -p "$dest_dir"

    # 2. Check overlap
    if [[ -f "$dest" ]]; then
        if cmp -s "$src" "$dest"; then
            # Identical
            echo "  [SKIP] $rel_path (Up to date)"
            ((CNT_SKIPPED++)) || true
            return
        else
            # Differ - Prompt or Backup? For V1, we skip to be safe, unless it's a manifest update
            log_warn "  [CONFLICT] $dest exists and differs. Skipping."
            ((CNT_CONFLICT++)) || true
            return
        fi
    fi

    # 3. Copy
    cp "$src" "$dest"
    cp "$src" "$dest"
    echo "  [INSTALL] $dest"
    ((CNT_INSTALLED++)) || true
    
    # 4. Add to manifest (relative to install root)
    # We store the absolute path in manifest to be unambiguous during uninstall
    echo "$dest" >> "$TARGET_DIR/$MANIFEST_FILE"
}

uninstall_all() {
    local manifest="$TARGET_DIR/$MANIFEST_FILE"
    if [[ ! -f "$manifest" ]]; then
        log_err "No manifest found at $manifest. Cannot safely uninstall."
        exit 1
    fi

    log_info "Uninstalling from $TARGET_DIR..."

    # Safety: Confirmation
    if [[ "$FORCE" != "true" ]]; then
        echo -n "Are you sure you want to uninstall from $TARGET_DIR? [y/N] "
        read -r response
        if [[ ! "$response" =~ ^[Yy]$ ]]; then
            log_info "Uninstallation aborted."
            exit 0
        fi
    fi
    
    # Read manifest in reverse order to tolerate directories better (though we use rm files)
    # We will just remove files listed.
    while IFS= read -r file_path || [[ -n "$file_path" ]]; do
        # Safety: Path Sanity Check
        # Ensure file_path is within TARGET_DIR (simple prefix match)
        # Verify realpath to avoid ../ escapes? For now, we trust the manifest generation but verify prefix.
        if [[ "$file_path" != "$TARGET_DIR"* ]]; then
             log_warn "Skipping unsafe path (outside target): $file_path"
             continue
        fi

        if [[ -f "$file_path" ]]; then
             echo "  [REMOVE] $file_path"
             rm "$file_path"
             ((CNT_REMOVED++)) || true
        else
             echo "  [MISSING] $file_path (Already gone)"
             ((CNT_MISSING++)) || true
        fi
    done < "$manifest"

    # Cleanup manifest
    rm "$manifest"
    log_info "Uninstallation complete."
    
    # Prune empty dirs (optional, conservative approach)
    find "$TARGET_DIR/.agent" -type d -empty -delete 2>/dev/null || true
    
    print_stats
}

print_stats() {
    echo ""
    echo -e "${GREEN}--- Execution Statistics ---${NC}"
    if [[ "$MODE" == "uninstall" ]]; then
        echo "  Files Removed: $CNT_REMOVED"
        echo "  Files Missing: $CNT_MISSING"
    else
        echo "  New Installed: $CNT_INSTALLED"
        echo "  Up-to-Date:    $CNT_SKIPPED"
        echo "  Conflicts:     $CNT_CONFLICT"
    fi
     echo -e "${GREEN}----------------------------${NC}"
}

# --- Main Logic ---

if [[ "$MODE" == "uninstall" ]]; then
    uninstall_all
    exit 0
fi

log_info "Starting installation ($SCOPE scope)..."
log_info "Target: $TARGET_DIR"

# Initialize Manifest
mkdir -p "$TARGET_DIR"
# Don't truncate manifest yet, we append. But if we want a fresh start, maybe filtering duplicates later?
# Let's just create if not exists
touch "$TARGET_DIR/$MANIFEST_FILE"

# 1. Install Workflows
# 1. Install Workflows
log_info "Installing Workflows..."
while read -r file; do
    rel_path="${file#$REPO_ROOT/}"
    install_file "$rel_path" "$TARGET_DIR"
done < <(find "$REPO_ROOT/.agent/workflows" -name "*.md")

# 2. Install Skills
# 2. Install Skills
log_info "Installing Skills..."
while read -r file; do
    rel_path="${file#$REPO_ROOT/}"
    install_file "$rel_path" "$TARGET_DIR"
done < <(find "$REPO_ROOT/.agent/skills" -name "*" -type f)

# 3. Install Rules (Local Only)
# 3. Install Rules (Local Only)
if [[ "$SCOPE" == "local" ]]; then
    log_info "Installing Rules..."
    while read -r file; do
        rel_path="${file#$REPO_ROOT/}"
        install_file "$rel_path" "$TARGET_DIR"
    done < <(find "$REPO_ROOT/.agent/rules" -name "*.md")
fi

# Clean up manifest duplicates
sort -u "$TARGET_DIR/$MANIFEST_FILE" -o "$TARGET_DIR/$MANIFEST_FILE"

log_info "Installation Complete!"
log_info "Manifest saved to $TARGET_DIR/$MANIFEST_FILE"
print_stats
