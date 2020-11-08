#!/bin/bash

set -euo pipefail

docker run --rm --volume="${PWD}":/data:ro cytopia/yamllint:1.23 .
exit 0
