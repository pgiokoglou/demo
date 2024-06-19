#!/bin/zsh

# shellcheck disable=SC2154
source "$(dirname "$0")/../script.cfg"
scriptName=$(basename "$0")

echo "${Red}Executing $scriptName${NC}"

oldDir=$(pwd) # cache old directory

cd "$top_level_dir" || exit 1 # navigate to project level

if [[ ! "$1" == "--skip-pub" ]]; then
  zsh "$top_level_dir/hooks/scripts/pub_setup.zsh"
fi

# generate translations and glue code
dart pub global activate intl_utils 1>/dev/null
dart pub global run intl_utils:generate 1>/dev/null
flutter gen-l10n 1>/dev/null

echo "${LightGreen}Done with $scriptName${NC}"
cd "$oldDir" && exit 0 || exit 1 # return to old directory
