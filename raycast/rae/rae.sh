#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search in RAE
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon images/rae.png
# @raycast.argument1 { "type": "text", "placeholder": "query", "percentEncoded": true }

open "https://dle.rae.es/$1"
