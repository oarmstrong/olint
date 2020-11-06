#!/bin/bash

set -euo pipefail

docker run --rm -v $(pwd):/data:ro ls -al /data alpine:latest 
