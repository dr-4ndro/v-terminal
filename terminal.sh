#!/data/data/com.termux/files/usr/bin/bash
# ================================================
#  Terminal Setup Script (Persistent Banner Fix)
#  Includes Venv-aware Prompt + Embedded Banner
# ================================================

echo "=============================="
echo "  Starting Terminal Setup..."
echo "=============================="
echo ""

# ------------------------------------------------------------
#  Ask for custom username
# ------------------------------------------------------------
echo "╭── setup@termux [?]"
echo -ne "╰──▶ Enter username: "
read CUSTOM_USER_INPUT

if [ -z "$CUSTOM_USER_INPUT" ]; then
    CUSTOM_USER_INPUT="$(whoami)"
    echo "[i] Using current username: $CUSTOM_USER_INPUT"
else
    echo "[i] Username set to: $CUSTOM_USER_INPUT"
fi

# ------------------------------------------------------------
#  Install MesloLGS NF Font (optional but recommended)
# ------------------------------------------------------------
FONT_FILE="$HOME/.termux/font.ttf"
FONT_URL="https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"

if [ -f "$FONT_FILE" ] && [ -s "$FONT_FILE" ]; then
    echo "[i] Font already installed. Skipping download."
else
    echo "[+] Downloading font..."
    mkdir -p "$HOME/.termux"
    curl -sL -o "$FONT_FILE" "$FONT_URL"
    if [ $? -eq 0 ] && [ -s "$FONT_FILE" ]; then
        echo "[√] Font installed"
    else
        echo "[-] Font download failed. Check network."
        exit 1
    fi
fi

