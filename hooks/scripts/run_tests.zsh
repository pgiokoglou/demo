#!/bin/zsh

# shellcheck disable=SC2154
source "$(dirname "$0")/../script.cfg"
scriptName=$(basename "$0")

echo "${Red}Executing $scriptName${NC}"

has_missing_import=0

function checkForMissingTestImports() {
  local parent_dir=$1
  local tests_container_dir=$2

  echo "Checking\t$parent_dir/$tests_container_dir\t\tfor missing imports"

  local test_files=($(find "$top_level_dir" -type f -name "*_test.dart" | sed 's/'top_level_dir'//g' | grep "test/$tests_container_dir" | sort))

  for file in "${test_files[@]}"; do
    local filepath="${file#$top_level_dir/test/}"
    local result=$(grep -c "$filepath" <"$top_level_dir/test/$parent_dir.dart")

    if [ "$result" -eq 0 ]; then
      has_missing_import=1
      local file_name=$(echo "$filepath" | rev | cut -f2 -d'.' | cut -f1 -d'/' | rev)

      printf "Add\n\t${Red}import \"%s\" as %s;\n\n\tgroup(\"%s\", %s.main);${NC}\nin %s\n" "$filepath" "$file_name" "$file_name" "$file_name" "$parent_dir.dart"
    fi
  done

  return $has_missing_import
}

function checkTestSuiteConsistency() {
  local parent_dirs=("unit_testing" "widget_testing" "integration_testing")

  for parent_dir in "${parent_dirs[@]}"; do

    dirs=($(ls -d $top_level_dir/test/$parent_dir/*/ | rev | cut -f2 -d'/' | rev))

    for dir in "${dirs[@]}"; do
      checkForMissingTestImports "$parent_dir" "$dir"
    done
  done

  if [ "$has_missing_import" -eq 1 ]; then
    echo "Please add the above files and re-run the tests"
    return 1 #failure
  fi

  return 0 #OK
}

if ! checkTestSuiteConsistency; then
  echo "${Red}Error in $scriptName${NC}"
  exit 1
fi

result=$(flutter test "$top_level_dir/test/main_test.dart") 1>/dev/null

echo "$result"

if [[ $result =~ 'Some tests failed' ]]; then
  echo "${Red}Error in $scriptName${NC}"
  exit 1
else
  echo "${LightGreen}Done with $scriptName${NC}"
  exit 0
fi
