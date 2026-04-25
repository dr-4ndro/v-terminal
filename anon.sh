#!/data/data/com.termux/files/usr/bin/bash
# ============================================
#  OPSEC Suite – anon.sh
#  Usage: anon {start|stop|restart|change|status|install}
# ============================================

BOLD="\e[1m"; RESET="\e[0m"; GREEN="\e[32m"; RED="\e[31m"; YELLOW="\e[33m"; CYAN="\e[36m"

anon_install() {
    echo -e "${BOLD}${GREEN}[+]${RESET} Installing OPSEC packages..."
    pkg install -y root-repo iptables tor proxychains-ng privoxy macchanger curl dnsutils jq
    echo -e "${BOLD}${GREEN}[√]${RESET} All packages installed."
}

anon_configure() {
    mkdir -p "$HOME/.config/tor"
    cat > "$HOME/.config/tor/torrc" << 'CFG'
SOCKSPort 9050
ControlPort 9051
CookieAuthentication 1
DNSPort 5353
CFG

    cat > "$HOME/.proxychains.conf" << 'CFG'
strict_chain
proxy_dns
tcp_read_time_out 15000
tcp_connect_time_out 8000
[ProxyList]
socks5 127.0.0.1 9050
socks4 127.0.0.1 9050
http 127.0.0.1 8118
CFG

    mkdir -p "$HOME/.privoxy"
    cat > "$HOME/.privoxy/config" << 'CFG'
listen-address  127.0.0.1:8118
forward-socks5t / 127.0.0.1:9050 .
CFG
}

anon_start() {
    echo -e "\n${BOLD}${GREEN}[+]${RESET} Starting Anonymous Mode...\n"

    # Auto-install if tor missing
    if ! command -v tor &>/dev/null; then
        anon_install
    fi

    pkill tor 2>/dev/null; pkill privoxy 2>/dev/null
    anon_configure

    echo -e "  ${BOLD}${GREEN}[+]${RESET} Starting Tor..."
    tor &
    sleep 3

    echo -e "  ${BOLD}${GREEN}[+]${RESET} Starting Privoxy..."
    privoxy "$HOME/.privoxy/config" &
    sleep 1

    # MAC & Hostname Spoof (requires root for macchanger)
    local iface=$(ip -o link show | grep -v "lo:" | awk -F': ' '{print $2}' | head -1)
    macchanger -r "$iface" 2>/dev/null || echo -e "  ${YELLOW}[!]${RESET} MAC spoof requires root."

    local new_host="anon-$(printf '%04x%04x' $RANDOM $RANDOM)"
    echo "$new_host" > "$HOME/.custom_hostname"
    export HOSTNAME="$new_host"
    echo -e "  ${BOLD}${GREEN}[√]${RESET} Hostname set to: ${BOLD}${RED}${new_host}${RESET}"

    echo ""
    echo -e "${BOLD}${GREEN}[√]${RESET} Anonymous mode started."
    echo -e "  • Run commands with: ${BOLD}proxychains <cmd>${RESET}"
    echo -e "  • Check status    : ${BOLD}anon status${RESET}"
    echo -e "  • Change identity : ${BOLD}anon change${RESET}"
    echo -e "  • Stop            : ${BOLD}anon stop${RESET}"
}

anon_stop() {
    echo -e "${BOLD}${GREEN}[+]${RESET} Stopping services..."
    pkill tor 2>/dev/null; pkill privoxy 2>/dev/null
    echo -e "${BOLD}${GREEN}[√]${RESET} Services stopped."
}

anon_change() {
    echo -e "${BOLD}${GREEN}[+]${RESET} Requesting new Tor identity..."
    curl --socks5 127.0.0.1:9050 --socks5-hostname 127.0.0.1:9050 -s https://check.torproject.org/ | grep -q "Congratulations" && echo -e "${BOLD}${GREEN}[√]${RESET} New identity obtained." || echo -e "${BOLD}${RED}[-]${RESET} Failed."
}