# ------------------------------------------------------------
#  Banner (already embedded as base64 – no external file needed)
# ------------------------------------------------------------
BANNER_B64="G1swbSAgICAbWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjsxOzE7MW1NG1szODsyOzE7MTswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1swbQobWzBtICAgIBtbMzg7MjswOzA7MG1NG1szODsyOzE7MTsxbU0bWzM4OzI7MTsxOzFtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MTsxOzFtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjsxOzE7MW1NG1szODsyOzE7MTsxbU0bWzM4OzI7MTsxOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzE7MTsxbU0bWzM4OzI7MDswOzBtTRtbMG0KG1swbSAgICAbWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzBtChtbMG0gICAgG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzBtChtbMG0gICAgG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MTsxOzFtTRtbMzg7MjsyOzE7MW1NG1szODsyOzE7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDsxOzBtTRtbMzg7MjsxOzE7MW1NG1szODsyOzE7MTsxbU0bWzM4OzI7MDsxOzFtTRtbMzg7Mjs4OzE7MW1NG1szODsyOzMxOzQ7Nm1XG1szODsyOzI5OzQ7NW1XG1szODsyOzEwOzE7MW1NG1szODsyOzI7MTsxbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1swbQobWzBtICAgIBtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MTsxbU0bWzM4OzI7NDsxOzFtTRtbMzg7Mjs3NDs5OzEwbU4bWzM4OzI7MTU2OzEyOzIxbTAbWzM4OzI7MTk1OzE4OzI5bU8bWzM4OzI7MTg4OzIxOzI5bU8bWzM4OzI7MTUzOzE5OzI0bTAbWzM4OzI7MTE1OzE3OzIwbUsbWzM4OzI7Njg7MTA7MTJtThtbMzg7MjszNDs1OzZtVxtbMzg7MjszMDs1OzVtVxtbMzg7Mjs2Njs3OzltThtbMzg7MjsxMjQ7NTsxNG1LG1szODsyOzE5MTs1OzIwbTAbWzM4OzI7MjE5OzU7MjVtTxtbMzg7MjsyMjI7OTsyN21PG1szODsyOzIxODsxNTszMG1rG1szODsyOzE5MDsxMzsyN21PG1szODsyOzE1NzsxMjsyMm0wG1szODsyOzExODsxMDsxN21LG1szODsyOzg0Ozg7MTNtWBtbMzg7Mjs0NTs2OzhtThtbMzg7MjsxMTsyOzJtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMG0KG1swbSAgICAbWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjsxOzE7MW1NG1szODsyOzA7MDswbU0bWzM4OzI7MTsxOzFtTRtbMzg7Mjs0OzE7MW1NG1szODsyOzEwMzsxMDsxM21YG1szODsyOzE3Mzs1OzE1bTAbWzM4OzI7MTg1OzU7MTZtMBtbMzg7MjsxOTQ7NjsxOG1PG1szODsyOzIxMTsxMDsyNW1PG1szODsyOzIxOTsxNTsyOW1rG1szODsyOzIyNjsyMTszNG1rG1szODsyOzIyOTsyNDszN214G1szODsyOzIzMjszMTszOW14G1szODsyOzIzMjszMjszOG14G1szODsyOzIzMDsyNjszMm14G1szODsyOzIyMjsyMzszMW1rG1szODsyOzIxNzsxODsyN21rG1szODsyOzIxNDs2OzIwbU8bWzM4OzI7MjE0OzI7MTltTxtbMzg7MjsyMTQ7MjsxOG1PG1szODsyOzIxNjszOzE5bU8bWzM4OzI7MjE4OzQ7MjBtTxtbMzg7MjsyMjM7NTsyMm1PG1szODsyOzIyNjs1OzI0bU8bWzM4OzI7MjI4OzExOzI4bWsbWzM4OzI7MjEzOzE0OzI4bWsbWzM4OzI7MTY4OzE1OzI0bTAbWzM4OzI7MTIxOzE1OzE5bUsbWzM4OzI7NzA7MTE7MTNtWBtbMzg7MjsyMDs0OzRtVxtbMzg7MjsxOzE7MW1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzE7MTsxbU0bWzBtChtbMG0gICAgG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzE7MTsxbU0bWzM4OzI7MTsxOzFtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MTswOzFtTRtbMzg7Mjs4MTs4OzEwbVgbWzM4OzI7MTQ4OzU7MTJtSxtbMzg7MjsxNDk7NjsxMW1LG1szODsyOzE1OTs2OzEzbTAbWzM4OzI7MTc3OzY7MTVtMBtbMzg7MjsxOTA7NjsxN20wG1szODsyOzE4Mzs3OzE3bTAbWzM4OzI7MTYyOzc7MTRtMBtbMzg7MjsxMzk7NzsxMW1LG1szODsyOzEzMzs5OzEybUsbWzM4OzI7MTQ0Ozg7MTNtSxtbMzg7MjsxNjk7MTE7MTdtMBtbMzg7MjsxODk7MTk7MjRtTxtbMzg7MjsyMDY7MjU7MzBtaxtbMzg7MjsyMTg7Mjk7MzNtaxtbMzg7MjsyMjc7Mjg7MzVteBtbMzg7MjsyMjg7Mjg7MzRteBtbMzg7MjsyMjQ7MTg7MjdtaxtbMzg7MjsyMTY7NDsxN21PG1szODsyOzIxODsyOzE4bU8bWzM4OzI7MjE2OzI7MThtTxtbMzg7MjsyMTk7MzsxOW1PG1szODsyOzIyMjszOzIwbU8bWzM4OzI7MjI1OzY7MjNtTxtbMzg7MjsyMzE7MTE7MjhtaxtbMzg7MjsyMzQ7MjM7MzVteBtbMzg7MjsyMjY7MjY7MzZtaxtbMzg7MjsxNzU7MjI7MjhtTxtbMzg7MjsxMDQ7MTU7MThtSxtbMzg7MjsxOTszOzNtVxtbMzg7MjsxOzE7MW1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzBtChtbMG0gICAgG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7NDc7NTs2bU4bWzM4OzI7MTM0OzY7MTFtSxtbMzg7MjsxMzI7NTs5bUsbWzM4OzI7MTQwOzY7MTFtSxtbMzg7MjsxNTI7NTsxMm1LG1szODsyOzE1Nzs1OzEybUsbWzM4OzI7MTY1OzY7MTNtMBtbMzg7MjsxNTI7NzsxMm1LG1szODsyOzEyNDs3OzltSxtbMzg7MjsxMDY7Njs4bVgbWzM4OzI7OTY7NTs3bVgbWzM4OzI7ODM7NDs2bU4bWzM4OzI7NzE7NDs1bU4bWzM4OzI7NjM7NDs1bU4bWzM4OzI7NzM7NDs1bU4bWzM4OzI7MTAxOzU7N21YG1szODsyOzEyODs2OzltSxtbMzg7MjsxNjE7MTI7MTZtMBtbMzg7MjsxODU7MjE7MjVtTxtbMzg7MjsyMTQ7Mjc7MzFtaxtbMzg7MjsyMzI7Mjc7MzZteBtbMzg7MjsyMzQ7MjU7MzVteBtbMzg7MjsyMzE7MTM7MjhtaxtbMzg7MjsyMjc7MzsyMm1PG1szODsyOzIyNTszOzIwbU8bWzM4OzI7MjIyOzM7MjBtTxtbMzg7MjsyMjU7NTsyMm1PG1szODsyOzIzMzsxMjsyOW1rG1szODsyOzIzNjsyMTszNW14G1szODsyOzIzODszMzszOW14G1szODsyOzE5MDsyMjsyOG1PG1szODsyOzMxOzQ7NW1XG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MTsxOzFtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzBtChtbMG0gICAgG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDsxOzFtTRtbMzg7MjsxODsyOzNtVxtbMzg7MjsxMjE7NzsxMW1LG1szODsyOzEyOTs0OzhtSxtbMzg7MjsxMjk7NTs4bUsbWzM4OzI7MTI2OzU7OG1LG1szODsyOzEzMDs2OzltSxtbMzg7MjsxNTM7NjsxMW1LG1szODsyOzE4MTs2OzE0bTAbWzM4OzI7MTkxOzg7MTdtMBtbMzg7MjsxNzc7NzsxNW0wG1szODsyOzE2Njs1OzEybTAbWzM4OzI7MTQzOzU7MTBtSxtbMzg7MjsxMjE7Njs5bUsbWzM4OzI7MTEwOzU7N21YG1szODsyOzk5OzU7Nm1YG1szODsyOzg3OzU7Nm1YG1szODsyOzczOzQ7NW1OG1szODsyOzYzOzM7NG1OG1szODsyOzYyOzM7M21OG1szODsyOzcwOzQ7NG1OG1szODsyOzEwMDs2OzdtWBtbMzg7MjsxNDI7OTsxMW1LG1szODsyOzE3NDsxNTsyMG0wG1szODsyOzIwODsyNzszMW1rG1szODsyOzIzNDsyNzszNm14G1szODsyOzIzOTsyOTszOW14G1szODsyOzI0MTszMzs0MW14G1szODsyOzI0MzszNjs0Mm14G1szODsyOzI0MTsyODszN214G1szODsyOzI0MDsyNzszN214G1szODsyOzI0MDszMzs0MG14G1szODsyOzIzODszMzs0MG14G1szODsyOzE0NzsxMzsxOW0wG1szODsyOzI7MTsxbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MTsxbU0bWzBtChtbMG0gICAgG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjszOzE7MW1NG1szODsyOzk1OzY7MTFtWBtbMzg7MjsxMzU7Mzs5bUsbWzM4OzI7MTM0OzU7OW1LG1szODsyOzEyODs0OzhtSxtbMzg7MjsxMTg7NTs3bVgbWzM4OzI7MTE4OzY7OG1YG1szODsyOzEyODs1OzhtSxtbMzg7MjsxODk7NzsxNm0wG1szODsyOzIxMjs5OzIxbU8bWzM4OzI7MjE4OzExOzIzbU8bWzM4OzI7MjEyOzExOzIybU8bWzM4OzI7MjEzOzEyOzIzbU8bWzM4OzI7MjA1OzExOzIxbU8bWzM4OzI7MTk1Ozg7MThtTxtbMzg7MjsxNzc7NzsxNG0wG1szODsyOzE1ODs2OzEybTAbWzM4OzI7MTQ1OzU7OW1LG1szODsyOzEyNzs1OzhtSxtbMzg7MjsxMTI7NTs2bVgbWzM4OzI7MTAwOzQ7Nm1YG1szODsyOzkwOzQ7NW1YG1szODsyOzg1OzQ7NW1OG1szODsyOzEwMTs1OzZtWBtbMzg7MjsxNDM7Nzs5bUsbWzM4OzI7MTc5Ozg7MTVtMBtbMzg7MjsxOTg7MTQ7MjJtTxtbMzg7MjsxOTY7MTU7MjJtTxtbMzg7MjsxOTg7MTM7MjFtTxtbMzg7MjsyMDY7MTU7MjRtTxtbMzg7MjsyMTA7MTc7MjVtaxtbMzg7MjsyMDU7MTU7MjRtTxtbMzg7MjsxODc7OTsxN20wG1szODsyOzE4Mjs5OzE4bTAbWzM4OzI7NDg7Nzs4bU4bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzBtChtbMG0gICAgG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7NjszOzJtTRtbMzg7MjsxMDc7ODsxM21YG1szODsyOzE0NTs0OzEybUsbWzM4OzI7MTM1OzQ7OW1LG1szODsyOzEyNDs1OzhtWBtbMzg7MjsxMTQ7NTs3bVgbWzM4OzI7MTExOzQ7Nm1YG1szODsyOzEyMzs1OzdtWBtbMzg7MjsxNjM7NjsxMm0wG1szODsyOzIwNjsxMDsyMG1PG1szODsyOzIyMzsxNDsyNm1rG1szODsyOzIyOTsxNjsyOW1rG1szODsyOzIyODsxNDsyOG1rG1szODsyOzIyOTsxNjsyOW1rG1szODsyOzIzMDsxODszMG1rG1szODsyOzIyODsxOTszMW1rG1szODsyOzIyMDsxNTsyNm1rG1szODsyOzIxNjsxNjsyN21rG1szODsyOzIwNzsxMzsyM21PG1szODsyOzE5Njs5OzE5bU8bWzM4OzI7MTgxOzg7MTVtMBtbMzg7MjsxNjk7NzsxM20wG1szODsyOzE2ODs4OzEzbTAbWzM4OzI7MTYzOzc7MTNtMBtbMzg7MjsxNjg7ODsxM20wG1szODsyOzE2NDs3OzEybTAbWzM4OzI7MTUyOzY7MTFtSxtbMzg7MjsxMzk7NTs5bUsbWzM4OzI7MTM1Ozc7OW1LG1szODsyOzEyNTs2OzhtSxtbMzg7MjsxMjQ7Njs4bUsbWzM4OzI7MTI2Ozc7OW1LG1szODsyOzEzNzs3OzEwbUsbWzM4OzI7MTM4Ozc7MTBtSxtbMzg7MjsxMDY7MTE7MTRtWBtbMzg7MjsxOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1swbQobWzBtICAgIBtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzM7MDswbU0bWzM4OzI7Mjk7Mjs0bVcbWzM4OzI7NjA7Mzs3bU4bWzM4OzI7ODU7NDsxMW1OG1szODsyOzEwMTszOzEybVgbWzM4OzI7MTEwOzM7MTJtWBtbMzg7MjsxMjI7NDsxM21YG1szODsyOzEzMjs0OzEzbUsbWzM4OzI7MTE0OzY7MTRtWBtbMzg7MjsxMDszOzJtTRtbMzg7Mjs4OzQ7M21NG1szODsyOzU5OzU7N21OG1szODsyOzExNjs2OzltWBtbMzg7MjsxMzM7NDs5bUsbWzM4OzI7MTMzOzQ7OG1LG1szODsyOzExNTs1OzdtWBtbMzg7MjsxMDU7Njs3bVgbWzM4OzI7MTE3OzY7OG1YG1szODsyOzE2MDs3OzEybTAbWzM4OzI7MTk2Ozg7MThtTxtbMzg7MjsyMTY7MTI7MjRtTxtbMzg7MjsyMjU7MTQ7MjdtaxtbMzg7MjsyMjk7MTg7MjltaxtbMzg7MjsyMzE7MjM7MzRtaxtbMzg7MjsyMzI7MjM7MzNtaxtbMzg7MjsyMzM7MjQ7MzNteBtbMzg7MjsyMzM7MjU7MzRteBtbMzg7MjsyMjk7MjE7MzJtaxtbMzg7MjsyMjg7MjE7MzNtaxtbMzg7MjsyMjM7MTk7MzBtaxtbMzg7MjsyMTc7MTc7MjdtaxtbMzg7MjsyMDk7MTQ7MjNtTxtbMzg7MjsxOTc7MTE7MTltTxtbMzg7MjsxNjY7NzsxM20wG1szODsyOzEzNjs3OzEwbUsbWzM4OzI7MTIwOzY7OG1YG1szODsyOzEwOTs2OzZtWBtbMzg7MjsxMDk7Njs2bVgbWzM4OzI7MTA3OzU7Nm1YG1szODsyOzExMDs1OzZtWBtbMzg7MjsxMDk7Njs3bVgbWzM4OzI7MTAyOzY7N21YG1szODsyOzExNDs2OzhtWBtbMzg7MjsxMzg7MTA7MTNtSxtbMzg7Mjs0Mzs3OzdtThtbMzg7MjswOzA7MW1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzBtChtbMG0gICAgG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjsyOTsyOzRtVxtbMzg7MjsxMDc7NDsxMm1YG1szODsyOzE2Mzs0OzE3bTAbWzM4OzI7MTg1OzM7MTdtMBtbMzg7MjsxODM7MjsxN20wG1szODsyOzE4NTsxOzE4bTAbWzM4OzI7MTkyOzE7MjBtMBtbMzg7MjsxOTI7MjsxOG0wG1szODsyOzE4NjsyOzE2bTAbWzM4OzI7MTc0OzI7MTNtMBtbMzg7Mjs2OTs0OzZtThtbMzg7Mjs2OzI7MW1NG1szODsyOzQ7MTsxbU0bWzM4OzI7MjsyOzFtTRtbMzg7Mjs2OzI7Mm1NG1szODsyOzQ1OzU7Nm1XG1szODsyOzg3Ozc7OG1YG1szODsyOzEyNTs2OzltSxtbMzg7MjsxMjU7NDs3bUsbWzM4OzI7MTMwOzU7OG1LG1szODsyOzEyNTs1OzhtSxtbMzg7MjsxMzY7Njs5bUsbWzM4OzI7MTU1Ozc7MTJtSxtbMzg7MjsxNzA7ODsxNW0wG1szODsyOzE4OTsxMDsxOW1PG1szODsyOzIwOTsxMzsyNG1PG1szODsyOzIxNTsxNDsyNW1rG1szODsyOzIyMDsxODsyOW1rG1szODsyOzIyMDsxODsyOW1rG1szODsyOzIyMTsxOTszMG1rG1szODsyOzIxNDsxNzsyN21rG1szODsyOzIwNjsxNjsyNG1PG1szODsyOzE5NTsxMzsyMW1PG1szODsyOzE2NTs3OzE0bTAbWzM4OzI7MTM0OzY7OW1LG1szODsyOzExMDs2OzdtWBtbMzg7MjsxMDY7Njs2bVgbWzM4OzI7MTAxOzU7Nm1YG1szODsyOzk4OzU7Nm1YG1szODsyOzEwMDs1OzZtWBtbMzg7Mjs5Nzs1OzVtWBtbMzg7Mjs5NDs1OzVtWBtbMzg7Mjs5NTs1OzZtWBtbMzg7MjsxMDM7NTs2bVgbWzM4OzI7MTEwOzY7N21YG1szODsyOzEwNzs2OzdtWBtbMzg7MjsxMDY7MTI7MTVtWBtbMzg7MjsxOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzIxNjszOzE5bU8bWzM4OzI7MjE4OzQ7MjBtTxtbMzg7MjsyMjM7NTsyMm1PG1szODsyOzIyNjs1OzI0bU8bWzM4OzI7MjI4OzExOzI4bWsbWzM4OzI7MjEzOzE0OzI4bWsbWzM4OzI7MTY4OzE1OzI0bTAbWzM4OzI7MTIxOzE1OzE5bUsbWzM4OzI7NzA7MTE7MTNtWBtbMzg7MjsyMDs0OzRtVxtbMzg7MjsxOzE7MW1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzE7MTsxbU0bWzBtChtbMG0gICAgG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzE7MTsxbU0bWzM4OzI7MTsxOzFtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MTswOzFtTRtbMzg7Mjs4MTs4OzEwbVgbWzM4OzI7MTQ4OzU7MTJtSxtbMzg7MjsxNDk7NjsxMW1LG1szODsyOzE1OTs2OzEzbTAbWzM4OzI7MTc3OzY7MTVtMBtbMzg7MjsxOTA7NjsxN20wG1szODsyOzE4Mzs3OzE3bTAbWzM4OzI7MTYyOzc7MTRtMBtbMzg7MjsxMzk7NzsxMW1LG1szODsyOzEzMzs5OzEybUsbWzM4OzI7MTQ0Ozg7MTNtSxtbMzg7MjsxNjk7MTE7MTdtMBtbMzg7MjsxODk7MTk7MjRtTxtbMzg7MjsyMDY7MjU7MzBtaxtbMzg7MjsyMTg7Mjk7MzNtaxtbMzg7MjsyMjc7Mjg7MzVteBtbMzg7MjsyMjg7Mjg7MzRteBtbMzg7MjsyMjQ7MTg7MjdtaxtbMzg7MjsyMTY7NDsxN21PG1szODsyOzIxODsyOzE4bU8bWzM4OzI7MjE2OzI7MThtTxtbMzg7MjsyMTk7MzsxOW1PG1szODsyOzIyMjszOzIwbU8bWzM4OzI7MjI1OzY7MjNtTxtbMzg7MjsyMzE7MTE7MjhtaxtbMzg7MjsyMzQ7MjM7MzVteBtbMzg7MjsyMjY7MjY7MzZtaxtbMzg7MjsxNzU7MjI7MjhtTxtbMzg7MjsxMDQ7MTU7MThtSxtbMzg7MjsxOTszOzNtVxtbMzg7MjsxOzE7MW1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzBtChtbMG0gICAgG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7NDc7NTs2bU4bWzM4OzI7MTM0OzY7MTFtSxtbMzg7MjsxMzI7NTs5bUsbWzM4OzI7MTQwOzY7MTFtSxtbMzg7MjsxNTI7NTsxMm1LG1szODsyOzE1Nzs1OzEybUsbWzM4OzI7MTY1OzY7MTNtMBtbMzg7MjsxNTI7NzsxMm1LG1szODsyOzEyNDs3OzltSxtbMzg7MjsxMDY7Njs4bVgbWzM4OzI7OTY7NTs3bVgbWzM4OzI7ODM7NDs2bU4bWzM4OzI7NzE7NDs1bU4bWzM4OzI7NjM7NDs1bU4bWzM4OzI7NzM7NDs1bU4bWzM4OzI7MTAxOzU7N21YG1szODsyOzEyODs2OzltSxtbMzg7MjsxNjE7MTI7MTZtMBtbMzg7MjsxODU7MjE7MjVtTxtbMzg7MjsyMTQ7Mjc7MzFtaxtbMzg7MjsyMzI7Mjc7MzZteBtbMzg7MjsyMzQ7MjU7MzVteBtbMzg7MjsyMzE7MTM7MjhtaxtbMzg7MjsyMjc7MzsyMm1PG1szODsyOzIyNTszOzIwbU8bWzM4OzI7MjIyOzM7MjBtTxtbMzg7MjsyMjU7NTsyMm1PG1szODsyOzIzMzsxMjsyOW1rG1szODsyOzIzNjsyMTszNW14G1szODsyOzIzODszMzszOW14G1szODsyOzE5MDsyMjsyOG1PG1szODsyOzMxOzQ7NW1XG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MTsxOzFtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzBtChtbMG0gICAgG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDsxOzFtTRtbMzg7MjsxODsyOzNtVxtbMzg7MjsxMjE7NzsxMW1LG1szODsyOzEyOTs0OzhtSxtbMzg7MjsxMjk7NTs4bUsbWzM4OzI7MTI2OzU7OG1LG1szODsyOzEzMDs2OzltSxtbMzg7MjsxNTM7NjsxMW1LG1szODsyOzE4MTs2OzE0bTAbWzM4OzI7MTkxOzg7MTdtMBtbMzg7MjsxNzc7NzsxNW0wG1szODsyOzE2Njs1OzEybTAbWzM4OzI7MTQzOzU7MTBtSxtbMzg7MjsxMjE7Njs5bUsbWzM4OzI7MTEwOzU7N21YG1szODsyOzk5OzU7Nm1YG1szODsyOzg3OzU7Nm1YG1szODsyOzczOzQ7NW1OG1szODsyOzYzOzM7NG1OG1szODsyOzYyOzM7M21OG1szODsyOzcwOzQ7NG1OG1szODsyOzEwMDs2OzdtWBtbMzg7MjsxNDI7OTsxMW1LG1szODsyOzE3NDsxNTsyMG0wG1szODsyOzIwODsyNzszMW1rG1szODsyOzIzNDsyNzszNm14G1szODsyOzIzOTsyOTszOW14G1szODsyOzI0MTszMzs0MW14G1szODsyOzI0MzszNjs0Mm14G1szODsyOzI0MTsyODszN214G1szODsyOzI0MDsyNzszN214G1szODsyOzI0MDszMzs0MG14G1szODsyOzIzODszMzs0MG14G1szODsyOzE0NzsxMzsxOW0wG1szODsyOzI7MTsxbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MTsxbU0bWzBtChtbMG0gICAgG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjszOzE7MW1NG1szODsyOzk1OzY7MTFtWBtbMzg7MjsxMzU7Mzs5bUsbWzM4OzI7MTM0OzU7OW1LG1szODsyOzEyODs0OzhtSxtbMzg7MjsxMTg7NTs3bVgbWzM4OzI7MTE4OzY7OG1YG1szODsyOzEyODs1OzhtSxtbMzg7MjsxODk7NzsxNm0wG1szODsyOzIxMjs5OzIxbU8bWzM4OzI7MjE4OzExOzIzbU8bWzM4OzI7MjEyOzExOzIybU8bWzM4OzI7MjEzOzEyOzIzbU8bWzM4OzI7MjA1OzExOzIxbU8bWzM4OzI7MTk1Ozg7MThtTxtbMzg7MjsxNzc7NzsxNG0wG1szODsyOzE1ODs2OzEybTAbWzM4OzI7MTQ1OzU7OW1LG1szODsyOzEyNzs1OzhtSxtbMzg7MjsxMTI7NTs2bVgbWzM4OzI7MTAwOzQ7Nm1YG1szODsyOzkwOzQ7NW1YG1szODsyOzg1OzQ7NW1OG1szODsyOzEwMTs1OzZtWBtbMzg7MjsxNDM7Nzs5bUsbWzM4OzI7MTc5Ozg7MTVtMBtbMzg7MjsxOTg7MTQ7MjJtTxtbMzg7MjsxOTY7MTU7MjJtTxtbMzg7MjsxOTg7MTM7MjFtTxtbMzg7MjsyMDY7MTU7MjRtTxtbMzg7MjsyMTA7MTc7MjVtaxtbMzg7MjsyMDU7MTU7MjRtTxtbMzg7MjsxODc7OTsxN20wG1szODsyOzE4Mjs5OzE4bTAbWzM4OzI7NDg7Nzs4bU4bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzBtChtbMG0gICAgG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7NjszOzJtTRtbMzg7MjsxMDc7ODsxM21YG1szODsyOzE0NTs0OzEybUsbWzM4OzI7MTM1OzQ7OW1LG1szODsyOzEyNDs1OzhtWBtbMzg7MjsxMTQ7NTs3bVgbWzM4OzI7MTExOzQ7Nm1YG1szODsyOzEyMzs1OzdtWBtbMzg7MjsxNjM7NjsxMm0wG1szODsyOzIwNjsxMDsyMG1PG1szODsyOzIyMzsxNDsyNm1rG1szODsyOzIyOTsxNjsyOW1rG1szODsyOzIyODsxNDsyOG1rG1szODsyOzIyOTsxNjsyOW1rG1szODsyOzIzMDsxODszMG1rG1szODsyOzIyODsxOTszMW1rG1szODsyOzIyMDsxNTsyNm1rG1szODsyOzIxNjsxNjsyN21rG1szODsyOzIwNzsxMzsyM21PG1szODsyOzE5Njs5OzE5bU8bWzM4OzI7MTgxOzg7MTVtMBtbMzg7MjsxNjk7NzsxM20wG1szODsyOzE2ODs4OzEzbTAbWzM4OzI7MTYzOzc7MTNtMBtbMzg7MjsxNjg7ODsxM20wG1szODsyOzE2NDs3OzEybTAbWzM4OzI7MTUyOzY7MTFtSxtbMzg7MjsxMzk7NTs5bUsbWzM4OzI7MTM1Ozc7OW1LG1szODsyOzEyNTs2OzhtSxtbMzg7MjsxMjQ7Njs4bUsbWzM4OzI7MTI2Ozc7OW1LG1szODsyOzEzNzs3OzEwbUsbWzM4OzI7MTM4Ozc7MTBtSxtbMzg7MjsxMDY7MTE7MTRtWBtbMzg7MjsxOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1swbQobWzBtICAgIBtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzM7MDswbU0bWzM4OzI7Mjk7Mjs0bVcbWzM4OzI7NjA7Mzs3bU4bWzM4OzI7ODU7NDsxMW1OG1szODsyOzEwMTszOzEybVgbWzM4OzI7MTEwOzM7MTJtWBtbMzg7MjsxMjI7NDsxM21YG1szODsyOzEzMjs0OzEzbUsbWzM4OzI7MTE0OzY7MTRtWBtbMzg7MjsxMDszOzJtTRtbMzg7Mjs4OzQ7M21NG1szODsyOzU5OzU7N21OG1szODsyOzExNjs2OzltWBtbMzg7MjsxMzM7NDs5bUsbWzM4OzI7MTMzOzQ7OG1LG1szODsyOzExNTs1OzdtWBtbMzg7MjsxMDU7Njs3bVgbWzM4OzI7MTE3OzY7OG1YG1szODsyOzE2MDs3OzEybTAbWzM4OzI7MTk2Ozg7MThtTxtbMzg7MjsyMTY7MTI7MjRtTxtbMzg7MjsyMjU7MTQ7MjdtaxtbMzg7MjsyMjk7MTg7MjltaxtbMzg7MjsyMzE7MjM7MzRtaxtbMzg7MjsyMzI7MjM7MzNtaxtbMzg7MjsyMzM7MjQ7MzNteBtbMzg7MjsyMzM7MjU7MzRteBtbMzg7MjsyMjk7MjE7MzJtaxtbMzg7MjsyMjg7MjE7MzNtaxtbMzg7MjsyMjM7MTk7MzBtaxtbMzg7MjsyMTc7MTc7MjdtaxtbMzg7MjsyMDk7MTQ7MjNtTxtbMzg7MjsxOTc7MTE7MTltTxtbMzg7MjsxNjY7NzsxM20wG1szODsyOzEzNjs3OzEwbUsbWzM4OzI7MTIwOzY7OG1YG1szODsyOzEwOTs2OzZtWBtbMzg7MjsxMDk7Njs2bVgbWzM4OzI7MTA3OzU7Nm1YG1szODsyOzExMDs1OzZtWBtbMzg7MjsxMDk7Njs3bVgbWzM4OzI7MTAyOzY7N21YG1szODsyOzExNDs2OzhtWBtbMzg7MjsxMzg7MTA7MTNtSxtbMzg7Mjs0Mzs3OzdtThtbMzg7MjswOzA7MW1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzBtChtbMG0gICAgG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjswOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMzg7MjsyOTsyOzRtVxtbMzg7MjsxMDc7NDsxMm1YG1szODsyOzE2Mzs0OzE3bTAbWzM4OzI7MTg1OzM7MTdtMBtbMzg7MjsxODM7MjsxN20wG1szODsyOzE4NTsxOzE4bTAbWzM4OzI7MTkyOzE7MjBtMBtbMzg7MjsxOTI7MjsxOG0wG1szODsyOzE4NjsyOzE2bTAbWzM4OzI7MTc0OzI7MTNtMBtbMzg7Mjs2OTs0OzZtThtbMzg7Mjs2OzI7MW1NG1szODsyOzQ7MTsxbU0bWzM4OzI7MjsyOzFtTRtbMzg7Mjs2OzI7Mm1NG1szODsyOzQ1OzU7Nm1XG1szODsyOzg3Ozc7OG1YG1szODsyOzEyNTs2OzltSxtbMzg7MjsxMjU7NDs3bUsbWzM4OzI7MTMwOzU7OG1LG1szODsyOzEyNTs1OzhtSxtbMzg7MjsxMzY7Njs5bUsbWzM4OzI7MTU1Ozc7MTJtSxtbMzg7MjsxNzA7ODsxNW0wG1szODsyOzE4OTsxMDsxOW1PG1szODsyOzIwOTsxMzsyNG1PG1szODsyOzIxNTsxNDsyNW1rG1szODsyOzIyMDsxODsyOW1rG1szODsyOzIyMDsxODsyOW1rG1szODsyOzIyMTsxOTszMG1rG1szODsyOzIxNDsxNzsyN21rG1szODsyOzIwNjsxNjsyNG1PG1szODsyOzE5NTsxMzsyMW1PG1szODsyOzE2NTs3OzE0bTAbWzM4OzI7MTM0OzY7OW1LG1szODsyOzExMDs2OzdtWBtbMzg7MjsxMDY7Njs2bVgbWzM4OzI7MTAxOzU7Nm1YG1szODsyOzk4OzU7Nm1YG1szODsyOzEwMDs1OzZtWBtbMzg7Mjs5Nzs1OzVtWBtbMzg7Mjs5NDs1OzVtWBtbMzg7Mjs5NTs1OzZtWBtbMzg7MjsxMDM7NTs2bVgbWzM4OzI7MTEwOzY7N21YG1szODsyOzEwNzs2OzdtWBtbMzg7MjsxMDY7MTI7MTVtWBtbMzg7MjsxOzA7MG1NG1szODsyOzA7MDswbU0bWzM4OzI7MDswOzBtTRtbMz    curl -sL -o "$FONT_FILE" "$FONT_URL"

    if [ $? -eq 0 ] && [ -s "$FONT_FILE" ]; then
        echo "[√] Font installed"
    else
        echo "[-] Font download failed. Check network."
        exit 1
    fi
