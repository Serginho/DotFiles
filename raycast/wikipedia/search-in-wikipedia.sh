#!/bin/bash

# Required parameters:
# @raycast.author Jax0rz
# @authorURL https://github.com/Jax0rz
# @raycast.schemaVersion 1
# @raycast.title Wikipedia search
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon images/wikipedia.png
# @raycast.argument1 { "type": "text", "placeholder": "Search term...", "percentEncoded": true }

domain="es"

open "https://$domain.wikipedia.org/w/index.php?search=$1"
