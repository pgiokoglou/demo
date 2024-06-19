#!/bin/zsh

# shellcheck disable=SC2154
source "$(dirname "$0")/../script.cfg"
scriptName=$(basename "$0")

echo "${Red}Executing $scriptName${NC}"

oldDir=$(pwd) # cache old directory

cd "$top_level_dir" || exit 1 # navigate to project level

dart pub global activate arb_utils 0.2.0 &>/dev/null

function sortArbKeys() {
  local arb_files=("$top_level_dir"/lib/l10n/intl_*.arb)

  for arb in "${arb_files[@]}"; do
    dart pub global run arb_utils:sort "$arb" 1>/dev/null
  done
}

# Call the function
sortArbKeys

function searchForMissingKeys() {
  local missingTranslationsFile="$top_level_dir/lib/l10n/missing_translation_keys.txt"

  rm -f "$missingTranslationsFile"

  flutter gen-l10n 1>/dev/null

  if [ -f "$missingTranslationsFile" ] && ! grep -x "{}" "$missingTranslationsFile" 1>/dev/null; then
    echo "${Red}Missing translation keys detected...${NC}"
    cat "$missingTranslationsFile"
    return 1
  fi
}

if ! searchForMissingKeys; then
  echo "${Red}Error in $scriptName${NC}"
  exit 1
fi

function searchForEmptyDescriptions() {
  local enArb="$top_level_dir/lib/l10n/intl_en.arb"

  dart pub global run arb_utils:generate_meta "$enArb" 1>/dev/null
  dart pub global run arb_utils:sort "$enArb" 1>/dev/null

  sed -i "" -E 's/("@.*"): {}/\1: {\n    "description": ""\n  }/' "$enArb"

  if grep -q '"description": ""' "$enArb"; then
    echo "${Red}Missing descriptions detected in $enArb${NC}"
    grep -n -B 2 --color=always '"description": ""' "$enArb"
    return 1
  fi
}
if ! searchForEmptyDescriptions; then
  echo "${Red}Error in $scriptName${NC}"
  exit 1
fi

echo "${LightGreen}Done with $scriptName${NC}"
cd "$oldDir" && exit 0 || exit 1 # return to old directory
