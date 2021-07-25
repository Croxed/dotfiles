#! /usr/bin/env bash

main() {
	local ip_stat
	ip_stat="$(ip route get 1)"
	local ip
	ip="$(grep -Po '(?<=src )([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)' <<<"${ip_stat}")"
	if grep -Po '(?<=dev )([a-zA-Z0-9]+)' <<<"${ip_stat}" | grep -iqF en; then
		printf ' %s\n' "${ip}"
	else
		printf ' %s\n' "${ip}"
	fi
}

main
