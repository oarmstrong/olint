#!/bin/bash

set -euo pipefail

set +e
failed=n
docker run --rm --volume="${PWD}":/data:ro cytopia/yamllint:1.23 . || failed=y
if [[ $(find . -name '*.yaml' -printf 'OK' -quit) == OK ]]; then echo 'Use .yml instead of .yaml' || failed=y; fi

set -e
[[ ${failed} != n ]] && exit 127

exit 0
