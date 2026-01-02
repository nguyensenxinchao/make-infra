# Vault Service

HashiCorp Vault is a tool for securely accessing secrets.

## Connection Details

- **URL**: http://localhost:8200
- **Token**: myroot (default, dev mode only)

## Management

- Start: `make vault-up`
- Stop: `make vault-down`
- Status: `make vault-status`
- Logs: `make vault-logs`
- Restart: `make vault-restart`
- Connection Info: `make vault-connection-info`

## Environment Variables

Copy `.env.example` to `.env` and customize:

- `VAULT_PORT`: Port to expose (default: 8200)
- `VAULT_TOKEN`: Root token (default: myroot, dev mode only)

⚠️ **Note**: This is running in dev mode. For production, use proper Vault configuration.
