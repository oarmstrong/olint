#!/bin/bash

set -euo pipefail

readonly olint_dir=/tmp/olint
readonly olint_tag=v1
readonly olint_repo=https://github.com/oarmstrong/olint.git

lint() {
	echo "Linting: $1"
	$olint_dir/linters/$1.sh
	return $?
}

if [[ -d $olint_dir ]]; then
	pushd $olint_dir >/dev/null
	git pull --quiet --force --tags origin master
	git checkout --quiet $olint_tag
	echo "olint version: $(git rev-parse HEAD)"
	echo
	popd >/dev/null
else
	git clone --branch $olint_tag $olint_repo $olint_dir
fi

# allow failures so we perform all lints
set +e
failed=n

# always lint editorconfig
lint editorconfig || failed=y

# conditional lints

if [[ $(find -name '*.tf' -printf 'OK' -quit) == OK ]]; then lint terraform || failed=y; fi
if [[ $(find -name '*.py' -printf 'OK' -quit) == OK ]]; then lint python || failed=y; fi
# etc...

set -e

echo Failed: $failed