fi

# ------------------------------------------------------------
#  Configure terminal prompt with Venv support
# ------------------------------------------------------------
echo "[+] Configuring terminal prompt..."

cat > ~/.bashrc << 'EOF'
# ============================================
#  Dragon Terminal Prompt (Venv-aware)
# ============================================

# Function to set prompt dynamically
set_prompt() {
    # Detect Python virtual environment
    local venv=""
    if [ -n "$VIRTUAL_ENV" ]; then
        # Show venv name in magenta with parentheses
        venv="\[\e[35m\]($(basename "$VIRTUAL_ENV"))\[\e[0m\] "
    fi

    # Color definitions
    local RESET="\[\e[0m\]"
    local BOLD="\[\e[1m\]"
    local GREEN="\[\e[32m\]"
    local RED="\[\e[31m\]"
    local WHITE="\[\e[37m\]"
    local CYAN="\[\e[36m\]"
    local BOLD_BLUE="\[\e[1;34m\]"
    local BOLD_GREEN="\[\e[1;32m\]"

    # Build first line: ╭── [venv] user@host directory [time]
    PS1="${BOLD}${GREEN}╭── ${RESET}${venv}${BOLD}${RED}"'${CUSTOM_USER}'"${RESET}${CYAN}@${RESET}${BOLD_GREEN}\h${RESET} ${BOLD_BLUE}\w${RESET} ${WHITE}[${RESET}${BOLD}${RED}\t${RESET}${WHITE}]${RESET}\n"
    # Build second line: ╰───▶
    PS1+="${BOLD}${GREEN}╰───${RESET}${BOLD}${RED}▶${RESET}${BOLD_GREEN} "
}

