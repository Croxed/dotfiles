#! /usr/bin/env bash

get_latest_release() {
    local user repo type
    user="$1"; shift
    repo="$1"; shift
    type="$1"; shift
    curl -s "https://api.github.com/repos/$user/$repo/releases" |
    jq -rc ".[0] | .name, (.assets[] | select(.browser_download_url | contains(\"$type\")) | .browser_download_url)"
}