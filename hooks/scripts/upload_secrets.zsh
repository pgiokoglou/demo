#!/bin/zsh

# shellcheck disable=SC2154
source "$(dirname "$0")/../script.cfg"
scriptName=$(basename "$0")

echo "${Red}Executing $scriptName${NC}"

zipName="${project_dirname//[^a-zA-Z0-9]/}.envs.zip"
zipNameAzure="${project_dirname//[^a-zA-Z0-9]/}-envs-zip-base64"

echo $zipName
echo $zipNameAzure

zip $zipName .*.env
base64 -i $zipName -o $zipName.base64

# Check if the user is logged in to Azure CLI
if ! az account show >/dev/null 2>&1; then
	echo "You are not logged in to Azure CLI. Logging in..."
	az login || { echo "Login to Azure CLI failed. Exiting." && exit 1; }
	echo "Login successful!"
else
	echo "You are already logged in to Azure CLI."
fi

az keyvault secret set --vault-name "Keys-Certificates" --name "$zipNameAzure" --file "$zipName.base64"

rm $zipName
rm $zipName.base64

echo "${LightGreen}Done with $scriptName${NC}"
