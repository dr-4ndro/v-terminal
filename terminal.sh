#!/data/data/com.termux/files/usr/bin/bash
# ============================================
#  v_terminal Setup Script
#  Font, Banner, Dragon Prompt, OPSEC
# ============================================

# Colors for script output
BOLD="\e[1m"
RESET="\e[0m"
GREEN="\e[32m"
RED="\e[31m"
CYAN="\e[36m"
WHITE="\e[37m"

clear
echo -e "${BOLD}${CYAN}==============================${RESET}"
echo -e "${BOLD}${CYAN}  Starting v_terminal Setup...${RESET}"
echo -e "${BOLD}${CYAN}==============================${RESET}"
echo ""

# ------------------------------------------------------------
#  Ask for custom username (arrow prompt)
# ------------------------------------------------------------
echo -e "${BOLD}${GREEN}╭── ${RESET}${BOLD}${RED}setup${RESET}${CYAN}@${RESET}${BOLD}${GREEN}termux${RESET} ${WHITE}[?]${RESET}"
echo -ne "${BOLD}${GREEN}╰──▶ ${RESET}${BOLD}${GREEN}Enter username: ${RESET}"
read CUSTOM_USER_INPUT

if [ -z "$CUSTOM_USER_INPUT" ]; then
    CUSTOM_USER_INPUT="$(whoami)"
    echo -e "${BOLD}${GREEN}[i]${RESET} Using current username: ${BOLD}${RED}${CUSTOM_USER_INPUT}${RESET}"
else
    echo -e "${BOLD}${GREEN}[i]${RESET} Username set to: ${BOLD}${RED}${CUSTOM_USER_INPUT}${RESET}"
fi

# ------------------------------------------------------------
#  Install MesloLGS NF Font
# ------------------------------------------------------------
FONT_FILE="$HOME/.termux/font.ttf"
FONT_URL="https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"

if [ -f "$FONT_FILE" ] && [ -s "$FONT_FILE" ]; then
    echo -e "${BOLD}${GREEN}[i]${RESET} Font already installed. Skipping download."
else
    echo -e "${BOLD}${GREEN}[+]${RESET} Downloading font..."
    mkdir -p "$HOME/.termux"
    curl -sL -o "$FONT_FILE" "$FONT_URL"

    if [ -f "$FONT_FILE" ] && [ -s "$FONT_FILE" ]; then
        echo -e "${BOLD}${GREEN}[√]${RESET} Font installed"
    else
        echo -e "${BOLD}${RED}[-]${RESET} Font download failed. Check network."
        exit 1
    fi
fi

# ------------------------------------------------------------
#  Download Banner from GitHub
# ------------------------------------------------------------
BANNER_FILE="$HOME/banner.txt"
BANNER_URL="https://raw.githubusercontent.com/dr-4ndro/v-terminal/main/banner.txt"

if [ ! -f "$BANNER_FILE" ]; then
    echo -e "${BOLD}${GREEN}[+]${RESET} Downloading banner..."
    curl -sL -o "$BANNER_FILE" "$BANNER_URL"

    if [ -f "$BANNER_FILE" ] && [ -s "$BANNER_FILE" ]; then
        echo -e "${BOLD}${GREEN}[√]${RESET} Banner downloaded"
    else
        echo -e "${BOLD}${YELLOW}[!]${RESET} Banner download failed, continuing without it"
    fi
else
    echo -e "${BOLD}${GREEN}[i]${RESET} Banner already exists. Skipping download."
fi

# ------------------------------------------------------------
#  Download OPSEC Anonymity Script (anon.sh)
# ------------------------------------------------------------
ANON_FILE="$HOME/anon.sh"
ANON_URL="https://raw.githubusercontent.com/dr-4ndro/v-terminal/main/anon.sh"

if [ ! -f "$ANON_FILE" ]; then
    echo -e "${BOLD}${GREEN}[+]${RESET} Downloading anon script..."
    curl -sL -o "$ANON_FILE" "$ANON_URL"

    if [ -f "$ANON_FILE" ] && [ -s "$ANON_FILE" ]; then
        echo -e "${BOLD}${GREEN}[√]${RESET} anon script downloaded"
    else
        echo -e "${BOLD}${YELLOW}[!]${RESET} anon script download failed. OPSEC commands unavailable."
    fi
else
    echo -e "${BOLD}${GREEN}[i]${RESET} anon script already exists. Skipping download."
fi

# ------------------------------------------------------------
#  Write .bashrc with Dragon Prompt + OPSEC Function
# ------------------------------------------------------------
echo -e "${BOLD}${GREEN}[+]${RESET} Configuring terminal prompt and OPSEC..."

cat > ~/.bashrc << 'EOF'
# ============================================
#  Dragon Terminal Prompt (Venv-aware)
#  Banner + OPSEC (anon function)
# ============================================

# Clear screen first
clear

# Display banner if present
if [ -f ~/banner.txt ]; then
    cat ~/banner.txt
fi

