#!/bin/bash

set -euo pipefail

docker run --rm -v $(pwd):/data:ro alpine:latest ls -al /data
