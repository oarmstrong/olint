#!/bin/bash

set -euo pipefail

docker run --rm --volume=$PWD:/data:ro wata727/tflint
