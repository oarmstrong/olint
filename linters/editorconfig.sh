#!/bin/bash

set -euo pipefail

docker run --rm alpine:latest -v $(pwd):/data:ro ls -al /data
