# Bifrost — Railway Deployment

This repository deploys the official [Bifrost AI Gateway](https://github.com/maximhq/bifrost)
container to Railway. It is a deployment wrapper, not a source-code fork.

## Runtime

- Image: `maximhq/bifrost:v2.6.0` (pinned)
- HTTP/API/dashboard: `8080`
- Health check: `GET /health`
- Application data: `/app/data`
- Replicas: `1` (recommended when using the local SQLite stores)

## Deploy on Railway

1. Create a Railway service from this repository and select the `main` branch.
2. Railway detects the root `Dockerfile`; `railway.json` configures the build and health check.
3. Attach a Railway Volume to this service at **`/app/data`**. This preserves the SQLite configuration and request logs across redeploys.
4. Add these variables in Railway Variables:

   | Variable | Value |
   | --- | --- |
   | `APP_HOST` | `0.0.0.0` |
   | `APP_PORT` | `8080` |
   | `APP_DIR` | `/app/data` |
   | `LOG_LEVEL` | `info` |
   | `LOG_STYLE` | `json` |
   | `BIFROST_SETUP_TOKEN` | A unique random secret (first admin bootstrap only) |
   | `BIFROST_ENCRYPTION_KEY` | A stable 32-byte encryption key; keep it unchanged |

5. Generate a Railway public domain targeting port **8080**.
6. Wait for the deployment to become healthy, then open the domain.
7. Create the first admin account using the setup token, then enable dashboard password protection in **Workspace → Config → Security**.
8. Add provider API keys in the dashboard. Keep the encryption key stable; changing it can make previously stored encrypted credentials unreadable.

## Secrets

Generate secrets locally, for example:

```bash
openssl rand -hex 32
```

Use separate values for the setup token and encryption key. Store them only in Railway Variables or a password manager. Never commit real secrets to this repository.

## Notes

- Railway terminates public HTTPS; Bifrost listens over HTTP inside the container.
- The health check is `/health` on port 8080.
- Use one replica with SQLite. For multi-replica production deployments, configure an external supported database/store following the upstream Bifrost deployment documentation.
- Back up the Railway volume regularly.

## Upstream documentation

- [Bifrost setup](https://github.com/maximhq/bifrost/blob/dev/docs/quickstart/gateway/setting-up.mdx)
- [Bifrost runtime contract](https://github.com/maximhq/bifrost/blob/dev/docs/deployment-guides/runtime-contract.mdx)
- [Bifrost deployment guide](https://github.com/maximhq/bifrost/tree/dev/docs/deployment-guides)
