#!/bin/bash

set -euo pipefail

docker run --rm -v $(pwd):/data:ro /data alpine:latest ls -al /data
