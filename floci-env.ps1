# Points the AWS CLI/SDK at the Render-hosted floci-aws emulator instead
# of localhost or real AWS. Mirrors floci's own `eval $(floci env)`, but
# targets a remote deployment.
#
# Usage:
#   . .\floci-env.ps1
# (dot-source it so the env vars persist in your current shell session)

$env:AWS_ENDPOINT_URL = "https://floci-aws-gsnc.onrender.com"
$env:AWS_ACCESS_KEY_ID = "test"
$env:AWS_SECRET_ACCESS_KEY = "test"
$env:AWS_DEFAULT_REGION = "us-east-1"

Write-Host "AWS CLI now points at floci-aws (Render): $env:AWS_ENDPOINT_URL"
Write-Host "Try: aws s3 mb s3://my-test-bucket"
Write-Host "Note: Render free tier sleeps after ~15min idle - first call may take 30-60s to wake it."
