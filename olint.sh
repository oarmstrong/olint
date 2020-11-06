#!/bin/bash

set -euo pipefail

OLINT_DRYRUN="${OLINT_DRYRUN:-n}"

readonly olint_dir=/tmp/olint
readonly olint_tag=v1
readonly olint_repo=https://github.com/oarmstrong/olint.git

lints=

generate() {
	cat >.github/workflows/lint.yml <<EOF
on: [push]
jobs:
EOF
	for lint in $lints; do
		cat >>.github/workflows/lint.yml <<EOF
  lint-$lint:
    runs-on: ubuntu-latest
    name: Lint $lint files.
    steps:
    - uses: actions/checkout@v2
    - uses: oarmstrong/olint@v1
      with:
        lang: $lint
EOF
	done
}

lint() {
	if [[ $OLINT_DRYRUN != n ]]; then
		lints="$lints $1"
	else
		echo "Linting: $1"
		$olint_dir/linters/$1.sh
		return $?
	fi
}

download_linters() {
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
}

generate=n
if [[ $# -ge 1 ]] && [[ $1 == generate ]]; then
	OLINT_DRYRUN=Y
	generate=y
else
	download_linters
fi

# allow failures so we perform all lints
set +e
failed=n

# required lints
lint editorconfig || failed=y

# conditional lints
if [[ $(find -name '*.tf' -printf 'OK' -quit) == OK ]]; then lint terraform || failed=y; fi

# if there were any failures exit 127
set -e
[[ $failed == y ]] && exit 127

[[ $generate == y ]] && generate

# ensure we exit 0 if all good
exit 0
