#!/bin/bash

# Setup script for make-infra project

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}Setting up make-infra project...${NC}"

# Check dependencies
echo -e "${YELLOW}Checking dependencies...${NC}"
./scripts/check-dependencies.sh

# Create network if it doesn't exist
echo -e "${YELLOW}Creating Docker network...${NC}"
docker network create infra-network 2>/dev/null || echo "Network already exists"

# Setup web interface
if [ -d "web" ]; then
    echo -e "${YELLOW}Setting up web interface...${NC}"
    cd web
    if [ ! -d "node_modules" ]; then
        echo "Installing npm dependencies..."
        npm install
    else
        echo "Dependencies already installed"
    fi
    cd ..
fi

echo -e "${GREEN}Setup complete!${NC}"
echo ""
echo "You can now:"
echo "  - Start a service: make mongodb-up"
echo "  - Start web interface: cd web && npm run dev"
echo "  - View help: make help"

