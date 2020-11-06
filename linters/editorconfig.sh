#!/bin/bash

set -euo pipefail

echo 'editorconfig'
docker run --rm --volume=$PWD:/check:ro mstruebing/editorconfig-checker
