#!/bin/bash

set -euo pipefail

set +e
failed=n
docker run --rm --volume="${PWD}":/data:ro wata727/tflint:0.20.3 \
	--module \
	--deep \
	--enable-rule terraform_deprecated_interpolation \
	--enable-rule terraform_deprecated_index \
	--enable-rule terraform_unused_declarations \
	--enable-rule terraform_comment_syntax \
	--enable-rule terraform_documented_outputs \
	--enable-rule terraform_documented_variables \
	--enable-rule terraform_typed_variables \
	--enable-rule terraform_module_pinned_source \
	--enable-rule terraform_naming_convention \
	--enable-rule terraform_required_version \
	--enable-rule terraform_required_providers \
	--enable-rule terraform_standard_module_structure \
	--enable-rule terraform_workspace_remote \
       	|| failed=y
docker run --rm --volume="${PWD}":/data:ro hashicorp/terraform:0.13.5 fmt \
	-check \
       	-diff \
       	-recursive \
       	/data \
       	|| failed=y
# ab92377 = v1.1.0
docker run --rm --volume="${PWD}":/data:ro accurics/terrascan:ab92377 scan \
       	--iac-dir /data  \
	--iac-type terraform \
       	--iac-version v12 \
       	--policy-type aws \
       	|| failed=y 
set -e

[[ ${failed} != n ]] && exit 127

exit 0

