# Points the Azure CLI/SDK at the Render-hosted floci-az emulator instead
# of localhost or real Azure. Uses the standard Azurite-compatible dev
# account (devstoreaccount1) that floci-az emulates, with endpoints
# rewritten from localhost:4577 to the deployed Render host.
#
# Usage:
#   . .\floci-az-env.ps1

$flociAzHost = "https://floci-az-gsnc.onrender.com"
$devAccountKey = "Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw=="

$env:AZURE_STORAGE_CONNECTION_STRING = "DefaultEndpointsProtocol=https;AccountName=devstoreaccount1;AccountKey=$devAccountKey;BlobEndpoint=$flociAzHost/devstoreaccount1;QueueEndpoint=$flociAzHost/devstoreaccount1;TableEndpoint=$flociAzHost/devstoreaccount1;"

Write-Host "Azure CLI/SDK now points at floci-az (Render): $flociAzHost"
Write-Host 'Try: az storage container create --name my-test-container --connection-string $env:AZURE_STORAGE_CONNECTION_STRING'
Write-Host "Note: Render free tier sleeps after ~15min idle - first call may take 30-60s to wake it."
