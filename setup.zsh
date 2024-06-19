#!/bin/zsh
Red='\033[0;31m'
NC='\033[0m' # No Color
LightGreen='\033[1;32m'

top_level_dir=$(git rev-parse --show-toplevel)

echo "${LightGreen}Updating hooks${NC}"
git config core.hooksPath hooks

cp config.txt config.env && cp config.txt config.xcconfig

zsh "hooks/scripts/setup_app.zsh"
