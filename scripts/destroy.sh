#!/bin/bash
set -e

cd "$(dirname "$0")/../environments/dev"

terraform destroy -auto-approve | tee ../../docs/evidence/terraform-destroy.txt
