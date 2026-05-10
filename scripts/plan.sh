#!/bin/bash
set -e

cd "$(dirname "$0")/../environments/dev"

terraform plan -out=tfplan
terraform show -no-color tfplan > ../../docs/evidence/terraform-plan.txt