# Use CUSTOM_USER variable (set from script)
CUSTOM_USER="__USERNAME__"

# Tell bash to run this function before every prompt
PROMPT_COMMAND=set_prompt
EOF

# Replace placeholder with actual username
sed -i "s/__USERNAME__/${CUSTOM_USER_INPUT}/" ~/.bashrc

echo "[√] Prompt configured"

# ------------------------------------------------------------
#  Reload terminal
# ------------------------------------------------------------
echo "[/] Reloading terminal..."
termux-reload-settings
source ~/.bashrc 2>/dev/null

echo "[√] Setup complete"
echo "  • Restart Termux to see full effect."
echo "=============================="    curl -sL -o "$FONT_FILE" "$FONT_URL"

    if [ $? -eq 0 ] && [ -s "$FONT_FILE" ]; then
        echo "[√] Font installed"
    else
        echo "[-] Font download failed. Check network."
        exit 1
    fi
fi

# ------------------------------------------------------------
#  Configure terminal prompt with Venv support
# ------------------------------------------------------------
echo "[+] Configuring terminal prompt..."

cat > ~/.bashrc << 'EOF'
# ============================================
#  Dragon Terminal Prompt (Venv-aware)
# ============================================

# Function to set prompt dynamically
set_prompt() {
    # Detect Python virtual environment
    local venv=""
    if [ -n "$VIRTUAL_ENV" ]; then
        # Show venv name in magenta with parentheses
        venv="\[\e[35m\]($(basename "$VIRTUAL_ENV"))\[\e[0m\] "
    fi

    # Color definitions
    local RESET="\[\e[0m\]"
    local BOLD="\[\e[1m\]"
    local GREEN="\[\e[32m\]"
    local RED="\[\e[31m\]"
    local WHITE="\[\e[37m\]"
    local CYAN="\[\e[36m\]"
    local BOLD_BLUE="\[\e[1;34m\]"
    local BOLD_GREEN="\[\e[1;32m\]"

    # Build first line: ╭── [venv] user@host directory [time]
    PS1="${BOLD}${GREEN}╭── ${RESET}${venv}${BOLD}${RED}"'${CUSTOM_USER}'"${RESET}${CYAN}@${RESET}${BOLD_GREEN}\h${RESET} ${BOLD_BLUE}\w${RESET} ${WHITE}[${RESET}${BOLD}${RED}\t${RESET}${WHITE}]${RESET}\n"
    # Build second line: ╰───▶
    PS1+="${BOLD}${GREEN}╰───${RESET}${BOLD}${RED}▶${RESET}${BOLD_GREEN} "
}

