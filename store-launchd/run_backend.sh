#!/bin/bash
set -euo pipefail
cd /Users/dudiak/Projects/Development/store-backend
export ALLOWED_HOSTS="localhost,127.0.0.1"
export DEBUG=True
exec /Users/dudiak/Projects/Development/store-backend/.venv/bin/python manage.py runserver 127.0.0.1:8000 --noreload
