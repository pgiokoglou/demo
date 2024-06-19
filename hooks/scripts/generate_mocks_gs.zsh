#!/bin/zsh

# shellcheck disable=SC2154
source "$(dirname "$0")/../script.cfg"
scriptName=$(basename "$0")

echo "${Red}Executing $scriptName${NC}"

oldDir=$(pwd) # cache old directory

cd "$top_level_dir" || exit 1 # navigate to project level

#remove auto generated files and dirs
rm -r "$top_level_dir/lib/generated" 1>/dev/null
[ -d "example/ios/.symlinks" ] && rm -rf "example/ios/.symlinks"
find "$top_level_dir" -name "*.*.dart" -type f -delete 1>/dev/null

zsh "$top_level_dir/hooks/scripts/pub_setup.zsh"

# generate files
result=$(dart pub run build_runner build --delete-conflicting-outputs) 1>/dev/null

if [[ $result == *"[SEVERE]"* && $result != *"[SEVERE] Nothing can be built, yet a build was requested"* ]]; then
  echo "$result" | awk '/^\[SEVERE\]/{p=1}p'
  echo "${Red}Error in $scriptName${NC}"
  cd "$oldDir" && exit 1 # return to old directory
else
  echo "${LightGreen}Done with $scriptName${NC}"
  cd "$oldDir" && exit 0 || exit 1 # return to old directory
fi
