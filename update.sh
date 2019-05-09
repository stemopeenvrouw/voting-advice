#!/bin/sh
if [ $# -lt 2 ]; then
	>&2 echo "Usage:"
	>&2 echo "import.sh SHEETID APIKEU"
	>&2 echo ""
	>&2 echo "SHEETID which is a Google Sheet ID, if you see a link like"
	>&2 echo "https://docs.google.com/spreadsheets/d/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/"
	>&2 echo "The XXX part is your Google Sheet ID, make sure this sheet is public viewable/"
	>&2 echo ""
	>&2 echo "APIKEY is a Google API key which is enabled for Sheets."
	exit 1;
fi;
SHEETID="$1"
APIKEY="$2"
BASEDIR="$(realpath $(dirname "$0"))"
cd "$BASEDIR"

curl -sSfA 'Mozilla/5.0 (compatible; VotingAdviseBot/1.0; +https://github.com/stemopeenvrouw/voting-advice)' -o 'api-response.json' --compressed "https://sheets.googleapis.com/v4/spreadsheets/$SHEETID?fields=properties.title,sheets(properties.title,data.rowData.values(userEnteredValue))&key=$APIKEY" 2>&1
if [ $? -ne 0 ]; then
	>&2 echo "Error fetching Google Sheet: $? $ERR"
	exit 1;
fi;

ERR=$(jq -f google-sheet-to-model.jq api-response.json > stemopeenvrouw.json)
if [ $? -ne 0 ]; then
	>&2 echo "Error parsing Google Sheet API response: $ERR"
	exit 1;
fi;

ERR=$(yarn)
if [ $? -ne 0 ]; then
	>&2 echo "Error during yarn install: $ERR"
	exit 1;
fi;

ERR=$(yarn build)
if [ $? -ne 0 ]; then
	>&2 echo "Error building: $ERR"
	exit 1;
fi;
