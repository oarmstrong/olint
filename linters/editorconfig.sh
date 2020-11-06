#!/bin/bash

set -euo pipefail

docker run --rm --volume=$PWD:/check mstruebing/editorconfig-checker
