#!/data/data/com.termux/files/usr/bin/bash
# ============================================
#  v_terminal Setup (Robust)
#  Font, Banner, Anon, Dragon Prompt
# ============================================

BOLD="\e[1m"; RESET="\e[0m"; GREEN="\e[32m"; RED="\e[31m"; CYAN="\e[36m"; WHITE="\e[37m"

clear
echo -e "${BOLD}${CYAN}==============================${RESET}"
echo -e "${BOLD}${CYAN}  Starting v_terminal Setup...${RESET}"
echo -e "${BOLD}${CYAN}==============================${RESET}"
echo ""

# --- Username ---
echo -e "${BOLD}${GREEN}╭── ${RESET}${BOLD}${RED}setup${RESET}${CYAN}@${RESET}${BOLD}${GREEN}termux${RESET} ${WHITE}[?]${RESET}"
echo -ne "${BOLD}${GREEN}╰──▶ ${RESET}${BOLD}${GREEN}Enter username: ${RESET}"
read CUSTOM_USER_INPUT

if [ -z "$CUSTOM_USER_INPUT" ]; then
    CUSTOM_USER_INPUT="$(whoami)"
    echo -e "${BOLD}${GREEN}[i]${RESET} Using current username: ${BOLD}${RED}${CUSTOM_USER_INPUT}${RESET}"
else
    echo -e "${BOLD}${GREEN}[i]${RESET} Username set to: ${BOLD}${RED}${CUSTOM_USER_INPUT}${RESET}"
fi

# --- Font ---
FONT_FILE="$HOME/.termux/font.ttf"
FONT_URL="https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"

echo -e "${BOLD}${GREEN}[+]${RESET} Checking Font..."
if [ -f "$FONT_FILE" ] && [ -s "$FONT_FILE" ]; then
    echo -e "  ${BOLD}${GREEN}[i]${RESET} Font exists. Skipping."
else
    echo -e "  ${BOLD}${GREEN}[+]${RESET} Downloading font..."
    mkdir -p "$HOME/.termux"
    curl -sL -o "$FONT_FILE" "$FONT_URL"
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

# --- Anon Script ---
ANON_FILE="$HOME/anon.sh"
ANON_URL="https://raw.githubusercontent.com/dr-4ndro/v-terminal/main/anon.sh"

echo -e "${BOLD}${GREEN}[+]${RESET} Checking OPSEC script..."
if [ ! -f "$ANON_FILE" ]; then
    echo -e "  ${BOLD}${GREEN}[+]${RESET} Downloading anon.sh..."
    curl -sL -o "$ANON_FILE" "$ANON_URL"
    if [ -f "$ANON_FILE" ] && [ -s "$ANON_FILE" ]; then
        chmod +x "$ANON_FILE"
        echo -e "  ${BOLD}${GREEN}[√]${RESET} anon.sh downloaded."
    else
        echo -e "  ${BOLD}${YELLOW}[!]${RESET} anon.sh download failed. OPSEC will be unavailable."
    fi
else
    echo -e "  ${BOLD}${GREEN}[i]${RESET} anon.sh exists. Skipping."
fi

# --- .bashrc Configuration ---
echo -e "${BOLD}${GREEN}[+]${RESET} Configuring Dragon Terminal..."

# WARNING: We use 'EOF' (quoted) to prevent shell expansion inside the heredoc
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

# Prompt
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

    # __USERNAME__ will be replaced by setup script
    CUSTOM_USER="__USERNAME__"

    PS1="${BOLD}${GREEN}╭── ${RESET}${venv}${BOLD}${RED}${CUSTOM_USER}${RESET}${CYAN}@${RESET}${BOLD_GREEN}\h${RESET} ${BOLD_BLUE}\w${RESET} ${WHITE}[${RESET}${BOLD}${RED}\t${RESET}${WHITE}]${RESET}\n"
    PS1+="${BOLD}${GREEN}╰───${RESET}${BOLD}${RED}▶${RESET}${BOLD_GREEN} "
}

PROMPT_COMMAND=set_prompt
EOF

# Inject the chosen username
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
echo -e "${BOLD}${CYAN}==============================${RESET}"    echo -e "${BOLD}${GREEN}[i]${RESET} Font already installed. Skipping."
else
    echo -e "${BOLD}${GREEN}[+]${RESET} Downloading font..."
    mkdir -p "$HOME/.termux"
    curl -sL -o "$FONT_FILE" "$FONT_URL"
    if [ -f "$FONT_FILE" ] && [ -s "$FONT_FILE" ]; then
        echo -e "${BOLD}${GREEN}[√]${RESET} Font installed"
    else
        echo -e "${BOLD}${RED}[-]${RESET} Font download failed."
        exit 1
    fi
fi

# ------------------------------------------------------------
#  Download Banner
# ------------------------------------------------------------
BANNER_FILE="$HOME/banner.txt"
BANNER_URL="https://raw.githubusercontent.com/dr-4ndro/v-terminal/main/banner.txt"

