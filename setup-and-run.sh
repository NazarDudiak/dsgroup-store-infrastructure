#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
BACKEND_PORT=8000
FRONTEND_PORT=3000

find_project_dir() {
  local configured="$1" clone_name="$2" local_name="$3"
  if [ -n "$configured" ]; then printf '%s\n' "$configured"; return; fi
  if [ -d "$ROOT_DIR/$clone_name" ]; then printf '%s\n' "$ROOT_DIR/$clone_name"; return; fi
  printf '%s\n' "$ROOT_DIR/$local_name"
}

BACKEND_DIR="$(find_project_dir "${DSGROUP_BACKEND_DIR:-}" dsgroup-store-backend store-backend)"
FRONTEND_DIR="$(find_project_dir "${DSGROUP_FRONTEND_DIR:-}" dsgroup-store-frontend store-web)"

fail() { printf 'Помилка: %s\n' "$1" >&2; exit 1; }
has_listener() { /usr/sbin/lsof -tiTCP:"$1" -sTCP:LISTEN >/dev/null 2>&1; }

[ -d "$BACKEND_DIR" ] || fail "Не знайдено бекенд: $BACKEND_DIR"
[ -d "$FRONTEND_DIR" ] || fail "Не знайдено фронтенд: $FRONTEND_DIR"
command -v python3 >/dev/null || fail "Потрібен Python 3."
command -v node >/dev/null || fail "Потрібен Node.js LTS."
command -v npm >/dev/null || fail "Потрібен npm."

printf 'Підготовка бекенду…\n'
if [ ! -x "$BACKEND_DIR/.venv/bin/python" ]; then python3 -m venv "$BACKEND_DIR/.venv"; fi
"$BACKEND_DIR/.venv/bin/python" -m pip install --upgrade pip >/dev/null
"$BACKEND_DIR/.venv/bin/python" -m pip install -r "$BACKEND_DIR/requirements.txt"
if [ ! -f "$BACKEND_DIR/.env" ]; then cp "$BACKEND_DIR/.env.example" "$BACKEND_DIR/.env"; fi
(cd "$BACKEND_DIR" && .venv/bin/python manage.py migrate && .venv/bin/python manage.py seed_ds_group)

printf 'Підготовка фронтенду…\n'
if [ ! -d "$FRONTEND_DIR/node_modules" ]; then (cd "$FRONTEND_DIR" && npm ci); fi
if [ ! -f "$FRONTEND_DIR/.env.local" ]; then cp "$FRONTEND_DIR/.env.local.example" "$FRONTEND_DIR/.env.local"; fi

if ! has_listener "$BACKEND_PORT"; then
  printf 'Запуск API на http://127.0.0.1:%s…\n' "$BACKEND_PORT"
  (cd "$BACKEND_DIR" && nohup .venv/bin/python manage.py runserver "127.0.0.1:$BACKEND_PORT" > server.log 2>&1 &)
fi
if ! has_listener "$FRONTEND_PORT"; then
  printf 'Запуск вітрини на http://127.0.0.1:%s…\n' "$FRONTEND_PORT"
  (cd "$FRONTEND_DIR" && nohup npm run dev -- --hostname 127.0.0.1 --port "$FRONTEND_PORT" > server.log 2>&1 &)
fi

for _ in {1..30}; do
  if curl -fsS "http://127.0.0.1:$FRONTEND_PORT" >/dev/null 2>&1; then
    printf '\nDSGroup запущено: http://127.0.0.1:%s\n' "$FRONTEND_PORT"
    command -v open >/dev/null && open "http://127.0.0.1:$FRONTEND_PORT"
    exit 0
  fi
  sleep 1
done

fail "Сайт не відповів за 30 секунд. Перевірте server.log у репозиторіях."
