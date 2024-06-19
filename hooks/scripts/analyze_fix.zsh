#!/bin/zsh

# shellcheck disable=SC2154
source "$(dirname "$0")/../script.cfg"
scriptName=$(basename "$0")

echo "${Red}Executing $scriptName${NC}"

# update dart code formatting and resolve common issues
dart format --fix -l 150 "$top_level_dir" 1>/dev/null
dart format --fix -l 100 "$top_level_dir" 1>/dev/null
dart fix --apply "$top_level_dir" 1>/dev/null
dart format --fix -l 150 "$top_level_dir" 1>/dev/null

function hasIssues() {
  local result

  result=$(flutter analyze)

  if grep -q "No issues found" <<<"$result"; then
    return 0 #OK
  else
    echo "$result"
    return 1 #failure
  fi
}

if ! hasIssues; then
  echo "${Red}Error in $scriptName${NC}"
  exit 1
fi

#re-format Info-*.plist
format_plists() {
  local ios_dir="$1/ios/Runner/"

  if [ -d "$ios_dir" ]; then
    cd "$ios_dir" || return 1

    find . -name '*.plist' -print0 | while IFS= read -r -d '' file; do
      plutil -convert xml1 -o - "$file" >temp.plist && mv temp.plist "$file"
    done
  fi
}

format_plists "$top_level_dir"
format_plists "$top_level_dir/example"

echo "${LightGreen}Done with $scriptName${NC}"