# Use CUSTOM_USER variable (set from script)
CUSTOM_USER="__USERNAME__"

# Tell bash to run this function before every prompt
PROMPT_COMMAND=set_prompt
EOF

# Replace placeholder with actual username
sed -i "s/__USERNAME__/${CUSTOM_USER_INPUT}/" ~/.bashrc

echo "[√] Prompt configured"

# ------------------------------------------------------------
#  Reload terminal
# ------------------------------------------------------------
echo "[/] Reloading terminal..."
termux-reload-settings
source ~/.bashrc 2>/dev/null

echo "[√] Setup complete"
echo "  • Restart Termux to see full effect."
echo "=============================="    mkdir -p "$HOME/.termux"
    curl -sL -o "$FONT_FILE" "$FONT_URL"

    if [ $? -eq 0 ] && [ -s "$FONT_FILE" ]; then
        echo "[√] Font installed"
    else
        echo "[-] Font download failed. Check network."
        exit 1
    fi
fi

# ------------------------------------------------------------
#  Download Banner from GitHub
# ------------------------------------------------------------
BANNER_FILE="$HOME/banner.txt"
BANNER_URL="https://raw.githubusercontent.com/dr-4ndro/v-terminal/main/banner.txt"

if [ ! -f "$BANNER_FILE" ]; then
    echo "[+] Downloading banner..."
    curl -sL -o "$BANNER_FILE" "$BANNER_URL"
    if [ $? -eq 0 ] && [ -s "$BANNER_FILE" ]; then
        echo "[√] Banner downloaded"
    else
        echo "[!] Banner download failed, continuing without it"
    fi
else
    echo "[i] Banner already exists. Skipping download."
fi

# ------------------------------------------------------------
#  Configure terminal prompt with Venv support + Clear
# ------------------------------------------------------------
echo "[+] Configuring terminal prompt..."

cat > ~/.bashrc << 'EOF'
# ============================================
#  Dragon Terminal Prompt (Venv-aware)
#  Banner + Clear Screen at startup
# ============================================

# Clear screen first
clear

# Display banner if present
if [ -f ~/banner.txt ]; then
    cat ~/banner.txt
fi

# Function to set prompt dynamically
set_prompt() {
    # Detect Python virtual environment
    local venv=""
    if [ -n "$VIRTUAL_ENV" ]; then
        venv="\[\e[35m\]($(basename "$VIRTUAL_ENV"))\[\e[0m\] "
    fi

    # Color definitions
    local RESET="\[\e[0m\]"
    local BOLD="\[\e[1m\]"
    local GREEN="\[\e[32m\]"
    local RED="\[\e[31m\]"
    local WHITE="\[\e[37m\]"
    local CYAN="\[\e[36m\]"
    local BOLD_BLUE="\[\e[1;34m\]"
    local BOLD_GREEN="\[\e[1;32m\]"

    # Use CUSTOM_USER variable
    CUSTOM_USER="__USERNAME__"

    # Build first line: ╭── [venv] user@host directory [time]
    PS1="${BOLD}${GREEN}╭── ${RESET}${venv}${BOLD}${RED}${CUSTOM_USER}${RESET}${CYAN}@${RESET}${BOLD_GREEN}\h${RESET} ${BOLD_BLUE}\w${RESET} ${WHITE}[${RESET}${BOLD}${RED}\t${RESET}${WHITE}]${RESET}\n"
    # Build second line: ╰───▶
    PS1+="${BOLD}${GREEN}╰───${RESET}${BOLD}${RED}▶${RESET}${BOLD_GREEN} "
}

# Tell bash to run this function before every prompt
PROMPT_COMMAND=set_prompt
EOF

# Replace placeholder with actual username
sed -i "s/__USERNAME__/${CUSTOM_USER_INPUT}/" ~/.bashrc

echo "[√] Prompt configured"

# ------------------------------------------------------------
#  Reload terminal
# ------------------------------------------------------------
echo "[/] Reloading terminal..."
termux-reload-settings
source ~/.bashrc 2>/dev/null

echo "[√] Setup complete"
echo "  • Restart Termux to see full effect."
echo "=============================="    curl -sL -o "$FONT_FILE" "$FONT_URL"
    if [ -f "$FONT_FILE" ] && [ -s "$FONT_FILE" ]; then
        echo -e "  ${BOLD}${GREEN}[√]${RESET} Font installed."
    else
        echo -e "  ${BOLD}${RED}[-]${RESET} Font download failed."
        exit 1
    fi
fi

# --- Banner ---
BANNER_FILE="$HOME/banner.txt"
BANNER_URL="https://raw.githubusercontent.com/dr-4ndro/v-terminal/main/banner.txt"

echo -e "${BOLD}${GREEN}[+]${RESET} Checking Banner..."
if [ ! -f "$BANNER_FILE" ]; then
    echo -e "  ${BOLD}${GREEN}[+]${RESET} Downloading banner..."
    curl -sL -o "$BANNER_FILE" "$BANNER_URL"
    if [ -f "$BANNER_FILE" ] && [ -s "$BANNER_FILE" ]; then
        echo -e "  ${BOLD}${GREEN}[√]${RESET} Banner downloaded."
    else
        echo -e "  ${BOLD}${YELLOW}[!]${RESET} Banner download failed. Skipping."
    fi
else
    echo -e "  ${BOLD}${GREEN}[i]${RESET} Banner exists. Skipping."
fi

# --- OPSEC Pre‑installation ---
echo -e "${BOLD}${GREEN}[+]${RESET} Checking OPSEC packages..."
REQUIRED_PKGS="tor proxychains-ng privoxy macchanger curl dnsutils jq iproute2 iptables"
MISSING_PKGS=""
for pkg in $REQUIRED_PKGS; do
    if ! command -v "$pkg" &>/dev/null; then
        MISSING_PKGS="$MISSING_PKGS $pkg"
    fi
done
if [ -n "$MISSING_PKGS" ]; then
    echo -e "  ${BOLD}${YELLOW}[!]${RESET} Missing packages:${MISSING_PKGS}"
    echo -e "  ${BOLD}${GREEN}[+]${RESET} Installing now..."
    pkg install -y root-repo $MISSING_PKGS
    echo -e "  ${BOLD}${GREEN}[√]${RESET} OPSEC packages installed."
else
    echo -e "  ${BOLD}${GREEN}[i]${RESET} All OPSEC packages already installed."
fi

# --- Anon Script ---
ANON_FILE="$HOME/anon.sh"
ANON_URL="https://raw.githubusercontent.com/dr-4ndro/v-terminal/main/anon.sh"

echo -e "${BOLD}${GREEN}[+]${RESET} Checking anon script..."
if [ ! -f "$ANON_FILE" ]; then
    echo -e "  ${BOLD}${GREEN}[+]${RESET} Downloading anon.sh..."
    curl -sL -o "$ANON_FILE" "$ANON_URL"
    if [ -f "$ANON_FILE" ] && [ -s "$ANON_FILE" ]; then
        chmod +x "$ANON_FILE"
        echo -e "  ${BOLD}${GREEN}[√]${RESET} anon.sh downloaded."
    else
        echo -e "  ${BOLD}${YELLOW}[!]${RESET} anon.sh download failed."
    fi
