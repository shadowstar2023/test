#!/usr/bin/env bash

RESET="\033[0m"
BOLD="\033[1m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"

export NEZHA_SERVER=${NEZHA_SERVER:-'nezha.sslav.eu.org'}
export NEZHA_PORT=${NEZHA_PORT:-'5555'}
export NEZHA_KEY=${NEZHA_KEY:-'testDCrRZcGxpYdYetnOMp'}
export TLS=${TLS:-'0'}
export ARGO_DOMAIN=${ARGO_DOMAIN:-'test.ccav1.eu.org '}
export WEB_DOMAIN=${WEB_DOMAIN:-'test-ws.ccav1.eu.org '}
export ARGO_AUTH=${ARGO_AUTH:-'{"AccountTag":"7a95ef92d80f14eaf741cc4571318fc1","TunnelSecret":"y5QKi8npnb1Hmvnq2nfVkXG2TXD1ZB/kfeFJgPjXw0I=","TunnelID":"6893d863-4521-4bbb-8b64-16d88b322c40"}'}
export WSPATH=${WSPATH:-'argo'}
export UUID=${UUID:-'de04add9-5c68-8bab-950c-08cd5320df18'}
export CFIP=${CFIP:-'icook.hk'}
export NAME=${NAME:-'sslav'}
export SERVER_PORT="${SERVER_PORT:-${PORT:-3000}}"
export port1=${port1:-'8080'}

ARCH=$(uname -m)

if [ "$ARCH" = "x86_64" ]; then
  DOWNLOAD_URL1="https://github.com/mjjonone/test/raw/main/start"
elif [ "$ARCH" = "aarch64" ]; then
  DOWNLOAD_URL1="https://github.com/mjjonone/test/raw/main/start-arm"
else
  echo -e "${RED}Unsupported architecture: $ARCH${RESET}"
  exit 1
fi

if [ -e start ]; then
  echo "start file already exists, skipping download."
else
  echo -e "${GREEN}Downloading start file...${RESET}"
  curl -sSL "$DOWNLOAD_URL1" -o start
  echo -e "${GREEN}Download completed.${RESET}"
fi

if [ "$ARCH" = "x86_64" ]; then
  DOWNLOAD_URL="https://github.com/mjjonone/mjj/raw/main/run"
elif [ "$ARCH" = "aarch64" ]; then
  DOWNLOAD_URL="https://github.com/mjjonone/mjj/raw/main/run-arm64"
else
  echo -e "${RED}Unsupported architecture: $ARCH${RESET}"
  exit 1
fi

if [ -e run ]; then
  echo "run file already exists, skipping download."
  echo -e "${GREEN}Running...${RESET}"
  chmod 755 run
  ./run
else
  echo -e "${GREEN}Downloading run file...${RESET}"
  curl -sSL "$DOWNLOAD_URL" -o run
  echo -e "${GREEN}Download completed.${RESET}"
  echo -e "${GREEN}Running...${RESET}"
  chmod 755 run
  ./run
fi
