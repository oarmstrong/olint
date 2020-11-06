#!/bin/bash

set -euo pipefail

readonly olint_dir=/tmp/olint
readonly olint_tag=v1
readonly olint_repo=https://github.com/oarmstrong/olint.git

if [[ -d $olint_dir ]]; then
	pushd $olint_dir >/dev/null
	git pull --quiet --force --tags origin master
	git checkout --quiet $olint_tag
	echo "Running linters: $(git rev-parse HEAD)"
	popd >/dev/null
else
	git clone --branch $olint_tag $olint_repo $olint_dir
fi

[[ ! -f .olintrc ]] && echo 'No olintrc found' && exit 1

while read -r language; do
	echo
	echo Linting: $language
	$olint_dir/linters/$language.sh
done <.olintrc
