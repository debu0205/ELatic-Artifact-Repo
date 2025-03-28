#!/bin/bash

# Define the Elastic Stack version
VERSION="-----"

# URLs for Elastic Agent binaries and their checksums
LINUX_URL="https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-$VERSION-linux-x86_64.tar.gz"
LINUX_SHA512_URL="https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-$VERSION-linux-x86_64.tar.gz.sha512"
LINUX_ASC_URL="https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-$VERSION-linux-x86_64.tar.gz.asc"

WINDOWS_URL="https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-$VERSION-windows-x86_64.zip"
WINDOWS_SHA512_URL="https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-$VERSION-windows-x86_64.zip.sha512"
WINDOWS_ASC_URL="https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-$VERSION-windows-x86_64.zip.asc"

# Create a directory to store the binaries
DOWNLOAD_BASE_DIR=${DOWNLOAD_BASE_DIR;?"Make sure to set the directroy"}
cd DOWNLOAD_BASE_DIR

# Download Elastic Agent for Linux
echo "Downloading Elastic Agent for Linux..."
wget -O elastic-agent-linux.tar.gz "$LINUX_URL"
wget -O elastic-agent-linux.tar.gz.sha512 "$LINUX_SHA512_URL"
wget -O elastic-agent-linux.tar.gz.asc "$LINUX_ASC_URL"

# Download Elastic Agent for Windows
echo "Downloading Elastic Agent for Windows..."
wget -O elastic-agent-windows.zip "$WINDOWS_URL"
wget -O elastic-agent-windows.zip.sha512 "$WINDOWS_SHA512_URL"
wget -O elastic-agent-windows.zip.asc "$WINDOWS_ASC_URL"

# Confirm downloads
echo "Downloaded files:"
ls -lh elastic-agent-*
