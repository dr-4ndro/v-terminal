#!/data/data/com.termux/files/usr/bin/bash
# ============================================
#  Terminal Setup Script (v_terminal)
#  Font, Banner, Venv-aware Prompt + Clear
# ============================================

clear
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
