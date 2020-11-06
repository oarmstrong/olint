#!/bin/bash

set -euo pipefail

set +e
failed=n
docker run --rm --volume=$PWD:/data:ro wata727/tflint:latest || failed=y
docker run --rm --volume=$PWD:/data:ro hashicorp/terraform:0.13.5 fmt -check -diff -recursive /data || failed=y
set -e

[[ $failed == n ]] && exit 127

exit 0
