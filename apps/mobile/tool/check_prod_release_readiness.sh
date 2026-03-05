#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] check_prod_release_readiness.sh is deprecated. Use check_release_readiness.sh."
exec "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/check_release_readiness.sh"
