#!/data/data/com.termux/files/usr/bin/bash
# ============================================
#  Terminal Setup Script (v_terminal)
#  Font, Banner, Venv-aware Prompt
# ============================================

echo "=============================="
echo "  Starting Terminal Setup..."
echo "=============================="
echo ""

# ------------------------------------------------------------
#  Ask for custom username (arrow prompt)
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
#  Install MesloLGS NF Font (skip if already exists)
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
#  Configure terminal prompt with Venv support
# ------------------------------------------------------------
echo "[+] Configuring terminal prompt..."

cat > ~/.bashrc << 'EOF'
# ============================================
#  Dragon Terminal Prompt (Venv-aware)
# ============================================

# Display banner at startup
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
