#!/bin/zsh

# shellcheck disable=SC2154
source "$(dirname "$0")/../script.cfg"
scriptName=$(basename "$0")

echo "${Red}Executing $scriptName${NC}"

zsh "$top_level_dir/hooks/scripts/setup_app.zsh"
[[ $? == 1 ]] && exit 1

zsh "$top_level_dir/hooks/scripts/analyze_fix.zsh"
[[ $? == 1 ]] && exit 1

echo "${Red}Checking for uncommitted changes${NC}"

if [[ -n $(git status -s) ]]; then
  echo "${Red}Uncommitted changed found${NC}"
  exit 1
else
  echo "${LightGreen}No uncommitted changed found${NC}"
fi

# run tests
zsh "$top_level_dir/hooks/scripts/run_tests.zsh"
[[ $? == 1 ]] && exit 1

if [[ -n $(git status -s) ]]; then
  echo "${Red}Uncommitted changed after merging found${NC}"
  exit 1
elif [[ -n $(git diff --name-only --diff-filter=U) ]]; then
  echo "${Red}Merge resulted in conflicts. Resolve conflicts and commit.${NC}"
  exit 1
fi

echo "${LightGreen}Done with $scriptName${NC}"

exit 0
