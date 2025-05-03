#!/bin/bash

# Get the directory of the current script
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

# Navigate to the root of the module
MODULE_ROOT="$(realpath "$SCRIPT_DIR/..")"

# Build project
cd "$MODULE_ROOT" || exit
yarn
yarn build

#zip -r "$MODULE_ROOT/../WhiteLabel.zip" . -x ".git/*" ".github/*" "build/*" ".husky/*" "node_modules/*" "scripts/*" ".commitlintrc.json" ".editorconfig" ".gitignore" ".versionrc.json" "postcss.config.js" "tailwind.config.js" "vite.config.js"

mkdir -p "$MODULE_ROOT/build/WhiteLabel"

# copy required files only
rsync -arh --no-links "$MODULE_ROOT/" \
  --exclude 'build' \
  --exclude '.commitlintrc.json' \
  --exclude '.editorconfig' \
  --exclude '.git' \
  --exclude '.github' \
  --exclude '.gitignore' \
  --exclude '.husky' \
  --exclude 'node_modules' \
  --exclude 'postcss.config.js' \
  --exclude '/scripts' \
  --exclude 'tailwind.config.js' \
  --exclude '.versionrc.json' \
  --exclude 'vite.config.js' \
  . "$MODULE_ROOT/build/WhiteLabel/"

(cd "$MODULE_ROOT/build" && zip -r WhiteLabel.zip WhiteLabel)
