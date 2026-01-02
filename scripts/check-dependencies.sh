#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "Checking dependencies..."

# Check Docker
if ! command -v docker &> /dev/null; then
    echo -e "${RED}✗ Docker is not installed${NC}"
    echo "  Install Docker from: https://docs.docker.com/get-docker/"
    exit 1
else
    echo -e "${GREEN}✓ Docker is installed${NC}"
    docker --version
fi

# Check Docker Compose
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}✗ Docker Compose is not installed${NC}"
    echo "  Install Docker Compose from: https://docs.docker.com/compose/install/"
    exit 1
else
    echo -e "${GREEN}✓ Docker Compose is installed${NC}"
    docker-compose --version
fi

# Check if Docker daemon is running
if ! docker ps &> /dev/null; then
    echo -e "${RED}✗ Docker daemon is not running${NC}"
    echo "  Please start Docker Desktop or Docker daemon"
    exit 1
else
    echo -e "${GREEN}✓ Docker daemon is running${NC}"
fi

# Check Make
if ! command -v make &> /dev/null; then
    echo -e "${YELLOW}⚠ Make is not installed${NC}"
    echo "  Install Make:"
    echo "    - macOS: xcode-select --install"
    echo "    - Linux: sudo apt-get install build-essential"
    exit 1
else
    echo -e "${GREEN}✓ Make is installed${NC}"
    make --version | head -n 1
fi

# Check Node.js (optional, for web interface)
if ! command -v node &> /dev/null; then
    echo -e "${YELLOW}⚠ Node.js is not installed (optional for web interface)${NC}"
    echo "  Install Node.js from: https://nodejs.org/"
else
    echo -e "${GREEN}✓ Node.js is installed${NC}"
    node --version
fi

echo ""
echo -e "${GREEN}All required dependencies are installed and ready!${NC}"

