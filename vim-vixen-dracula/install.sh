#!/usr/bin/env bash

set -e

if [[ "$FIREFOX_PROFILE" == "" ]]; then
  echo "usage: FIREFOX_PROFILE=<profile> install.sh"
  echo
  echo "firefox profiles:"
  ls ~/.mozilla/firefox | grep -v "^\(Pending Pings\|Crash Reports\|profiles.ini\)$"
  exit 1
fi

PROFILE_DIR="$HOME/.mozilla/firefox/$FIREFOX_PROFILE"
CHROME_DIR="$PROFILE_DIR/chrome"

USER_CONTENT_PATH="$CHROME_DIR/userContent.css"
USER_CONTENT_NAMESPACE="@namespace html url(http://www.w3.org/1999/xhtml);"

BUILD_FILE="./build/index.css"

STYLE_START="VIM VIXEN STYLE START"
STYLE_END="VIM VIXEN STYLE END"
STYLE_START_SED="^\/\* $STYLE_START \*\/$"
STYLE_END_SED="^\/\* $STYLE_END \*\/$"

FONT_IMPORT="@import url(\"https://fonts.googleapis.com/css?family=Inconsolata\");"
FONT_GREP="^$FONT_IMPORT$"

if [[ ! -w "$PROFILE_DIR" ]]; then
  echo "$PROFILE_DIR is not writable"
  exit 1
fi

if [[ -d "$CHROME_DIR" && ! -w "$CHROME_DIR" ]]; then
  echo "$CHROME_DIR exists but is not writable"
  exit 1
fi

if [[ -f "$USER_CONTENT_PATH" && ! -w "$USER_CONTENT_PATH" ]]; then
  echo "$USER_CONTENT_PATH exists but is not writable"
  exit 1
fi

npm run build

if [[ ! -f "$BUILD_FILE" ]]; then
  echo "$BUILD_FILE not found"
  exit 1
fi

mkdir -p "$CHROME_DIR"

if [[ ! -f "$USER_CONTENT_PATH" ]]; then
  echo "making file $USER_CONTENT_PATH"
  touch "$USER_CONTENT_PATH"
fi

if ! grep -q "^/\* $STYLE_START \*/$" "$USER_CONTENT_PATH"; then
  echo "adding vim-vixen markers to $USER_CONTENT_PATH"
  echo "$USER_CONTENT_NAMESPACE" >> "$USER_CONTENT_PATH"
  echo "/* $STYLE_START */" >> "$USER_CONTENT_PATH"
  echo "/* $STYLE_END */" >> "$USER_CONTENT_PATH"
fi

echo "adding $BUILD_FILE to $USER_CONTENT_PATH"
sed -i -e "/$STYLE_START_SED/,/$STYLE_END_SED/{ /$STYLE_START_SED/{p; r $BUILD_FILE
  }; /$STYLE_END_SED/p; d }" "$USER_CONTENT_PATH"
echo "restart firefox to see the changes take effect"
