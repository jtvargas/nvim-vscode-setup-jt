#!/usr/bin/env bash
set -euo pipefail

# ─────────────────────────────────────────────────────────────
# iTerm2 Cmd → Ctrl Key Remapping for Neovim
# Allows you to press Cmd+S, Cmd+P, Cmd+D, etc. in iTerm2
# and have Neovim receive the Ctrl equivalent.
#
# Run: bash setup-iterm-keys.sh
# ─────────────────────────────────────────────────────────────

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

info()  { echo -e "${BLUE}[INFO]${NC} $1"; }
ok()    { echo -e "${GREEN}[OK]${NC} $1"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
fail()  { echo -e "${RED}[FAIL]${NC} $1"; exit 1; }

# Check iTerm2 is installed
if ! defaults read com.googlecode.iterm2 &>/dev/null; then
  fail "iTerm2 preferences not found. Is iTerm2 installed?"
fi

echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   iTerm2 Cmd → Ctrl Key Mapping Setup        ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════╝${NC}"
echo ""

warn "iTerm2 must be CLOSED before running this script."
echo -e "  Otherwise changes may be overwritten when iTerm2 quits."
echo ""
read -p "Is iTerm2 closed? (y/n) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Please close iTerm2 first, then re-run this script."
  exit 0
fi

# ── Define key mappings ──────────────────────────────────────
# Format: "KeyCode ModifierHex VirtualKeyCode HexToSend Description"
# Cmd modifier = 0x100000 (262144)
# Action 11 = Send Hex Code

# iTerm2 GlobalKeyMap key format: "0x{charCode}-0x{modifiers}-0x{virtualKeyCode}"
# Cmd = 0x100000

info "Adding Cmd key mappings to iTerm2 GlobalKeyMap..."

/usr/bin/python3 << 'PYTHON_SCRIPT'
import subprocess
import plistlib
import sys

# Read current GlobalKeyMap
try:
    result = subprocess.run(
        ["defaults", "export", "com.googlecode.iterm2", "-"],
        capture_output=True, check=True
    )
    plist = plistlib.loads(result.stdout)
except Exception as e:
    print(f"Error reading iTerm2 preferences: {e}")
    sys.exit(1)

global_key_map = plist.get("GlobalKeyMap", {})

# Key mappings: (key_identifier, hex_to_send, description)
# key_identifier = "0x{ascii_hex}-0x100000-0x{virtual_keycode}"
# Action 11 = Send Hex Codes
mappings = [
    # Cmd+S -> Ctrl+S (0x13)
    ("0x73-0x100000-0x1", "0x13", "Cmd+S → Ctrl+S (Save)"),
    # Cmd+Z -> Ctrl+Z (0x1a)
    ("0x7a-0x100000-0x6", "0x1a", "Cmd+Z → Ctrl+Z (Undo)"),
    # Cmd+Y -> Ctrl+Y (0x19)
    ("0x79-0x100000-0x10", "0x19", "Cmd+Y → Ctrl+Y (Redo)"),
    # Cmd+A -> Ctrl+A (0x01)
    ("0x61-0x100000-0x0", "0x01", "Cmd+A → Ctrl+A (Select All)"),
    # Cmd+P -> Ctrl+P (0x10)
    ("0x70-0x100000-0x23", "0x10", "Cmd+P → Ctrl+P (Find Files)"),
    # Cmd+F -> Ctrl+F (0x06)
    ("0x66-0x100000-0x3", "0x06", "Cmd+F → Ctrl+F (Search File)"),
    # Cmd+G -> Ctrl+G (0x07)
    ("0x67-0x100000-0x5", "0x07", "Cmd+G → Ctrl+G (Grep)"),
    # Cmd+W -> Ctrl+W (0x17)
    ("0x77-0x100000-0x0d", "0x17", "Cmd+W → Ctrl+W (Close Buffer)"),
    # Cmd+D -> Ctrl+D (0x04)
    ("0x64-0x100000-0x2", "0x04", "Cmd+D → Ctrl+D (Multi-Select)"),
    # Cmd+B -> Ctrl+B (0x02)
    ("0x62-0x100000-0xb", "0x02", "Cmd+B → Ctrl+B (File Explorer)"),
    # Cmd+\ -> Ctrl+\ (0x1c)
    ("0x5c-0x100000-0x2a", "0x1c", "Cmd+\\ → Ctrl+\\ (Split)"),
]

added = 0
skipped = 0

for key_id, hex_code, desc in mappings:
    if key_id in global_key_map:
        print(f"  SKIP: {desc} (already mapped)")
        skipped += 1
    else:
        global_key_map[key_id] = {
            "Action": 11,  # Send Hex Code
            "Text": hex_code,
            "Version": 1,
        }
        print(f"  ADD:  {desc}")
        added += 1

plist["GlobalKeyMap"] = global_key_map

# Write back
try:
    plist_bytes = plistlib.dumps(plist)
    subprocess.run(
        ["defaults", "import", "com.googlecode.iterm2", "-"],
        input=plist_bytes, check=True
    )
except Exception as e:
    print(f"Error writing iTerm2 preferences: {e}")
    sys.exit(1)

print(f"\nDone: {added} added, {skipped} skipped (already existed)")
PYTHON_SCRIPT

ok "iTerm2 key mappings configured!"
echo ""
echo -e "Now open iTerm2 and verify:"
echo -e "  ${BLUE}1.${NC} Go to ${YELLOW}Settings > Keys > Key Bindings${NC}"
echo -e "  ${BLUE}2.${NC} You should see the new Cmd mappings listed"
echo -e "  ${BLUE}3.${NC} Open Neovim and try ${YELLOW}Cmd+S${NC} to save, ${YELLOW}Cmd+P${NC} to find files"
echo ""
echo -e "${GREEN}You can now use Cmd shortcuts in Neovim just like VSCode!${NC}"
echo ""
