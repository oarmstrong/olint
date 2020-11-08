#!/bin/bash

set -euo pipefail

docker run --rm --volume="${PWD}":/check:ro mstruebing/editorconfig-checker:2.2.0
exit 0
