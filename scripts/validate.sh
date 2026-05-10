#!/bin/bash
set -e

cd "$(dirname "$0")/../environments/dev"

terraform fmt -recursive ../..
terraform init
terraform validate
