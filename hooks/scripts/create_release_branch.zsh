#!/bin/zsh

# shellcheck disable=SC2154
source "$(dirname "$0")/../script.cfg"
scriptName=$(basename "$0")

echo "${Red}Executing $scriptName${NC}"

if [[ $# -eq 0 ]]; then
  echo "No new version provided. Use -h or --help for help."
  echo "${LightGreen}Done with $scriptName${NC}"
  exit 1
fi

source_branch=develop

for arg in "$@"; do
  if [[ $arg = "-h" ]] || [[ $arg = "--help" ]]; then
    echo "Usage: $scriptName --version=<value> [options]"
    echo ""
    echo "Mandatory:"
    echo "  --version=<version>             The version of the release branch. The format is \"x.y.z\", where x, y, z are all digits"
    echo ""
    echo "Optional:"
    echo "  -h, --help                      Show this help message and exit"
    echo "  --source_branch=<branch>        Specify the source branch (default: $source_branch)"
    exit 0
  elif [[ $arg =~ --version="(.*)" ]]; then
    version="${match[1]}"
  elif [[ $arg =~ --source_branch="(.*)" ]]; then
    source_branch="${match[1]}"
  fi
done

if [[ ! $version =~ ^([0-9]+\.){2}[0-9]+$ ]]; then
  echo "${Red}--version expected in the form of \"x.y.z\", where x, y, z are all digits. Exiting...${NC}"
  exit 1
fi

echo "Source branch: $source_branch"
echo "Version: $version"

# Ask for confirmation
# shellcheck disable=SC2162
read -q -s "response?Are you sure you want to proceed? (y/n)"

# Check the user's response
if [[ $response == "y" || $response == "Y" ]]; then
  echo ""
  echo "Confirmed. Proceeding..."
else
  echo ""
  echo "Cancelled. Exiting..."
  exit 0
fi

oldDir=$(pwd) # cache old directory

cd "$top_level_dir" || exit 1 # navigate to project level

function pullTarget() {
  git switch "$source_branch"
  git pull origin "$source_branch"
  git fetch --all
  git prune
}
pullTarget

version_segments=(${(s:.:)version})

new_branch="release/${version_segments[1]}/${version_segments[2]}/$version"

git switch -c "$new_branch"

function updateVersion() {
  local pubFile
  pubFile="$top_level_dir/pubspec.yaml"

  sed -i "" -E "s/version: .*/version: $1/" "$pubFile" #replace version inline

  git add "$pubFile"
  git commit -m "Version v$1"
}
updateVersion "$version"

git push -u origin "$new_branch"

git switch "$source_branch"

echo "${LightGreen}Done with $scriptName${NC}"
cd "$oldDir" && exit 0 || exit 1 # return to old directory
