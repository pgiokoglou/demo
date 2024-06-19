#!/bin/zsh

# shellcheck disable=SC2154
source "$(dirname "$0")/../script.cfg"
scriptName=$(basename "$0")

echo "${Red}Executing $scriptName${NC}"

zsh "$top_level_dir/dart_core/hooks/scripts/setup_git_dependencies.zsh"
flutter clean 1>/dev/null
zsh "$top_level_dir/hooks/scripts/generate_mocks_gs.zsh"
[[ $? == 1 ]] && exit 1
zsh "$top_level_dir/hooks/scripts/gen_i10n.zsh" --skip-pub
[[ $? == 1 ]] && exit 1
zsh "$top_level_dir/hooks/scripts/cleanup_arbs.zsh"
[[ $? == 1 ]] && exit 1

echo "${LightGreen}Done with $scriptName${NC}"
exit 0
