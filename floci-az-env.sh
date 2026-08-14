#!/usr/bin/env bash
# Points the Azure CLI/SDK at the Render-hosted floci-az emulator instead
# of localhost or real Azure. Uses the standard Azurite-compatible dev
# account (devstoreaccount1) that floci-az emulates, with endpoints
# rewritten from localhost:4577 to the deployed Render host.
#
# Usage:
#   source ./floci-az-env.sh

FLOCI_AZ_HOST="https://floci-az-gsnc.onrender.com"
DEV_ACCOUNT_KEY="Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw=="

export AZURE_STORAGE_CONNECTION_STRING="DefaultEndpointsProtocol=https;AccountName=devstoreaccount1;AccountKey=${DEV_ACCOUNT_KEY};BlobEndpoint=${FLOCI_AZ_HOST}/devstoreaccount1;QueueEndpoint=${FLOCI_AZ_HOST}/devstoreaccount1;TableEndpoint=${FLOCI_AZ_HOST}/devstoreaccount1;"

echo "Azure CLI/SDK now points at floci-az (Render): $FLOCI_AZ_HOST"
echo "Try: az storage container create --name my-test-container --connection-string \"\$AZURE_STORAGE_CONNECTION_STRING\""
echo "Note: Render free tier sleeps after ~15min idle - first call may take 30-60s to wake it."
