#! /usr/bin/env bash

if ! command -v curl &>/dev/null; then
  printf 'curl is required in order to run this script\n'
  exit 1
fi

killall java
rm -rf "$HOME/goland"
mkdir -p "$HOME/goland"

curl -fSL "https://download.jetbrains.com/product?code=GO&latest&distribution=linux" | tar xvz -C "$HOME/goland" --strip-components=1
