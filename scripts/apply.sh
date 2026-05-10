#!/bin/bash
set -e

cd "$(dirname "$0")/../environments/dev"

terraform apply tfplan
terraform output > ../../docs/evidence/terraform-output.txt
terraform state list > ../../docs/evidence/aws-resources.txt
