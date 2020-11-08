#!/bin/bash

set -euo pipefail

docker run --rm --volume="${PWD}":/mnt:ro koalaman/shellcheck:v0.7.1 \
	--check-sourced \
	--enable=all \
	./*.sh \
	./**/*.sh
exit 0
