#!/usr/bin/env zsh

set -euo pipefail

REPO="michel-kraemer/zsh-patina"
INSTALL_DIR="${ZSH_PATINA_INSTALL_DIR:-$HOME/.local/bin}"

die() {
  print -u2 -- "zsh-patina installer: $*"
  return 1
}

info() {
  print -- "==> $*"
}

command -v curl >/dev/null ||
  die "curl is required"

command -v tar >/dev/null ||
  die "tar is required"


# ---------------------------------------------------------------------------
# Detect OS
# ---------------------------------------------------------------------------

case "$(uname -s)" in
  Darwin)
    os="apple-darwin"
    ;;

  Linux)
    os="unknown-linux-gnu"
    ;;

  *)
    die "Unsupported operating system: $(uname -s)"
    ;;
esac


# ---------------------------------------------------------------------------
# Detect architecture
# ---------------------------------------------------------------------------

arch="$(uname -m)"

case "$arch" in
  arm64|aarch64)
    arch="aarch64"
    ;;

  x86_64|amd64)
    arch="x86_64"
    ;;

  i386|i486|i586|i686)
    arch="i686"
    ;;

  armv7l|armv7)
    arch="arm"
    ;;

  *)
    die "Unsupported architecture: $arch"
    ;;
esac


# ---------------------------------------------------------------------------
# Validate supported combinations / target triple
# ---------------------------------------------------------------------------

case "$os:$arch" in
  apple-darwin:aarch64)
    target="aarch64-apple-darwin"
    ;;

  apple-darwin:x86_64)
    target="x86_64-apple-darwin"
    ;;

  unknown-linux-gnu:aarch64)
    target="aarch64-unknown-linux-gnu"
    ;;

  unknown-linux-gnu:x86_64)
    target="x86_64-unknown-linux-gnu"
    ;;

  unknown-linux-gnu:i686)
    target="i686-unknown-linux-gnu"
    ;;

  unknown-linux-gnu:arm)
    target="arm-unknown-linux-gnueabihf"
    ;;

  *)
    die "No zsh-patina binary mapping for $arch on $os"
    ;;
esac


# ---------------------------------------------------------------------------
# Resolve latest GitHub release
#
# GitHub redirects /releases/latest to /releases/tag/<version>.
# This avoids needing jq or parsing the GitHub API JSON.
# ---------------------------------------------------------------------------

latest_url="$(
  curl \
    -fsSL \
    -o /dev/null \
    -w '%{url_effective}' \
    "https://github.com/${REPO}/releases/latest"
)"

version="${latest_url##*/}"

[[ -n "$version" ]] ||
  die "Unable to determine latest release"

if (( $+commands[zsh-patina] )); then
	existing_version="$(zsh-patina -V | awk '{print $2}')"

	if [[ "$version" == "$existing_version" ]]; then
		printf 'Latest version of zsh-patina is already installed\n'
		exit 0
	fi
fi
# ---------------------------------------------------------------------------
# Build release URL
# ---------------------------------------------------------------------------

archive="zsh-patina-v${version}-${target}.tar.gz"

url="https://github.com/${REPO}/releases/download/${version}/${archive}"


# ---------------------------------------------------------------------------
# Temporary directory
# ---------------------------------------------------------------------------

tmpdir="$(mktemp -d)"

cleanup() {
  rm -rf -- "$tmpdir"
}

trap cleanup EXIT INT TERM


# ---------------------------------------------------------------------------
# Download
# ---------------------------------------------------------------------------

curl \
  --fail \
  --location \
  --show-error \
  --silent \
  "$url" \
  -o "$tmpdir/$archive"


# ---------------------------------------------------------------------------
# Extract
# ---------------------------------------------------------------------------

mkdir -p "$tmpdir/extracted"

tar \
  -xzf "$tmpdir/$archive" \
  -C "$tmpdir/extracted"


# The release archive contains a top-level directory.
binary="$(
  find "$tmpdir/extracted" \
    -type f \
    -name zsh-patina \
    -perm -u+x \
    -print \
    -quit
)"

[[ -n "$binary" ]] ||
  die "zsh-patina executable not found in archive"


# ---------------------------------------------------------------------------
# Install
# ---------------------------------------------------------------------------

mkdir -p "$INSTALL_DIR"

cp "$binary" "$INSTALL_DIR/zsh-patina"
chmod 755 "$INSTALL_DIR/zsh-patina"