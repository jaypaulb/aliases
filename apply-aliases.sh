#!/bin/bash
#
# Apply aliases from this repository to ~/.bashrc
#

ALIASES_FILE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/aliases"
BASHRC="$HOME/.bashrc"
SOURCE_LINE="source $ALIASES_FILE"

# Check if the source line already exists in .bashrc
if grep -qF "$SOURCE_LINE" "$BASHRC" 2>/dev/null; then
    echo "Aliases are already configured in $BASHRC"
else
    echo "" >> "$BASHRC"
    echo "# Custom aliases from aliases repo" >> "$BASHRC"
    echo "$SOURCE_LINE" >> "$BASHRC"
    echo "Added source line to $BASHRC"
fi

# Reload bashrc in the current shell
echo "Reloading .bashrc..."
source "$BASHRC"

echo "Done! Aliases are now active."
