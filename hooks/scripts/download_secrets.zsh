#!/bin/zsh

# shellcheck disable=SC2154
source "$(dirname "$0")/../script.cfg"
scriptName=$(basename "$0")

echo "${Red}Executing $scriptName${NC}"

zipName="${project_dirname//[^a-zA-Z0-9]/}.envs.zip"
zipNameAzure="${project_dirname//[^a-zA-Z0-9]/}-envs-zip-base64"

az login

az keyvault secret download --vault-name "Keys-Certificates" --name "$zipNameAzure" --file "$zipName.base64"
base64 --decode <$zipName.base64 >$zipName
unzip -oq $zipName

rm $zipName
rm $zipName.base64

echo "${LightGreen}Done with $scriptName${NC}"
