#! /usr/bin/env bash

set -e

binary_dir="$HOME/bin.local"

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

zellij_install_dir="$DIR/.zellij"

get_latest_release() {
	local user repo type
	user="$1"
	shift
	repo="$1"
	shift
	type="$1"
	shift
	curl -s "https://api.github.com/repos/$user/$repo/releases" |
    jq -rc ".[] | .name, (.assets[] | select(.browser_download_url | contains(\"$type\")) | .browser_download_url)"
}

main() {
	local version url type
	case "$OSTYPE" in
	darwin*)
		type="aarch64-apple-darwin"
		;;
	linux*)
		type="x86_64-unknown-linux-musl"
		;;
	*)
		printf '%s is unknown\n' "$OSTYPE" >&2
		exit 1
		;;

	esac

    response="$(get_latest_release zellij-org zellij "$type")"
	version="$(head -n1 <<<"$response")"
	url="$(grep -E 'tar.gz$' <<<"$response" | head -n1)"

    echo "$version"
    curl -fSsL "$url" -o zellij.tar.gz
    rm -rf "$zellij_install_dir" || true
    mkdir -p "$zellij_install_dir"
    tar -xvf zellij.tar.gz -C "$zellij_install_dir"
    chmod +x "$zellij_install_dir"/zellij
    ln -sfn "$zellij_install_dir"/zellij "$binary_dir"/zellij
}


main