# Anonymity function
if [ -f ~/anon.sh ]; then
    anon() {
        source ~/anon.sh "$@"
    }
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
echo -e "${BOLD}${CYAN}==============================${RESET}"
# ------------------------------------------------------------
#  Ask for custom username (arrow prompt)
# ------------------------------------------------------------
echo -e "${BOLD}${GREEN}╭── ${RESET}${BOLD}${RED}setup${RESET}${CYAN}@${RESET}${BOLD}${GREEN}termux${RESET} ${WHITE}[?]${RESET}"
echo -ne "${BOLD}${GREEN}╰──▶ ${RESET}${BOLD}${GREEN}Enter username: ${RESET}"
read CUSTOM_USER_INPUT

if [ -z "$CUSTOM_USER_INPUT" ]; then
    CUSTOM_USER_INPUT="$(whoami)"
    echo -e "${BOLD}${GREEN}[i]${RESET} Using current username: ${BOLD}${RED}${CUSTOM_USER_INPUT}${RESET}"
else
    echo -e "${BOLD}${GREEN}[i]${RESET} Username set to: ${BOLD}${RED}${CUSTOM_USER_INPUT}${RESET}"
fi

# ------------------------------------------------------------
#  Install MesloLGS NF Font (skip if already exists)
# ------------------------------------------------------------
FONT_FILE="$HOME/.termux/font.ttf"
FONT_URL="https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"

if [ -f "$FONT_FILE" ] && [ -s "$FONT_FILE" ]; then
    echo -e "${BOLD}${GREEN}[i]${RESET} Font already installed. Skipping download."
else
    echo -e "${BOLD}${GREEN}[+]${RESET} Downloading font..."
    mkdir -p "$HOME/.termux"
    curl -sL -o "$FONT_FILE" "$FONT_URL" &
    spin $! "Downloading font"

    if [ -f "$FONT_FILE" ] && [ -s "$FONT_FILE" ]; then
        echo -e "${BOLD}${GREEN}[√]${RESET} Font installed"
    else
        echo -e "${BOLD}${RED}[-]${RESET} Font download failed."
        exit 1
    fi
fi

# ------------------------------------------------------------
#  Download Banner from GitHub
# ------------------------------------------------------------
BANNER_FILE="$HOME/banner.txt"
BANNER_URL="https://raw.githubusercontent.com/dr-4ndro/v-terminal/main/banner.txt"

if [ ! -f "$BANNER_FILE" ]; then
    echo -e "${BOLD}${GREEN}[+]${RESET} Downloading banner..."
    curl -sL -o "$BANNER_FILE" "$BANNER_URL" &
    spin $! "Downloading banner"

    if [ -f "$BANNER_FILE" ] && [ -s "$BANNER_FILE" ]; then
        echo -e "${BOLD}${GREEN}[√]${RESET} Banner downloaded"
    else
        echo -e "${BOLD}${YELLOW}[!]${RESET} Banner download failed, continuing without it"
    fi
else
    echo -e "${BOLD}${GREEN}[i]${RESET} Banner already exists. Skipping download."
fi

# ------------------------------------------------------------
#  Download OPSEC Anonymity Script (anon.sh)
# ------------------------------------------------------------
ANON_FILE="$HOME/anon.sh"
ANON_URL="https://raw.githubusercontent.com/dr-4ndro/v-terminal/main/anon.sh"

if [ ! -f "$ANON_FILE" ]; then
    echo -e "${BOLD}${GREEN}[+]${RESET} Downloading anon script..."
    curl -sL -o "$ANON_FILE" "$ANON_URL" &
    spin $! "Downloading anon script"

    if [ -f "$ANON_FILE" ] && [ -s "$ANON_FILE" ]; then
        echo -e "${BOLD}${GREEN}[√]${RESET} anon script downloaded"
    else
        echo -e "${BOLD}${YELLOW}[!]${RESET} anon script download failed, OPSEC commands will not be available."
    fi
else
    echo -e "${BOLD}${GREEN}[i]${RESET} anon script already exists. Skipping download."
fi

# ------------------------------------------------------------
#  Configure terminal prompt with Venv support + OPSEC Alias
# ------------------------------------------------------------
echo -e "${BOLD}${GREEN}[+]${RESET} Configuring terminal prompt and OPSEC integration..."

cat > ~/.bashrc << 'EOF'
# ============================================
#  Dragon Terminal Prompt (Venv-aware)
#  Banner + OPSEC Alias
# ============================================

# Clear screen first
clear

# Display banner if present
if [ -f ~/banner.txt ]; then
    cat ~/banner.txt
fi

# Source OPSEC script (if present)
if [ -f ~/anon.sh ]; then
    source ~/anon.sh
    alias anon='source ~/anon.sh'
fi

# Install OPSEC packages if missing (first time)
if [ -f ~/anon.sh ] && ! command -v tor &>/dev/null; then
    echo -e "\e[1;33m[!]\e[0m OPSEC packages not installed. Run '\e[1;32manon install\e[0m' (optional)."
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
