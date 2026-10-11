#!/bin/bash
set -euo pipefail
cd /Users/dudiak/Projects/Development/store-web
export PATH="/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export NEXT_PUBLIC_API_URL="http://127.0.0.1:8000/api/v1"
export NEXT_PUBLIC_SITE_URL="http://127.0.0.1:3000"
exec /opt/homebrew/bin/npm run dev -- --hostname 127.0.0.1 --port 3000