else
    echo -e "  ${BOLD}${GREEN}[i]${RESET} anon.sh exists. Skipping."
fi

# --- Write .bashrc (no heredoc, no command leaking) ---
echo -e "${BOLD}${GREEN}[+]${RESET} Configuring Dragon Terminal..."

> ~/.bashrc

echo '# ============================================' >> ~/.bashrc
echo '#  Dragon Terminal (Venv + Anon)             ' >> ~/.bashrc
echo '# ============================================' >> ~/.bashrc
echo '' >> ~/.bashrc
echo 'clear' >> ~/.bashrc
echo 'if [ -f ~/banner.txt ]; then' >> ~/.bashrc
echo '  cat ~/banner.txt' >> ~/.bashrc
echo 'fi' >> ~/.bashrc
echo '' >> ~/.bashrc
echo 'if [ -f ~/anon.sh ]; then' >> ~/.bashrc
echo '  anon() {' >> ~/.bashrc
echo '    bash ~/anon.sh "$@"' >> ~/.bashrc
echo '  }' >> ~/.bashrc
echo 'fi' >> ~/.bashrc
echo '' >> ~/.bashrc
echo 'set_prompt() {' >> ~/.bashrc
echo '  local venv=""' >> ~/.bashrc
echo '  if [ -n "$VIRTUAL_ENV" ]; then' >> ~/.bashrc
echo '    local venv_name=$(basename "$VIRTUAL_ENV")' >> ~/.bashrc
echo '    venv="\[\e[35m\](${venv_name})\[\e[0m\] "' >> ~/.bashrc
echo '  fi' >> ~/.bashrc
echo '' >> ~/.bashrc
echo '  local RESET="\[\e[0m\]"' >> ~/.bashrc
echo '  local BOLD="\[\e[1m\]"' >> ~/.bashrc
echo '  local GREEN="\[\e[32m\]"' >> ~/.bashrc
echo '  local RED="\[\e[31m\]"' >> ~/.bashrc
echo '  local WHITE="\[\e[37m\]"' >> ~/.bashrc
echo '  local CYAN="\[\e[36m\]"' >> ~/.bashrc
echo '  local BOLD_BLUE="\[\e[1;34m\]"' >> ~/.bashrc
echo '  local BOLD_GREEN="\[\e[1;32m\]"' >> ~/.bashrc
echo '' >> ~/.bashrc
echo '  CUSTOM_USER="__USERNAME__"' >> ~/.bashrc
echo '' >> ~/.bashrc
echo '  PS1="${BOLD}${GREEN}╭── ${RESET}${venv}${BOLD}${RED}${CUSTOM_USER}${RESET}${CYAN}@${RESET}${BOLD_GREEN}\h${RESET} ${BOLD_BLUE}\w${RESET} ${WHITE}[${RESET}${BOLD}${RED}\t${RESET}${WHITE}]${RESET}\n"' >> ~/.bashrc
echo '  PS1+="${BOLD}${GREEN}╰───${RESET}${BOLD}${RED}▶${RESET}${BOLD_GREEN} "' >> ~/.bashrc
echo '}' >> ~/.bashrc
echo '' >> ~/.bashrc
echo 'PROMPT_COMMAND=set_prompt' >> ~/.bashrc

# Replace username placeholder
sed -i "s/__USERNAME__/${CUSTOM_USER_INPUT}/" ~/.bashrc

echo -e "  ${BOLD}${GREEN}[√]${RESET} Dragon Prompt ready."

# --- Reload ---
echo -e "${BOLD}${GREEN}[/]${RESET} Reloading terminal..."
termux-reload-settings
source ~/.bashrc 2>/dev/null

echo ""
echo -e "${BOLD}${GREEN}[√]${RESET} Setup complete"
echo -e "  • Restart Termux to see the full effect."
echo -e "  • To start anonymous mode: ${BOLD}${RED}anon start${RESET}"
echo -e "${BOLD}${CYAN}==============================${RESET}"    curl -sL -o "$FONT_FILE" "$FONT_URL"
    if [ -f "$FONT_FILE" ] && [ -s "$FONT_FILE" ]; then
        echo -e "  ${BOLD}${GREEN}[√]${RESET} Font installed."
    else
        echo -e "  ${BOLD}${RED}[-]${RESET} Font download failed."
        exit 1
    fi
fi

# --- Banner ---
BANNER_FILE="$HOME/banner.txt"
BANNER_URL="https://raw.githubusercontent.com/dr-4ndro/v-terminal/main/banner.txt"

echo -e "${BOLD}${GREEN}[+]${RESET} Checking Banner..."
if [ ! -f "$BANNER_FILE" ]; then
    echo -e "  ${BOLD}${GREEN}[+]${RESET} Downloading banner..."
    curl -sL -o "$BANNER_FILE" "$BANNER_URL"
    if [ -f "$BANNER_FILE" ] && [ -s "$BANNER_FILE" ]; then
        echo -e "  ${BOLD}${GREEN}[√]${RESET} Banner downloaded."
    else
        echo -e "  ${BOLD}${YELLOW}[!]${RESET} Banner download failed. Skipping."
    fi
else
    echo -e "  ${BOLD}${GREEN}[i]${RESET} Banner exists. Skipping."
fi

# --- OPSEC Pre‑installation ---
echo -e "${BOLD}${GREEN}[+]${RESET} Checking OPSEC packages..."
REQUIRED_PKGS="tor proxychains-ng privoxy macchanger curl dnsutils jq iproute2 iptables"
MISSING_PKGS=""
for pkg in $REQUIRED_PKGS; do
    if ! command -v "$pkg" &>/dev/null; then
        MISSING_PKGS="$MISSING_PKGS $pkg"
    fi
done
if [ -n "$MISSING_PKGS" ]; then
    echo -e "  ${BOLD}${YELLOW}[!]${RESET} Missing packages:${MISSING_PKGS}"
    echo -e "  ${BOLD}${GREEN}[+]${RESET} Installing now..."
    pkg install -y root-repo $MISSING_PKGS
    echo -e "  ${BOLD}${GREEN}[√]${RESET} OPSEC packages installed."
else
    echo -e "  ${BOLD}${GREEN}[i]${RESET} All OPSEC packages already installed."
fi

# --- Anon Script ---
ANON_FILE="$HOME/anon.sh"
ANON_URL="https://raw.githubusercontent.com/dr-4ndro/v-terminal/main/anon.sh"

echo -e "${BOLD}${GREEN}[+]${RESET} Checking anon script..."
if [ ! -f "$ANON_FILE" ]; then
    echo -e "  ${BOLD}${GREEN}[+]${RESET} Downloading anon.sh..."
    curl -sL -o "$ANON_FILE" "$ANON_URL"
    if [ -f "$ANON_FILE" ] && [ -s "$ANON_FILE" ]; then
        chmod +x "$ANON_FILE"
        echo -e "  ${BOLD}${GREEN}[√]${RESET} anon.sh downloaded."
    else
        echo -e "  ${BOLD}${YELLOW}[!]${RESET} anon.sh download failed."
    fi
else
    echo -e "  ${BOLD}${GREEN}[i]${RESET} anon.sh exists. Skipping."
fi

# --- Write .bashrc without heredoc ---
echo -e "${BOLD}${GREEN}[+]${RESET} Configuring Dragon Terminal..."

> ~/.bashrc

echo '# ============================================' >> ~/.bashrc
echo '#  Dragon Terminal (Venv + Anon)             ' >> ~/.bashrc
echo '# ============================================' >> ~/.bashrc
echo '' >> ~/.bashrc

# Clear screen and show banner
echo 'clear' >> ~/.bashrc
echo 'if [ -f ~/banner.txt ]; then' >> ~/.bashrc
echo '    cat ~/banner.txt' >> ~/.bashrc
echo 'fi' >> ~/.bashrc
echo '' >> ~/.bashrc

# Anonymity function
echo 'if [ -f ~/anon.sh ]; then' >> ~/.bashrc
echo '    anon() {' >> ~/.bashrc
echo '        bash ~/anon.sh "$@"' >> ~/.bashrc
echo '    }' >> ~/.bashrc
echo 'fi' >> ~/.bashrc
echo '' >> ~/.bashrc