anon_status() {
    echo -e "\n${BOLD}${CYAN}[*]${RESET} Anonymity Status\n"
    pgrep tor >/dev/null && echo -e "  ${GREEN}[√]${RESET} Tor running" || echo -e "  ${RED}[-]${RESET} Tor not running"
    pgrep privoxy >/dev/null && echo -e "  ${GREEN}[√]${RESET} Privoxy running" || echo -e "  ${YELLOW}[!]${RESET} Privoxy not running"

    local check=$(curl --socks5 127.0.0.1:9050 --socks5-hostname 127.0.0.1:9050 -s https://check.torproject.org/ 2>/dev/null)
    if echo "$check" | grep -q "Congratulations"; then
        local ip=$(curl --socks5 127.0.0.1:9050 --socks5-hostname 127.0.0.1:9050 -s https://api.ipify.org 2>/dev/null)
        echo -e "  ${GREEN}[√]${RESET} Traffic via Tor – IP: ${RED}${ip}${RESET}"
    else
        echo -e "  ${RED}[-]${RESET} Traffic NOT via Tor"
    fi
    echo ""
}

case "$1" in
    start)    anon_start ;;
    stop)     anon_stop ;;
    restart)  anon_stop && sleep 2 && anon_start ;;
    change)   anon_change ;;
    status)   anon_status ;;
    install)  anon_install ;;
    *)        echo -e "${BOLD}${CYAN}Usage: anon {start|stop|restart|change|status|install}${RESET}" ;;
esaclisten-address  127.0.0.1:8118
forward-socks5t / 127.0.0.1:9050 .
CFG
}

anon_start() {
    echo -e "\n${BOLD}${GREEN}[+]${RESET} Starting Anonymous Mode...\n"

    # Auto-install if tor is missing
    if ! command -v tor &>/dev/null; then
        anon_install
    fi

    # Stop existing instances
    pkill tor 2>/dev/null; pkill privoxy 2>/dev/null

    anon_configure

    tor &
    sleep 3
    privoxy "$HOME/.privoxy/config" &
    sleep 1

    # MAC and Hostname spoof (may require root)
    local iface=$(ip -o link show | grep -v "lo:" | awk -F': ' '{print $2}' | head -1)
    macchanger -r "$iface" 2>/dev/null || true

    local new_host="anon-$(printf '%04x%04x' $RANDOM $RANDOM)"
    echo "$new_host" > "$HOME/.custom_hostname"
    export HOSTNAME="$new_host"

    echo -e "${BOLD}${GREEN}[√]${RESET} Anonymous mode started."
    echo -e "  • Commands: ${BOLD}proxychains <cmd>${RESET}"
    echo -e "  • Status : ${BOLD}anon status${RESET}"
    echo -e "  • New ID : ${BOLD}anon change${RESET}"
    echo -e "  • Stop   : ${BOLD}anon stop${RESET}"
}

anon_stop() {
    pkill tor 2>/dev/null; pkill privoxy 2>/dev/null
    echo -e "${BOLD}${GREEN}[√]${RESET} Services stopped."
}

anon_change() {
    curl --socks5 127.0.0.1:9050 --socks5-hostname 127.0.0.1:9050 -s https://check.torproject.org/ | grep -q "Congratulations" && echo -e "${BOLD}${GREEN}[√]${RESET} New identity obtained." || echo -e "${BOLD}${RED}[-]${RESET} Failed."
}

anon_status() {
    echo -e "\n${BOLD}${CYAN}[*]${RESET} Anonymity Status\n"
    pgrep tor >/dev/null && echo -e "  ${GREEN}[√]${RESET} Tor running" || echo -e "  ${RED}[-]${RESET} Tor not running"
    pgrep privoxy >/dev/null && echo -e "  ${GREEN}[√]${RESET} Privoxy running" || echo -e "  ${YELLOW}[!]${RESET} Privoxy not running"
    local check=$(curl --socks5 127.0.0.1:9050 --socks5-hostname 127.0.0.1:9050 -s https://check.torproject.org/ 2>/dev/null)
    if echo "$check" | grep -q "Congratulations"; then
        local ip=$(curl --socks5 127.0.0.1:9050 --socks5-hostname 127.0.0.1:9050 -s https://api.ipify.org 2>/dev/null)
        echo -e "  ${GREEN}[√]${RESET} Traffic via Tor – IP: ${RED}${ip}${RESET}"
    else
        echo -e "  ${RED}[-]${RESET} Traffic NOT via Tor"
    fi
    echo ""
}

case "$1" in
    start)    anon_start ;;
    stop)     anon_stop ;;
    restart)  anon_stop && sleep 2 && anon_start ;;
    change)   anon_change ;;
    status)   anon_status ;;
    install)  anon_install ;;
    *)        echo -e "${BOLD}${CYAN}Usage: anon {start|stop|restart|change|status|install}${RESET}" ;;
