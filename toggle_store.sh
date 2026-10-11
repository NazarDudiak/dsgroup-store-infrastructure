#!/bin/bash
set -euo pipefail

BACKEND_DIR="/Users/dudiak/Projects/Development/store-backend"
FRONTEND_DIR="/Users/dudiak/Projects/Development/store-web"
BACKEND_PORT=8000
FRONTEND_PORT=3000
LAUNCHD_DIR="/Users/dudiak/Projects/Development/store-launchd"
API_LABEL="com.dudiak.local-store-api"
WEB_LABEL="com.dudiak.local-store-web"
GUI_DOMAIN="gui/$(id -u)"
LSOF_BIN="/usr/sbin/lsof"

notify() { /usr/bin/osascript -e "display notification \"$1\" with title \"Store\" sound name \"$2\""; }
port_pids() { "$LSOF_BIN" -tiTCP:"$1" -sTCP:LISTEN 2>/dev/null || true; }
stop_port() { local pids; pids=$(port_pids "$1"); [ -z "$pids" ] && return; kill $pids 2>/dev/null || true; sleep 0.5; pids=$(port_pids "$1"); [ -z "$pids" ] || kill -9 $pids 2>/dev/null || true; }
service_loaded() { /bin/launchctl print "$GUI_DOMAIN/$1" >/dev/null 2>&1; }

if service_loaded "$API_LABEL" || service_loaded "$WEB_LABEL"; then
  /bin/launchctl bootout "$GUI_DOMAIN/$API_LABEL" 2>/dev/null || true
  /bin/launchctl bootout "$GUI_DOMAIN/$WEB_LABEL" 2>/dev/null || true
  stop_port "$BACKEND_PORT"; stop_port "$FRONTEND_PORT"
  notify "Магазин зупинено" "Glass"; exit 0
fi

if [ ! -x "$BACKEND_DIR/.venv/bin/python" ] || [ ! -x /opt/homebrew/bin/npm ] || [ ! -d "$FRONTEND_DIR/node_modules" ]; then
  notify "Не знайдено залежності магазину" "Basso"; exit 1
fi

/bin/launchctl bootstrap "$GUI_DOMAIN" "$LAUNCHD_DIR/$API_LABEL.plist"
/bin/launchctl bootstrap "$GUI_DOMAIN" "$LAUNCHD_DIR/$WEB_LABEL.plist"
sleep 2
if [ -n "$(port_pids "$BACKEND_PORT")" ] && [ -n "$(port_pids "$FRONTEND_PORT")" ]; then
  /usr/bin/open "http://127.0.0.1:$FRONTEND_PORT"
  notify "Магазин запущено на localhost:3000" "Default"
else
  notify "Помилка запуску — перевірте server.log" "Basso"; exit 1
fi