# Prompt function
echo 'set_prompt() {' >> ~/.bashrc
echo '    local venv=""' >> ~/.bashrc
echo '    if [ -n "$VIRTUAL_ENV" ]; then' >> ~/.bashrc
echo '        local venv_name=$(basename "$VIRTUAL_ENV")' >> ~/.bashrc
echo '        venv="\[\e[35m\](${venv_name})\[\e[0m\] "' >> ~/.bashrc
echo '    fi' >> ~/.bashrc
echo '' >> ~/.bashrc
echo '    local RESET="\[\e[0m\]"' >> ~/.bashrc
echo '    local BOLD="\[\e[1m\]"' >> ~/.bashrc
echo '    local GREEN="\[\e[32m\]"' >> ~/.bashrc
echo '    local RED="\[\e[31m\]"' >> ~/.bashrc
echo '    local WHITE="\[\e[37m\]"' >> ~/.bashrc
echo '    local CYAN="\[\e[36m\]"' >> ~/.bashrc
echo '    local BOLD_BLUE="\[\e[1;34m\]"' >> ~/.bashrc
echo '    local BOLD_GREEN="\[\e[1;32m\]"' >> ~/.bashrc
echo '' >> ~/.bashrc
echo '    CUSTOM_USER="__USERNAME__"' >> ~/.bashrc
echo '' >> ~/.bashrc
echo '    PS1="${BOLD}${GREEN}╭── ${RESET}${venv}${BOLD}${RED}${CUSTOM_USER}${RESET}${CYAN}@${RESET}${BOLD_GREEN}\h${RESET} ${BOLD_BLUE}\w${RESET} ${WHITE}[${RESET}${BOLD}${RED}\t${RESET}${WHITE}]${RESET}\n"' >> ~/.bashrc
echo '    PS1+="${BOLD}${GREEN}╰───${RESET}${BOLD}${RED}▶${RESET}${BOLD_GREEN} "' >> ~/.bashrc
echo '}' >> ~/.bashrc
echo '' >> ~/.bashrc
echo 'PROMPT_COMMAND=set_prompt' >> ~/.bashrc

# Replace username placeholder
sed -i "s/__USERNAME__/${CUSTOM_USER_INPUT}/" ~/.bashrc

echo -e "  ${BOLD}${GREEN}[√]${RESET} Dragon Prompt ready."

# --- Reload ---
echo -e "${BOLD}${GREEN}[/]${RESET} Reloading terminal..."
termux-reload-settings
source ~/.bashrc 2>/dev/null

echo ""
echo -e "${BOLD}${GREEN}[√]${RESET} Setup complete"
echo -e "  • Restart Termux to see the full effect."
echo -e "  • To start anonymous mode: ${BOLD}${RED}anon start${RESET}"
echo -e "${BOLD}${CYAN}==============================${RESET}"    curl -sL -o "$FONT_FILE" "$FONT_URL"
    if [ -f "$FONT_FILE" ] && [ -s "$FONT_FILE" ]; then
        echo -e "  ${BOLD}${GREEN}[√]${RESET} Font installed."
    else
        echo -e "  ${BOLD}${RED}[-]${RESET} Font download failed."
        exit 1
    fi
fi

# --- Banner ---
BANNER_FILE="$HOME/banner.txt"
BANNER_URL="https://raw.githubusercontent.com/dr-4ndro/v-terminal/main/banner.txt"

echo -e "${BOLD}${GREEN}[+]${RESET} Checking Banner..."
if [ ! -f "$BANNER_FILE" ]; then
    echo -e "  ${BOLD}${GREEN}[+]${RESET} Downloading banner..."
    curl -sL -o "$BANNER_FILE" "$BANNER_URL"
    if [ -f "$BANNER_FILE" ] && [ -s "$BANNER_FILE" ]; then
        echo -e "  ${BOLD}${GREEN}[√]${RESET} Banner downloaded."
    else
        echo -e "  ${BOLD}${YELLOW}[!]${RESET} Banner download failed. Skipping."
    fi
else
    echo -e "  ${BOLD}${GREEN}[i]${RESET} Banner exists. Skipping."
fi

# --- OPSEC Pre‑installation ---
echo -e "${BOLD}${GREEN}[+]${RESET} Checking OPSEC packages..."
REQUIRED_PKGS="tor proxychains-ng privoxy macchanger curl dnsutils jq iproute2 iptables"
MISSING_PKGS=""
for pkg in $REQUIRED_PKGS; do
    if ! command -v "$pkg" &>/dev/null; then
        MISSING_PKGS="$MISSING_PKGS $pkg"
    fi
done
if [ -n "$MISSING_PKGS" ]; then
    echo -e "  ${BOLD}${YELLOW}[!]${RESET} Missing packages:${MISSING_PKGS}"
    echo -e "  ${BOLD}${GREEN}[+]${RESET} Installing now..."
    pkg install -y root-repo $MISSING_PKGS
    echo -e "  ${BOLD}${GREEN}[√]${RESET} OPSEC packages installed."
else
    echo -e "  ${BOLD}${GREEN}[i]${RESET} All OPSEC packages already installed."
fi

# --- Anon Script ---
ANON_FILE="$HOME/anon.sh"
ANON_URL="https://raw.githubusercontent.com/dr-4ndro/v-terminal/main/anon.sh"

echo -e "${BOLD}${GREEN}[+]${RESET} Checking anon script..."
if [ ! -f "$ANON_FILE" ]; then
    echo -e "  ${BOLD}${GREEN}[+]${RESET} Downloading anon.sh..."
    curl -sL -o "$ANON_FILE" "$ANON_URL"
    if [ -f "$ANON_FILE" ] && [ -s "$ANON_FILE" ]; then
        chmod +x "$ANON_FILE"
        echo -e "  ${BOLD}${GREEN}[√]${RESET} anon.sh downloaded."
    else
        echo -e "  ${BOLD}${YELLOW}[!]${RESET} anon.sh download failed."
    fi
else
    echo -e "  ${BOLD}${GREEN}[i]${RESET} anon.sh exists. Skipping."
fi

# --- Write .bashrc without heredoc (no more EOF issues) ---
echo -e "${BOLD}${GREEN}[+]${RESET} Configuring Dragon Terminal..."

# Start with a clean file
> ~/.bashrc

echo '# ============================================' >> ~/.bashrc
echo '#  Dragon Terminal (Venv + Anon)' >> ~/.bashrc
echo '# ============================================' >> ~/.bashrc
echo '' >> ~/.bashrc
echo 'clear' >> ~/.bashrc
echo 'if [ -f ~/banner.txt ]; then' >> ~/.bashrc
echo '    cat ~/banner.txt' >> ~/.bashrc
echo 'fi' >> ~/.bashrc
echo '' >> ~/.bashrc
echo 'if [ -f ~/anon.sh ]; then' >> ~/.bashrc
echo '    anon() {' >> ~/.bashrc
echo '        bash ~/anon.sh "$@"' >> ~/.bashrc
echo '    }' >> ~/.bashrc
echo 'fi' >> ~/.bashrc
echo '' >> ~/.bashrc
echo 'set_prompt() {' >> ~/.bashrc
echo '    local venv=""' >> ~/.bashrc
echo '    if [ -n "$VIRTUAL_ENV" ]; then' >> ~/.bashrc
echo '        local venv_name=$(basename "$VIRTUAL_ENV")' >> ~/.bashrc
echo '        venv="\[\e[35m\](${venv_name})\[\e[0m\] "' >> ~/.bashrc
echo '    fi' >> ~/.bashrc
echo '' >> ~/.bashrc
echo '    local RESET="\[\e[0m\]"' >> ~/.bashrc
echo '    local BOLD="\[\e[1m\]"' >> ~/.bashrc
echo '    local GREEN="\[\e[32m\]"' >> ~/.bashrc
echo '    local RED="\[\e[31m\]"' >> ~/.bashrc
echo '    local WHITE="\[\e[37m\]"' >> ~/.bashrc
echo '    local CYAN="\[\e[36m\]"' >> ~/.bashrc
echo '    local BOLD_BLUE="\[\e[1;34m\]"' >> ~/.bashrc
echo '    local BOLD_GREEN="\[\e[1;32m\]"' >> ~/.bashrc
echo '' >> ~/.bashrc
echo '    CUSTOM_USER="__USERNAME__"' >> ~/.bashrc
echo '' >> ~/.bashrc
echo '    PS1="${BOLD}${GREEN}╭── ${RESET}${venv}${BOLD}${RED}${CUSTOM_USER}${RESET}${CYAN}@${RESET}${BOLD_GREEN}\h${RESET} ${BOLD_BLUE}\w${RESET} ${WHITE}[${RESET}${BOLD}${RED}\t${RESET}${WHITE}]${RESET}\n"' >> ~/.bashrc
echo '    PS1+="${BOLD}${GREEN}╰───${RESET}${BOLD}${RED}▶${RESET}${BOLD_GREEN} "' >> ~/.bashrc
echo '}' >> ~/.bashrc
echo '' >> ~/.bashrc
echo 'PROMPT_COMMAND=set_prompt' >> ~/.bashrc

# Replace username placeholder
sed -i "s/__USERNAME__/${CUSTOM_USER_INPUT}/" ~/.bashrc

echo -e "  ${BOLD}${GREEN}[√]${RESET} Dragon Prompt ready."

# --- Reload ---
echo -e "${BOLD}${GREEN}[/]${RESET} Reloading terminal..."
termux-reload-settings
source ~/.bashrc 2>/dev/null

echo ""
echo -e "${BOLD}${GREEN}[√]${RESET} Setup complete"
echo -e "  • Restart Termux to see the full effect."
echo -e "  • To start anonymous mode: ${BOLD}${RED}anon start${RESET}"
echo -e "${BOLD}${CYAN}==============================${RESET}"    curl -sL -o "$FONT_FILE" "$FONT_URL"
    if [ -f "$FONT_FILE" ] && [ -s "$FONT_FILE" ]; then
        echo -e "  ${BOLD}${GREEN}[√]${RESET} Font installed."
    else
        echo -e "  ${BOLD}${RED}[-]${RESET} Font download failed."
        exit 1
    fi
fi

