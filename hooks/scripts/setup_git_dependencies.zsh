#!/bin/zsh

# shellcheck disable=SC2154
source "$(dirname "$0")/../script.cfg"
scriptName=$(basename "$0")

# Create symbolic links for VS Code configuration files
rm "$top_level_dir/.vscode/dart.code-snippets" &>/dev/null
ln -s "$top_level_dir/dart_core/.vscode/dart.code-snippets" "$top_level_dir/.vscode" &>/dev/null
rm "$top_level_dir/.vscode/extensions.json" &>/dev/null
ln -s "$top_level_dir/dart_core/.vscode/extensions.json" "$top_level_dir/.vscode" &>/dev/null
rm "$top_level_dir/.vscode/settings.json" &>/dev/null
ln -s "$top_level_dir/dart_core/.vscode/settings.json" "$top_level_dir/.vscode" &>/dev/null

# Create a symbolic link for analysis_options.yaml
rm "$top_level_dir/analysis_options.yaml" &>/dev/null
ln -s "$top_level_dir/dart_core/analysis_options.yaml" "$top_level_dir" &>/dev/null

# Create a symbolic link for the 'hooks' directory
rm "$top_level_dir/hooks" &>/dev/null
ln -s "$top_level_dir/dart_core/hooks" "$top_level_dir/hooks" &>/dev/null

exampleDir="$top_level_dir/example"

# Check if the example directory exists
if [[ -d "$exampleDir" && -e "$exampleDir" ]]; then
	# Create symbolic links for VS Code configuration files in the example directory
	rm "$exampleDir/.vscode/dart.code-snippets" &>/dev/null
	ln -s "$top_level_dir/dart_core/.vscode/dart.code-snippets" "$exampleDir/.vscode" &>/dev/null
	rm "$exampleDir/.vscode/extensions.json" &>/dev/null
	ln -s "$top_level_dir/dart_core/.vscode/extensions.json" "$exampleDir/.vscode" &>/dev/null
	rm "$exampleDir/.vscode/settings.json" &>/dev/null
	ln -s "$top_level_dir/dart_core/.vscode/settings.json" "$exampleDir/.vscode" &>/dev/null

	# Create a symbolic link for analysis_options.yaml in the example directory
	rm "$exampleDir/analysis_options.yaml" &>/dev/null
	ln -s "$top_level_dir/dart_core/analysis_options.yaml" "$exampleDir" &>/dev/null
else
	echo "$exampleDir not found. Skipping..."
fi

echo "Done with $scriptName"
exit 0
