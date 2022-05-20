#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Angular Docs Search
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon images/angular.png
# @raycast.argument1 { "type": "text", "placeholder": "query", "percentEncoded": true }

open "https://angular.io/?search=${1}"
