#!/bin/bash

if [ "$#" -ne 10 ]; then
    echo "Usage: $0 <project_name> <repo_url> <replacement_string1> <replacement_string2> <replacement_string3> <replacement_string4> <replacement_string5> <replacement_string6> <replacement_string7> <replacement_deployer>"
    exit 1
fi

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR/projects"

echo "Replaceing tokens."

# Assign command-line arguments to variables
PROJECT_NAME="$1"
REPO_URL="$2"
REPLACEMENT_DEPLOYER=${10}
REPLACEMENT_STRING1="$3"
REPLACEMENT_STRING2="$4"
REPLACEMENT_STRING3="$5"
REPLACEMENT_STRING4="$6"
REPLACEMENT_STRING5="$7"
REPLACEMENT_STRING6="$8"
REPLACEMENT_STRING7=$(printf '%s\n' "$9" | sed -e 's/[\&/]/\\&/g')

TARGET_STRING1="{{core-team1}}"
TARGET_STRING2="{{core-team2}}"
TARGET_STRING3="{{core-team3}}"
TARGET_STRING4="{{core-team4}}"
TARGET_STRING5="{{token_name}}"
TARGET_STRING6="{{symbol}}"
TARGET_STRING7="{{token_uri}}"

# Change directory to the cloned repository
echo "Cleaning projects."
rm -rf $PROJECT_NAME
mkdir $PROJECT_NAME
cd $PROJECT_NAME

# Clone the GitHub repository
echo "Fetching DAO code."
git clone $REPO_URL
cd bitcoin-dao
#git checkout 14-one-click-dao-deployer

# Find files containing the target string and replace it with each replacement string
#find . -type f -exec sed -i "s/$TARGET_STRING1/$REPLACEMENT_STRING1/g" {} +
cd "$SCRIPT_DIR/projects/$PROJECT_NAME/bitcoin-dao/contracts/proposals/deployer"
sed -i -e "s/$TARGET_STRING1/$REPLACEMENT_STRING1/g" bdp000-bootstrap.clar
sed -i -e "s/$TARGET_STRING2/$REPLACEMENT_STRING2/g" bdp000-bootstrap.clar
sed -i -e "s/$TARGET_STRING3/$REPLACEMENT_STRING3/g" bdp000-bootstrap.clar
sed -i -e "s/$TARGET_STRING4/$REPLACEMENT_STRING4/g" bdp000-bootstrap.clar
cd "$SCRIPT_DIR/projects/$PROJECT_NAME/bitcoin-dao/contracts/extensions"
sed -i -e "s/$TARGET_STRING5/$REPLACEMENT_STRING5/g" bde000-governance-token.clar
sed -i -e "s/$TARGET_STRING6/$REPLACEMENT_STRING6/g" bde000-governance-token.clar
sed -i -e "s/$TARGET_STRING7/$REPLACEMENT_STRING7/g" bde000-governance-token.clar

#echo " "
#echo "---------------------------------------------------------------------------------------"
#echo " bde000-governance-token.clar"
#cat "$SCRIPT_DIR/projects/$PROJECT_NAME/bitcoin-dao/contracts/extensions/bde000-governance-token.clar"
#echo " "
#echo "---------------------------------------------------------------------------------------"
#echo " bdp000-bootstrap.clar"
#cat "$SCRIPT_DIR/projects/$PROJECT_NAME/bitcoin-dao/contracts/proposals/deployer/bdp000-bootstrap.clar"
# Optionally, commit the changes
#git add .
#git commit -m "Replace $TARGET_STRING with $REPLACEMENT_STRING1, $REPLACEMENT_STRING2, $REPLACEMENT_STRING3, $REPLACEMENT_STRING4, $REPLACEMENT_STRING5"
#git push origin master

echo " "
echo "---------------------------------------------------------------------------------------"
echo " "
echo $REPLACEMENT_DEPLOYER

cd $SCRIPT_DIR/projects/$PROJECT_NAME/bitcoin-dao
ls -lt deployments
rm deployments/default.devnet-plan.yaml
clarinet deployments generate --devnet < $SCRIPT_DIR/input_file
cd $SCRIPT_DIR/projects/$PROJECT_NAME/bitcoin-dao/deployments
sed -i -e "s/$REPLACEMENT_STRING1/$REPLACEMENT_DEPLOYER/g" default.devnet-plan.yaml
rm default.devnet-plan.yaml-e
ls -lt
cp default.devnet-plan.yaml project.devnet-plan.yaml
cd $SCRIPT_DIR/projects/$PROJECT_NAME/bitcoin-dao
clarinet deployments apply --no-dashboard -p deployments/project.devnet-plan.yaml < $SCRIPT_DIR/input_file

echo "String replacement completed."