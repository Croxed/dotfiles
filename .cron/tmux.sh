#! /usr/bin/env bash

set -e

binary_dir="$HOME/bin.local"

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

tmux_install_dir="$DIR/.tmux"

install_tmux() {
    local url install_dir
    url="${1:?}"
    install_dir="${2:?}"

    build_dir="$(mktemp -d)"

    rm -rf "$install_dir" && mkdir -p "$install_dir"

    curl -fSL "$url" | tar xz --strip-components=1 -C "$build_dir"
    cd "$build_dir"
    ./configure --prefix="$install_dir"
    make && make install
    ln -sfn "$install_dir"/bin/tmux "$binary_dir"/tmux
}

prepare_tmux() {
	response="$(get_latest_release tmux tmux)"
	version="$(head -n1 <<<"$response")"
	url="$(grep -E 'tar.gz$' <<<"$response")"

    touch "$DIR/tmux.version"
    current_version="$(< "$DIR/tmux.version")"
    echo "Current version is $current_version"
    echo "New version is $version"

    if [ -z "$current_version" ]; then
        install_tmux "$url" "$tmux_install_dir"
    elif [ "$current_version" != "$version" ]; then
        install_tmux "$url" "$tmux_install_dir"
    else
        printf 'Version %s of tmux is already installed\n' "$version"
    fi
}

get_latest_release() {
	local user repo
	user="$1"
	shift
	repo="$1"
	shift
	curl -s "https://api.github.com/repos/$user/$repo/releases" |
    jq -rc ".[0] |  .name, (.assets[] | .browser_download_url)"
}


prepare_tmux
