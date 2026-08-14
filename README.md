# floci-emulators

Render Blueprint deploying [floci](https://hub.docker.com/u/floci) cloud
emulators (AWS, Azure, GCP, OCI) as four separate free-tier web services.

## Services

| Service | Emulates | Port |
|---|---|---|
| `floci-aws` | AWS (S3, DynamoDB, SQS, SNS, IAM, KMS, STS, CloudFormation, Secrets Manager, EventBridge, Step Functions, SSM, API Gateway, Cognito, etc.) | 4566 |
| `floci-az` | Azure — fully functional, no Docker-socket dependency | 4577 |
| `floci-gcp` | GCP — fully functional, no Docker-socket dependency | 4588 |
| `floci-oci` | OCI (Object Storage, Identity, Queue, Streaming, KMS, Vault) | 4599 |

**Not supported on Render** (these specific services need a Docker socket
Render doesn't expose): AWS Lambda, RDS, ECS, EKS, EC2, MSK, OpenSearch,
Athena.

## Storage

Running on Render's **free tier**, which has no persistent disk support.
`FLOCI_STORAGE_MODE` is set to `ephemeral` — emulator state (buckets,
tables, queues, etc.) resets on every service restart or redeploy. Fine
for local dev/testing against these emulators; not for anything you need
to survive a restart.

To get persistence across restarts, switch each service's `plan` to
`starter` (or higher) and add a `disk:` block back — see git history for
the original persistent-disk config.

## Deploy

1. Push this repo to GitHub.
2. On [Render](https://dashboard.render.com) → **New** → **Blueprint** → connect this repo.
3. Render reads `render.yaml` and creates all four services.
