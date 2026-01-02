# Nginx Service

Nginx is a web server and reverse proxy.

## Connection Details

- **HTTP**: http://localhost:80
- **HTTPS**: https://localhost:443

## Management

- Start: `make nginx-up`
- Stop: `make nginx-down`
- Status: `make nginx-status`
- Logs: `make nginx-logs`
- Restart: `make nginx-restart`
- Connection Info: `make nginx-connection-info`

## Configuration

Nginx configuration is in `nginx.conf`. Edit this file to customize.

## Environment Variables

Copy `.env.example` to `.env` and customize:

- `NGINX_HTTP_PORT`: HTTP port (default: 80)
- `NGINX_HTTPS_PORT`: HTTPS port (default: 443)