esachttp 127.0.0.1 8118
CFG
}

# Configure Privoxy
anon_configure_privoxy() {
    mkdir -p "$HOME/.privoxy"
    cat > "$HOME/.privoxy/config" << 'CFG'
listen-address  127.0.0.1:8118
forward-socks5t / 127.0.0.1:9050 .
CFG
}

# Spoof MAC
anon_spoof_mac() {
    local iface=$(ip -o link show | grep -v "lo:" | awk -F': ' '{print $2}' | head -1)
    macchanger -r "$iface" 2>/dev/null || echo -e "${YELLOW}[!]${RESET} MAC spoof requires root."
}

# Spoof Hostname
anon_spoof_hostname() {
    local new_host="anon-$(printf '%04x%04x' $RANDOM $RANDOM)"
    echo "$new_host" > "$HOME/.custom_hostname"
    export HOSTNAME="$new_host"
}

# Start Tor & Privoxy
anon_start_services() {
    pkill tor 2>/dev/null; pkill privoxy 2>/dev/null
    anon_configure_tor; anon_configure_proxychains; anon_configure_privoxy
    tor & sleep 3
    privoxy "$HOME/.privoxy/config" & sleep 1
}

# Start full anon mode
anon_start() {
    echo -e "\n${BOLD}${GREEN}[+]${RESET} Starting Anonymous Mode...\n"
    anon_install
    anon_start_services
    anon_spoof_mac
    anon_spoof_hostname
    echo -e "${BOLD}${GREEN}[√]${RESET} Anonymous mode started."
    echo -e "  • Use ${BOLD}proxychains <command>${RESET}"
    echo -e "  • Check status: ${BOLD}anon status${RESET}"
    echo -e "  • Change identity: ${BOLD}anon change${RESET}"
    echo -e "  • Stop: ${BOLD}anon stop${RESET}"
}

# Stop all
anon_stop() {
    pkill tor 2>/dev/null; pkill privoxy 2>/dev/null
    echo -e "${BOLD}${GREEN}[√]${RESET} All services stopped."
}

# Change identity
anon_change() {
    echo -e "${BOLD}${GREEN}[+]${RESET} Requesting new Tor identity..."
    curl --socks5 127.0.0.1:9050 --socks5-hostname 127.0.0.1:9050 -s https://check.torproject.org/ | grep -q "Congratulations" && echo -e "${BOLD}${GREEN}[√]${RESET} New identity obtained." || echo -e "${BOLD}${RED}[-]${RESET} Failed."
}

# Status check
anon_status() {
    echo -e "\n${BOLD}${CYAN}[*]${RESET} Checking anonymity status...\n"
    if pgrep tor >/dev/null; then echo -e "  ${GREEN}[√]${RESET} Tor running"; else echo -e "  ${RED}[-]${RESET} Tor not running"; fi
    if pgrep privoxy >/dev/null; then echo -e "  ${GREEN}[√]${RESET} Privoxy running"; else echo -e "  ${YELLOW}[!]${RESET} Privoxy not running"; fi

    local check=$(curl --socks5 127.0.0.1:9050 --socks5-hostname 127.0.0.1:9050 -s https://check.torproject.org/ 2>/dev/null)
    if echo "$check" | grep -q "Congratulations"; then
        local ip=$(curl --socks5 127.0.0.1:9050 --socks5-hostname 127.0.0.1:9050 -s https://api.ipify.org 2>/dev/null)
        echo -e "  ${GREEN}[√]${RESET} Traffic routed via Tor (IP: ${RED}${ip}${RESET})"
    else
        echo -e "  ${RED}[-]${RESET} Traffic NOT routed via Tor"
    fi
    echo ""
}

# Command handler
case "$1" in
    start)    anon_start ;;
    stop)     anon_stop ;;
    restart)  anon_stop; sleep 2; anon_start ;;
    change)   anon_change ;;
    status)   anon_status ;;
    install)  anon_install ;;
    *)        echo -e "${BOLD}${CYAN}Usage: anon {start|stop|restart|change|status|install}${RESET}" ;;
esac
