#!/bin/bash

# Load variables from .env if it exists
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

# Check if WALLET_ADDRESS is set
if [ -z "$WALLET_ADDRESS" ]; then
  echo "❌ Error: WALLET_ADDRESS is not set in environment or .env file."
  echo "Example in .env:"
  echo "WALLET_ADDRESS=1H1GPLkoMGVUfxQcJgtjWTrKV1KJCQooEV5WxPMhP4Zjy"
  exit 1
fi

# Endpoint
FAUCET_URL="https://faucet.testnet.alephium.org/send"

# Execute POST request
echo "💧 Requesting testnet funds for wallet: $WALLET_ADDRESS"
RESPONSE=$(curl -s -w "\nHTTP_STATUS:%{http_code}" -X POST -d "$WALLET_ADDRESS" "$FAUCET_URL")

# Extract body and status
HTTP_BODY=$(echo "$RESPONSE" | sed -e 's/HTTP_STATUS\:.*//g')
HTTP_STATUS=$(echo "$RESPONSE" | tr -d '\n' | sed -e 's/.*HTTP_STATUS://')

# Output results
if [ "$HTTP_STATUS" -eq 200 ]; then
  echo "✅ Success: Faucet response:"
  echo "$HTTP_BODY"
else
  echo "❌ Error: Faucet returned status code $HTTP_STATUS"
  echo "$HTTP_BODY"
fi

