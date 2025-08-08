#!/bin/bash

# Name of the env file
ENV_FILE=".env"

# Prompt for variables
read -p "Enter your wallet address: " WALLET_ADDRESS
read -p "Enter your test key: " TESTKEY
read -p "Enter your production key: " PRODKEY

# Create or overwrite the .env file
cat <<EOL > $ENV_FILE
# Environment variables for Alephium faucet and API keys
WALLET_ADDRESS=$WALLET_ADDRESS
TESTKEY=$TESTKEY
PRODKEY=$PRODKEY
EOL

echo "✅ $ENV_FILE file created with wallet address, test key, and production key."
echo "   You can edit it anytime with: nano $ENV_FILE"

