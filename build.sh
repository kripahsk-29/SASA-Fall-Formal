#!/bin/bash
# Run this after adding/removing images, then push to GitHub
# Usage: ./build.sh

cd "$(dirname "$0")"

echo "const imageFiles = [" > images.js

for f in images/*.jpeg images/*.jpg images/*.png images/*.webp images/*.JPEG images/*.JPG images/*.PNG; do
  [ -f "$f" ] || continue
  name=$(basename "$f")
  # escape quotes and backslashes for JS
  escaped=$(echo "$name" | sed 's/\\/\\\\/g; s/"/\\"/g')
  echo "  \"$escaped\"," >> images.js
done

echo "];" >> images.js

count=$(grep -c '^\s*"' images.js)
echo "✓ Found $count images → images.js updated"
echo "Now run: git add . && git commit -m 'update images' && git push"