if [ ! -f "$BANNER_FILE" ]; then
    echo -e "${BOLD}${GREEN}[+]${RESET} Downloading banner..."
    curl -sL -o "$BANNER_FILE" "$BANNER_URL"
    if [ -f "$BANNER_FILE" ] && [ -s "$BANNER_FILE" ]; then
        echo -e "${BOLD}${GREEN}[√]${RESET} Banner downloaded"
    else
        echo -e "${BOLD}${YELLOW}[!]${RESET} Banner download failed."
    fi
else
    echo -e "${BOLD}${GREEN}[i]${RESET} Banner already exists. Skipping."
fi

# ------------------------------------------------------------
#  Download OPSEC Script (anon.sh)
# ------------------------------------------------------------
ANON_FILE="$HOME/anon.sh"
ANON_URL="https://raw.githubusercontent.com/dr-4ndro/v-terminal/main/anon.sh"

if [ ! -f "$ANON_FILE" ]; then
    echo -e "${BOLD}${GREEN}[+]${RESET} Downloading anon script..."
    curl -sL -o "$ANON_FILE" "$ANON_URL"
    if [ -f "$ANON_FILE" ] && [ -s "$ANON_FILE" ]; then
        chmod +x "$ANON_FILE"
        echo -e "${BOLD}${GREEN}[√]${RESET} anon script downloaded"
    else
        echo -e "${BOLD}${YELLOW}[!]${RESET} anon script download failed."
    fi
else
    echo -e "${BOLD}${GREEN}[i]${RESET} anon script already exists. Skipping."
fi

# ------------------------------------------------------------
#  Write .bashrc
# ------------------------------------------------------------
echo -e "${BOLD}${GREEN}[+]${RESET} Configuring terminal prompt and tools..."

cat > ~/.bashrc << 'EOF'
# ============================================
#  Dragon Terminal Prompt (Venv-aware)
#  Banner + OPSEC (anon function)
# ============================================

# Clear screen and show banner
clear
if [ -f ~/banner.txt ]; then
    cat ~/banner.txt
fi

# Anonymity function (if anon.sh exists)
if [ -f ~/anon.sh ]; then
    anon() {
        bash ~/anon.sh "$@"
    }
fi

# Venv-aware prompt
set_prompt() {
    local venv=""
    if [ -n "$VIRTUAL_ENV" ]; then
        venv="\[\e[35m\]($(basename "$VIRTUAL_ENV"))\[\e[0m\] "
    fi

    local RESET="\[\e[0m\]"; local BOLD="\[\e[1m\]"
    local GREEN="\[\e[32m\]"; local RED="\[\e[31m\]"
    local WHITE="\[\e[37m\]"; local CYAN="\[\e[36m\]"
    local BOLD_BLUE="\[\e[1;34m\]"; local BOLD_GREEN="\[\e[1;32m\]"

    CUSTOM_USER="__USERNAME__"

    PS1="${BOLD}${GREEN}╭── ${RESET}${venv}${BOLD}${RED}${CUSTOM_USER}${RESET}${CYAN}@${RESET}${BOLD_GREEN}\h${RESET} ${BOLD_BLUE}\w${RESET} ${WHITE}[${RESET}${BOLD}${RED}\t${RESET}${WHITE}]${RESET}\n"
    PS1+="${BOLD}${GREEN}╰───${RESET}${BOLD}${RED}▶${RESET}${BOLD_GREEN} "
}
PROMPT_COMMAND=set_prompt
EOF

# Replace username placeholder
sed -i "s/__USERNAME__/${CUSTOM_USER_INPUT}/" ~/.bashrc

echo -e "${BOLD}${GREEN}[√]${RESET} Prompt configured"

# ------------------------------------------------------------
#  Reload terminal
# ------------------------------------------------------------
echo -e "${BOLD}${GREEN}[/]${RESET} Reloading terminal..."
termux-reload-settings
source ~/.bashrc 2>/dev/null

echo -e "${BOLD}${GREEN}[√]${RESET} Setup complete"
echo -e "  • Restart Termux to see full effect."
echo -e "  • To start anonymous mode: ${BOLD}${RED}anon start${RESET}"
echo -e "${BOLD}${CYAN}==============================${RESET}"       venv="\[\e[35m\]($(basename "$VIRTUAL_ENV"))\[\e[0m\] "
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

echo -e "${BOLD}${GREEN}[√]${RESET} Prompt configured"

# ------------------------------------------------------------
#  Reload terminal
# ------------------------------------------------------------
echo -e "${BOLD}${GREEN}[/]${RESET} Reloading terminal..."
termux-reload-settings
source ~/.bashrc 2>/dev/null

echo -e "${BOLD}${GREEN}[√]${RESET} Setup complete"
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
