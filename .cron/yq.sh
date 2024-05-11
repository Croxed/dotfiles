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
    jq -rc "[.[] | select(.prerelease == false) | [.name, (.assets[] | select(.browser_download_url | endswith(\"$type\")) | .browser_download_url)]][0] | .[]"
}


yq_dir="$DIR"/.yq

main() {
	local version url type
	case "$OSTYPE" in
	darwin*)
		type="darwin_$(uname -p)64"
		;;
	linux*)
		type="linux_amd64"
		;;
	*)
		printf '%s is unknown\n' "$OSTYPE" >&2
		exit 1
		;;

	esac

	response="$(get_latest_release mikefarah yq "$type")"
	version="$(head -n1 <<<"$response")"
	url="$(tail -n1 <<<"$response")"
	rm -rf "$yq_dir" || true
    mkdir -p "$yq_dir"
	cd "$yq_dir" || exit 1
    echo "$url"
	curl -fsSL "$url" -o yq && chmod +x yq
	ln -sfn "$yq_dir"/yq "$HOME"/bin.local/yq

	printf 'Successfully installed yq version %s\n' "$version"
}

main
