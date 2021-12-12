#! /usr/bin/env bash

if ! command -v curl &>/dev/null; then
  printf 'curl is required in order to run this script\n'
  exit 1
fi

killall java
rm -rf "$HOME/intellij"
mkdir -p "$HOME/intellij"

curl -fSL "https://download.jetbrains.com/product?code=IU&latest&distribution=linux" | tar xvz -C "$HOME/intellij" --strip-components=1
