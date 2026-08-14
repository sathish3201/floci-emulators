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
| `floci-ui` | Web console for the emulators above (API + frontend in one image) | 4500 |

**Not supported on Render** (these specific services need a Docker socket
Render doesn't expose): AWS Lambda, RDS, ECS, EKS, EC2, MSK, OpenSearch,
Athena.

## Storage

Running on Render's **free tier**, which has no persistent disk support.
`FLOCI_STORAGE_MODE` is set to `memory` (floci's in-RAM mode — the other
valid values are `persistent`, `hybrid`, and `wal`, all of which need a
disk) — emulator state (buckets, tables, queues, etc.) resets on every
service restart or redeploy. Fine for local dev/testing against these
emulators; not for anything you need to survive a restart.

To get persistence across restarts, switch each service's `plan` to
`starter` (or higher) and add a `disk:` block back — see git history for
the original persistent-disk config.

## Deploy

1. Push this repo to GitHub.
2. On [Render](https://dashboard.render.com) → **New** → **Blueprint** → connect this repo.
3. Render reads `render.yaml` and creates all four services.

Note: Render assigns each service's final hostname (sometimes with a
random suffix, e.g. `floci-aws-gsnc.onrender.com` rather than plain
`floci-aws.onrender.com`) — check the actual URL on each service's page
in the Render dashboard and update `floci-env.sh` / `floci-env.ps1`
accordingly if it differs from what's committed here.

## Using it from your local machine

Requires the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
(or any AWS SDK — floci speaks the real AWS API).

**Bash/macOS/Linux/Git Bash:**
```bash
source ./floci-env.sh
aws s3 mb s3://my-test-bucket
aws s3 ls
```

**PowerShell:**
```powershell
. .\floci-env.ps1
aws s3 mb s3://my-test-bucket
aws s3 ls
```

Either script exports `AWS_ENDPOINT_URL`, `AWS_ACCESS_KEY_ID`,
`AWS_SECRET_ACCESS_KEY`, and `AWS_DEFAULT_REGION` for the current shell
session, pointing the AWS CLI/SDK at the deployed `floci-aws` service
instead of localhost or real AWS — same idea as floci's own
`eval $(floci env)`, just targeting Render instead of a local container.

Render's free tier sleeps after ~15 minutes idle, so the first request
after a quiet period can take 30-60s to wake the service. Storage is
`memory` mode (see above), so data doesn't survive a restart/redeploy.

## Web console (floci-ui)

`floci-ui` ([floci-io/floci-ui](https://github.com/floci-io/floci-ui)) is a
single combined image (API + built frontend on one port) that gives you a
browser UI over the deployed emulators instead of the AWS/Azure CLI.

It's wired in `render.yaml` to point at `floci-aws`, `floci-az`, and
`floci-gcp` via `FLOCI_ENDPOINT` / `FLOCI_AZURE_ENDPOINT` /
`FLOCI_GCP_ENDPOINT`. Render assigns each service's actual hostname on
first deploy — check the service URLs in the Render dashboard and update
the matching env vars on `floci-ui` (dashboard → floci-ui → Environment)
if they differ from what's committed here, then trigger a redeploy.

Open the `floci-ui` service's URL in a browser once it's deployed. Same
free-tier caveats apply: cold start after ~15 min idle. OCI isn't wired
into the console yet — floci-ui doesn't currently support it as a target.
