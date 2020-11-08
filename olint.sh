#!/bin/bash

set -euo pipefail

readonly olint_dir=/tmp/olint
readonly olint_tag=v1
readonly olint_repo=https://github.com/oarmstrong/olint.git

lint() {
	echo "Linting: $1"
	"${olint_dir}/linters/$1.sh"
	return $?
}

download_linters() {
	if [[ -d ${olint_dir} ]]; then
		pushd "${olint_dir}" >/dev/null
		git pull --quiet --force --tags origin master
		git checkout --quiet "${olint_tag}"
		echo "olint version: $(git rev-parse HEAD)"
		echo
		popd >/dev/null
	else
		git clone --branch "${olint_tag}" "${olint_repo}" "${olint_dir}"
	fi
}

#download_linters

# allow failures so we perform all lints
set +e
failed=n

# required lints
lint editorconfig || failed=y

# conditional lints
if [[ $(find . -name '*.md' -printf 'OK' -quit) == OK ]]; then lint markdown || failed=y; fi
if [[ $(find . -name '*.sh' -printf 'OK' -quit) == OK ]]; then lint shell || failed=y; fi
if [[ $(find . -name '*.tf' -printf 'OK' -quit) == OK ]]; then lint terraform || failed=y; fi
if [[ $(find . -name '*.yml' -printf 'OK' -quit) == OK ]]; then lint yaml || failed=y; fi

# if there were any failures exit 127
set -e
[[ ${failed} == y ]] && exit 127

# ensure we exit 0 if all good
exit 0