# --- Banner ---
BANNER_FILE="$HOME/banner.txt"
BANNER_URL="https://raw.githubusercontent.com/dr-4ndro/v-terminal/main/banner.txt"

echo -e "${BOLD}${GREEN}[+]${RESET} Checking Banner..."
if [ ! -f "$BANNER_FILE" ]; then
    echo -e "  ${BOLD}${GREEN}[+]${RESET} Downloading banner..."
    curl -sL -o "$BANNER_FILE" "$BANNER_URL"
    if [ -f "$BANNER_FILE" ] && [ -s "$BANNER_FILE" ]; then
        echo -e "  ${BOLD}${GREEN}[√]${RESET} Banner downloaded."
    else
        echo -e "  ${BOLD}${YELLOW}[!]${RESET} Banner download failed. Skipping."
    fi
else
    echo -e "  ${BOLD}${GREEN}[i]${RESET} Banner exists. Skipping."
fi

# --- OPSEC Pre‑installation (root-repo, iproute2, etc.) ---
echo -e "${BOLD}${GREEN}[+]${RESET} Checking OPSEC packages..."
REQUIRED_PKGS="tor proxychains-ng privoxy macchanger curl dnsutils jq iproute2 iptables"
MISSING_PKGS=""
for pkg in $REQUIRED_PKGS; do
    if ! command -v "$pkg" &>/dev/null; then
        MISSING_PKGS="$MISSING_PKGS $pkg"
    fi
done
if [ -n "$MISSING_PKGS" ]; then
    echo -e "  ${BOLD}${YELLOW}[!]${RESET} Missing packages:${MISSING_PKGS}"
    echo -e "  ${BOLD}${GREEN}[+]${RESET} Installing now..."
    pkg install -y root-repo $MISSING_PKGS
    echo -e "  ${BOLD}${GREEN}[√]${RESET} OPSEC packages installed."
else
    echo -e "  ${BOLD}${GREEN}[i]${RESET} All OPSEC packages already installed."
fi

# --- Anon Script ---
ANON_FILE="$HOME/anon.sh"
ANON_URL="https://raw.githubusercontent.com/dr-4ndro/v-terminal/main/anon.sh"

echo -e "${BOLD}${GREEN}[+]${RESET} Checking anon script..."
if [ ! -f "$ANON_FILE" ]; then
    echo -e "  ${BOLD}${GREEN}[+]${RESET} Downloading anon.sh..."
    curl -sL -o "$ANON_FILE" "$ANON_URL"
    if [ -f "$ANON_FILE" ] && [ -s "$ANON_FILE" ]; then
        chmod +x "$ANON_FILE"
        echo -e "  ${BOLD}${GREEN}[√]${RESET} anon.sh downloaded."
    else
        echo -e "  ${BOLD}${YELLOW}[!]${RESET} anon.sh download failed."
    fi
else
    echo -e "  ${BOLD}${GREEN}[i]${RESET} anon.sh exists. Skipping."
fi

# --- Write .bashrc (heredoc ends on line with ZERO spaces) ---
echo -e "${BOLD}${GREEN}[+]${RESET} Configuring Dragon Terminal..."
cat > ~/.bashrc << 'EOF'
# ============================================
#  Dragon Terminal (Venv + Anon)
# ============================================

# Clear & Banner
clear
if [ -f ~/banner.txt ]; then
    cat ~/banner.txt
fi

# OPSEC Function
if [ -f ~/anon.sh ]; then
    anon() {
        bash ~/anon.sh "$@"
    }
fi

# Venv-aware Prompt
set_prompt() {
    local venv=""
    if [ -n "$VIRTUAL_ENV" ]; then
        local venv_name=$(basename "$VIRTUAL_ENV")
        venv="\[\e[35m\](${venv_name})\[\e[0m\] "
    fi

    local RESET="\[\e[0m\]"
    local BOLD="\[\e[1m\]"
    local GREEN="\[\e[32m\]"
    local RED="\[\e[31m\]"
    local WHITE="\[\e[37m\]"
    local CYAN="\[\e[36m\]"
    local BOLD_BLUE="\[\e[1;34m\]"
    local BOLD_GREEN="\[\e[1;32m\]"

    CUSTOM_USER="__USERNAME__"

    PS1="${BOLD}${GREEN}╭── ${RESET}${venv}${BOLD}${RED}${CUSTOM_USER}${RESET}${CYAN}@${RESET}${BOLD_GREEN}\h${RESET} ${BOLD_BLUE}\w${RESET} ${WHITE}[${RESET}${BOLD}${RED}\t${RESET}${WHITE}]${RESET}\n"
    PS1+="${BOLD}${GREEN}╰───${RESET}${BOLD}${RED}▶${RESET}${BOLD_GREEN} "
}

PROMPT_COMMAND=set_prompt
EOF
# NOTE: The EOF above MUST be at the very beginning of the line (no spaces/tabs).

# Replace username placeholder
sed -i "s/__USERNAME__/${CUSTOM_USER_INPUT}/" ~/.bashrc
echo -e "  ${BOLD}${GREEN}[√]${RESET} Dragon Prompt ready."

# --- Reload ---
echo -e "${BOLD}${GREEN}[/]${RESET} Reloading terminal..."
termux-reload-settings
source ~/.bashrc 2>/dev/null

echo ""
echo -e "${BOLD}${GREEN}[√]${RESET} Setup complete"
echo -e "  • Restart Termux to see the full effect."
echo -e "  • To start anonymous mode: ${BOLD}${RED}anon start${RESET}"
echo -e "${BOLD}${CYAN}==============================${RESET}"${GREEN}[√]${RESET} Setup complete"
echo -e "  ${BOLD}${GREEN}•${RESET} Restart Termux to see full effect."
echo -e "  ${BOLD}${GREEN}•${RESET} To start anonymous mode: ${BOLD}${RED}anon start${RESET}"
echo -e "${BOLD}${CYAN}==============================${RESET}"    mkdir -p "$HOME/.termux"
    curl -sL -o "$FONT_FILE" "$FONT_URL"

    if [ $? -eq 0 ] && [ -s "$FONT_FILE" ]; then
        echo "[√] Font installed"
    else
        echo "[-] Font download failed. Check network."
        exit 1
    fi
fi

# ------------------------------------------------------------
#  Download Banner from GitHub
# ------------------------------------------------------------
BANNER_FILE="$HOME/banner.txt"
BANNER_URL="https://raw.githubusercontent.com/dr-4ndro/v-terminal/main/banner.txt"

if [ ! -f "$BANNER_FILE" ]; then
    echo "[+] Downloading banner..."
    curl -sL -o "$BANNER_FILE" "$BANNER_URL"
    if [ $? -eq 0 ] && [ -s "$BANNER_FILE" ]; then
        echo "[√] Banner downloaded"
    else
        echo "[!] Banner download failed, continuing without it"
    fi
else
    echo "[i] Banner already exists. Skipping download."
fi

# ------------------------------------------------------------
#  Configure terminal prompt with Venv support + Clear
# ------------------------------------------------------------
echo "[+] Configuring terminal prompt..."

cat > ~/.bashrc << 'EOF'
# ============================================
#  Dragon Terminal Prompt (Venv-aware)
#  Banner + Clear Screen at startup
# ============================================

# Clear screen first
clear

# Display banner if present
if [ -f ~/banner.txt ]; then
    cat ~/banner.txt
fi

# Function to set prompt dynamically
set_prompt() {
    # Detect Python virtual environment
    local venv=""
    if [ -n "$VIRTUAL_ENV" ]; then
        venv="\[\e[35m\]($(basename "$VIRTUAL_ENV"))\[\e[0m\] "
    fi

    # Color definitions
    local RESET="\[\e[0m\]"
    local BOLD="\[\e[1m\]"
    local GREEN="\[\e[32m\]"
    local RED="\[\e[31m\]"
    local WHITE="\[\e[37m\]"
    local CYAN="\[\e[36m\]"
    local BOLD_BLUE="\[\e[1;34m\]"
    local BOLD_GREEN="\[\e[1;32m\]"

    # Use CUSTOM_USER variable
    CUSTOM_USER="__USERNAME__"

    # Build first line: ╭── [venv] user@host directory [time]
    PS1="${BOLD}${GREEN}╭── ${RESET}${venv}${BOLD}${RED}${CUSTOM_USER}${RESET}${CYAN}@${RESET}${BOLD_GREEN}\h${RESET} ${BOLD_BLUE}\w${RESET} ${WHITE}[${RESET}${BOLD}${RED}\t${RESET}${WHITE}]${RESET}\n"
    # Build second line: ╰───▶
    PS1+="${BOLD}${GREEN}╰───${RESET}${BOLD}${RED}▶${RESET}${BOLD_GREEN} "
}

# Tell bash to run this function before every prompt
PROMPT_COMMAND=set_prompt
EOF

# Replace placeholder with actual username
sed -i "s/__USERNAME__/${CUSTOM_USER_INPUT}/" ~/.bashrc

echo "[√] Prompt configured"

# ------------------------------------------------------------
#  Reload terminal
# ------------------------------------------------------------
echo "[/] Reloading terminal..."
termux-reload-settings
source ~/.bashrc 2>/dev/null

echo "[√] Setup complete"
echo "  • Restart Termux to see full effect."
echo "=============================="
