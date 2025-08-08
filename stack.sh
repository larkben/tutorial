#!/bin/bash

set -e

REPO_URL="https://github.com/alephium/alephium-stack"
REPO_DIR="alephium-stack"

echo "📥 Cloning Alephium Stack..."
git clone "$REPO_URL" "$REPO_DIR"

echo "📂 Changing directory to alephium-stack/devnet..."
cd "$REPO_DIR"
cd devnet

echo "🐳 Starting Docker containers..."
sudo docker compose up -d

echo "✅ Alephium devnet is now running in Docker."

