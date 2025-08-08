#!/bin/bash

# Function to compare Java versions
version_greater_equal() {
  # Compare major versions
  [ "$1" -ge "$2" ]
}

# Check if Java is installed
if command -v java >/dev/null 2>&1; then
  JAVA_VERSION=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}' | cut -d'.' -f1)
  
  echo "🔍 Java version detected: $JAVA_VERSION"
  
  if version_greater_equal "$JAVA_VERSION" 11; then
    echo "✅ Java version is $JAVA_VERSION, which is >= 11. No installation needed."
    exit 0
  else
    echo "⚠️ Java version is lower than 11. Installing Java 17..."
  fi
else
  echo "⚠️ Java not found. Installing Java 17..."
fi

# Install Java 17 (Debian/Ubuntu)
sudo apt update
sudo apt install -y openjdk-17-jdk

# Verify installation
java -version

