#!/bin/sh
set -e

if [ -t 1 ]; then
    GREEN='\033[0;32m'
    BLUE='\033[0;34m'
    RED='\033[0;31m'
    NC='\033[0m'
else
    GREEN=''
    BLUE=''
    RED=''
    NC=''
fi

echo "${BLUE}===Check requirements===${NC}"

if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS_ID=$ID
    OS_LIKE=$ID_LIKE
else
    OS_ID=$(uname -s | tr '[:upper:]' '[:lower:]')
    OS_LIKE=""
fi

is_debian_like=0
if [ "$OS_ID" = "ubuntu" ] || [ "$OS_ID" = "debian" ]; then
    is_debian_like=1
else
    for like in $OS_LIKE; do
        if [ "$like" = "debian" ] || [ "$like" = "ubuntu" ]; then
            is_debian_like=1
            break
        fi
    done
fi

if [ "$is_debian_like" -ne 1 ]; then
    echo "${RED}[ERROR] The script supports Debian-like OS only.${NC}" >&2
    exit 1
fi

for cmd in curl gpg; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "${RED}[ERROR] The '$cmd' package is not installed and requires to continue.${NC}" >&2
        exit 1
    fi
done

SUDO=""
if [ "$(id -u)" -ne 0 ]; then
    if command -v sudo >/dev/null 2>&1; then
        SUDO="sudo"
    else
        echo "${RED}[ERROR] The script has not run in behalf of root.${NC}" >&2
        exit 1
    fi
fi

ARCH=$(uname -m)
PACKAGE_NAME=""

case "$ARCH" in
    x86_64)
        echo "Found architecture: ${GREEN}x86_64${NC}"
        if [ -f /proc/cpuinfo ]; then
            CPU_INFO=$(grep -E -o 'avx512|avx2|sse4_2' /proc/cpuinfo 2>/dev/null | sort -u || true)
        else
            CPU_INFO=""
        fi

        if echo "$CPU_INFO" | grep "avx512" >/dev/null 2>&1; then
            PACKAGE_NAME="ratatoskr-v6-avx512"
        elif echo "$CPU_INFO" | grep "avx2" >/dev/null 2>&1; then
            PACKAGE_NAME="ratatoskr-v6-avx2"
        elif echo "$CPU_INFO" | grep "sse4_2" >/dev/null 2>&1; then
            PACKAGE_NAME="ratatoskr-v6-sse42"
        else
            PACKAGE_NAME="ratatoskr-v6-generic"
        fi
        ;;
        
    aarch64|arm64)
        echo "Found architecture: ${GREEN}aarch64${NC}"
        if [ -f /proc/cpuinfo ] && grep -E -q 'atomics|lse' /proc/cpuinfo 2>/dev/null; then
            PACKAGE_NAME="ratatoskr-v6-lse"
        else
            PACKAGE_NAME="ratatoskr-v6-neon"
        fi
        ;;
        
    *)
        echo "${RED}[ERROR] The architecture $ARCH is not supported by Ratatoskr.${NC}" >&2
        exit 1
        ;;
esac

echo "Chosen candidate to installation: ${GREEN}$PACKAGE_NAME${NC}"

echo "${BLUE}===Setting up APT===${NC}"

$SUDO mkdir -p /etc/apt/keyrings

echo "Importing public key..."
curl -fsSL https://natsuru-san.github.io/Ratatoskr/natsuru-public-keyring.gpg | \
    $SUDO gpg --dearmor --yes -o /etc/apt/keyrings/natsuru-public-keyring.gpg

echo "Adding the Ratatoskr repository to the sources.list.d..."
echo "deb [signed-by=/etc/apt/keyrings/natsuru-public-keyring.gpg] https://natsuru-san.github.io/Ratatoskr stable main" | \
    $SUDO tee /etc/apt/sources.list.d/ratatoskr-repository.list > /dev/null

echo "Updating apt indexes..."
$SUDO apt-get update -y

echo "${BLUE}Setup $PACKAGE_NAME...${NC}"
$SUDO apt-get install -y "$PACKAGE_NAME"

echo "${GREEN}===Ratatoskr installation has been finished successfully!===${NC}"

