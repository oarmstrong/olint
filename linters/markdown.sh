#!/bin/bash

set -euo pipefail

docker run --rm --volume="${PWD}":/data:ro markdownlint/markdownlint:0.11.0 .
exit 0
