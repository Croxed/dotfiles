#! /usr/bin/env bash

if ! command -v curl &>/dev/null; then
  printf 'curl is required in order to run this script\n'
  exit 1
fi

killall java
rm -rf "$HOME/pycharm"
mkdir -p "$HOME/pycharm"

curl -fSL "https://download.jetbrains.com/product?code=PC&latest&distribution=linux" | tar xvz -C "$HOME/pycharm" --strip-components=1
