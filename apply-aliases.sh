#!/bin/bash
#
# Apply aliases from this repository to shell config
# Supports both bash (.bashrc) and zsh (.zshrc)
#

ALIASES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ALIASES_FILE="$ALIASES_DIR/aliases"

# Detect shell config file
if [[ "$SHELL" == *"zsh"* ]]; then
    SHELLRC="$HOME/.zshrc"
    SHELL_NAME="zsh"
else
    SHELLRC="$HOME/.bashrc"
    SHELL_NAME="bash"
fi

echo "Detected shell: $SHELL_NAME"
echo "Config file: $SHELLRC"
echo "Aliases directory: $ALIASES_DIR"
echo ""

# Check if config file exists, create if not
if [[ ! -f "$SHELLRC" ]]; then
    echo "Creating $SHELLRC..."
    touch "$SHELLRC"
fi

# Check if already configured
if grep -qF "ALIASES_REPO_DIR=" "$SHELLRC" 2>/dev/null; then
    echo "Aliases are already configured in $SHELLRC"
    echo "To update the path, remove the existing lines and re-run this script."
else
    echo "" >> "$SHELLRC"
    echo "# Custom aliases from aliases repo" >> "$SHELLRC"
    echo "export ALIASES_REPO_DIR=\"$ALIASES_DIR\"" >> "$SHELLRC"
    echo "source \"\$ALIASES_REPO_DIR/aliases\"" >> "$SHELLRC"
    echo "Added source lines to $SHELLRC"
fi

echo ""
echo "Reloading shell config..."
export ALIASES_REPO_DIR="$ALIASES_DIR"
source "$SHELLRC"

echo ""
echo "Done! Aliases are now active."
echo ""
echo "Note: Some aliases require additional tools:"
echo "  - eza (for ll, la, l, lss, lst): brew install eza"
echo "  - wakeonlan (for wol): brew install wakeonlan"
