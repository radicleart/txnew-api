---
description: Deployment related information
---

# Deployment

## Introduction

First goal is a shared devnet environment.

Setup uses nginx reverse proxy to backen stacks services running in docker;

1. nginx as a reverse proxy to stacks / bitcoin services
2. letsencrypt to enable ssl connections
3. port forwarding is used if needed allow Leather wallet to connect to remote devnet

### SSL & Nginx

Uses subdomains of stx.eco to keep things organised. Linked and certs created using certbot as follows;

```
# symlink service files
sudo ln -sf "/etc/nginx/sites-available/devnet.stx.eco" "/etc/nginx/sites-enabled"
sudo ln -sf "/etc/nginx/sites-available/devnet-stacks.stx.eco" "/etc/nginx/sites-enabled"
sudo ln -sf "/etc/nginx/sites-available/devnet-stacks-explorer.stx.eco" "/etc/nginx/sites-enabled"
sudo ln -sf "/etc/nginx/sites-available/devnet-bitcoin-explorer.stx.eco" "/etc/nginx/sites-enabled"
# generate ssl certs
sudo certbot --nginx certonly --cert-name vote.stx.eco \
-d devnet.stx.eco \
-d devnet-stacks.stx.eco \
-d devnet-stacks-explorer.stx.eco \
-d devnet-bitcoin-explorer.stx.eco \
-d devnet-electrs.stx.eco
```

Note: stacks explorer requires an additional network connections and possibly port forwarding

### Stacks & Bitcoin Containers

Tried clarinet devnet start which runs on mac but this failed on ubuntu.&#x20;

Instead using the new sbtc devenv

1. git clone https://github.com/stacks-network/sbtc.git
2. cd sbtc/
3. git checkout devnet/stacker-container
4. cd devenv/local/docker-compose/
5. ./up.sh

in bitcoin-dao









