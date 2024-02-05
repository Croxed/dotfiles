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


bob_dir="$DIR"/.bob

main() {
	local version url type
	case "$OSTYPE" in
	darwin*)
		type="macos-$(uname -p)"
		;;
	linux*)
		type="linux-x86_64"
		;;
	*)
		printf '%s is unknown\n' "$OSTYPE" >&2
		exit 1
		;;

	esac

	response="$(get_latest_release MordechaiHadad bob "$type")"
	version="$(head -n1 <<<"$response")"
	url="$(grep -E '.zip$' <<<"$response" | head -n1)"
	rm -rf "$bob_dir" || true
    mkdir -p "$bob_dir"
	cd "$bob_dir" || exit 1
  echo "$url"
	curl -fsSL "$url" -o bob.zip && unzip bob.zip && rm -rf bob.zip && chmod +x bob
	ln -sfn "$bob_dir"/bob "$HOME"/bin.local/bob

	printf 'Successfully installed bob version %s\n' "$version"
}

main
