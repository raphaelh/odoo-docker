#!/usr/bin/env bash
set -euo pipefail

docker compose -f 17.0/docker-compose.yml config -q
