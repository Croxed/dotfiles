#! /usr/bin/env bash

set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"


get_latest_release() {
	local user repo type
	user="$1"
	shift
	repo="$1"
	shift
	type="$1"
	shift
	curl -s "https://api.github.com/repos/$user/$repo/releases" |
    jq -rc "[.[] | select(.prerelease == false) | [.name, (.assets[] | select(.browser_download_url | contains(\"$type\")) | .browser_download_url)]][0] | .[]"
}


neovim_dir="$DIR"/.neovim

main() {
	local version url type
	case "$OSTYPE" in
	darwin*)
		type="macos"
		;;
	linux*)
		type="linux64"
		;;
	*)
		printf '%s is unknown\n' "$OSTYPE" >&2
		exit 1
		;;

	esac

	response="$(get_latest_release neovim neovim "$type")"
	version="$(head -n1 <<<"$response")"
	url="$(grep -E 'tar.gz$' <<<"$response")"
	rm -rf "$neovim_dir" && mkdir -p "$neovim_dir"
	cd "$neovim_dir" || exit 1
	curl -fsSL "$url" | tar xz --strip-components=1
	ln -sfn "$neovim_dir"/bin/nvim "$HOME"/bin.local/nvim

	printf 'Successfully installed neovim version %s\n' "$version"
}

main
