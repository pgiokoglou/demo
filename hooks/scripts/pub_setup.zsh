#!/bin/zsh

# shellcheck disable=SC2154
source "$(dirname "$0")/../script.cfg"
scriptName=$(basename "$0")

echo "${Red}Executing $scriptName${NC}"

oldDir=$(pwd) # cache old directory

#update pubs
dart pub get 1>/dev/null
dart pub upgrade 1>/dev/null

# Parse the YAML file and extract git subsections
yaml_file="$top_level_dir/pubspec.yaml"

# Find all occurrences of the git subsection
git_occurrences=($(awk '/git:/ {print NR}' "$yaml_file"))

# Iterate over all found occurrences
for line_number in "${git_occurrences[@]}"; do
  # Get the URL and REF
  url=$(awk -v line="$line_number" 'NR==line+1 {print $2}' "$yaml_file")
  ref=$(awk -v line="$line_number" 'NR==line+2 {print $2}' "$yaml_file")

  # pull pubs
  dart pub get "$url" "$ref" 1>/dev/null
  dart pub upgrade "$url" "$ref" 1>/dev/null
done

#navigate to example
exampleDir="$top_level_dir/example"

if [[ -d "$exampleDir" && -e "$exampleDir" ]]; then
  cd "$exampleDir" || exit 1

  #update pubs
  dart pub get 1>/dev/null
  dart pub upgrade 1>/dev/null
else
  echo "$exampleDir not found. Skipping..."
fi

cd "$oldDir" && exit 0 || exit 1 # return to old directory

echo "${LightGreen}Done with $scriptName${NC}"
exit 0
