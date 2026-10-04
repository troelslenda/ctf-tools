#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")"

podman-compose up -d --build --force-recreate kali-ctf
exec podman-compose exec kali-ctf /bin/bash
