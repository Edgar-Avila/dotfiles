#!/bin/bash
set -euo pipefail

NEOVIM_DIR="$HOME/neovim"
INSTALLS_DIR="$HOME/neovim_installs"
INSTALLER_DIR="$HOME/neovim_installer"

# --- Dependency check ---
REQUIRED_CMDS=(g++ make cmake git)

for cmd in "${REQUIRED_CMDS[@]}"; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "❌ Missing required command: $cmd"
        echo "   Please install it and rerun this script."
        exit 1
    fi
done

# Ensure installs directory exists
mkdir -p "$INSTALLS_DIR"

# If a neovim folder exists, archive it with timestamp
if [ -d "$NEOVIM_DIR" ]; then
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    mv "$NEOVIM_DIR" "$INSTALLS_DIR/neovim_$TIMESTAMP"
    echo "Moved existing neovim to $INSTALLS_DIR/neovim_$TIMESTAMP"
fi

# Clean up old installer if present
if [ -d "$INSTALLER_DIR" ]; then
    rm -rf "$INSTALLER_DIR"
    echo "Removed old installer directory"
fi

# Clone latest stable
git clone https://github.com/neovim/neovim "$INSTALLER_DIR"
cd "$INSTALLER_DIR"
git checkout stable

# Ensure build directory is fresh
rm -rf build/

# Build & install
make CMAKE_BUILD_TYPE=Release \
     CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$NEOVIM_DIR"
make install

echo "Neovim installed into $NEOVIM_DIR"

# Check path
if [[ ":$PATH:" == *":$NEOVIM_DIR/bin:"* ]]; then
    echo "🔎 PATH already includes $NEOVIM_DIR/bin"
else
    echo "$NEOVIM_DIR/bin is not in your PATH."
    echo "To fix this, add the following line to your ~/.bashrc or ~/.profile:"
    echo ""
    echo "export PATH=\"\$HOME/neovim/bin:\$PATH\""
    echo ""
fi
