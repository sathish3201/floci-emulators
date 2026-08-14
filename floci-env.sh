#!/usr/bin/env bash
# Points the AWS CLI/SDK at the Render-hosted floci-aws emulator instead
# of localhost or real AWS. Mirrors floci's own `eval $(floci env)`, but
# targets a remote deployment.
#
# Usage:
#   source ./floci-env.sh
# (source it, don't execute it, so the env vars persist in your shell)

export AWS_ENDPOINT_URL="https://floci-aws-gsnc.onrender.com"
export AWS_ACCESS_KEY_ID="test"
export AWS_SECRET_ACCESS_KEY="test"
export AWS_DEFAULT_REGION="us-east-1"

echo "AWS CLI now points at floci-aws (Render): $AWS_ENDPOINT_URL"
echo "Try: aws s3 mb s3://my-test-bucket"
echo "Note: Render free tier sleeps after ~15min idle - first call may take 30-60s to wake it."
