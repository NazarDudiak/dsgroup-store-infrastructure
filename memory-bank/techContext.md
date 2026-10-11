# Technical context

- Backend: Python, Django, Django REST Framework, Django Admin with Unfold; SQLite locally and PostgreSQL-compatible via `DATABASE_URL`.
- Frontend: Next.js App Router and TypeScript.
- Local launch: `./setup-and-run.sh` from this repository. It creates virtual environment/dependencies, applies migrations, seeds only a new database, then starts ports 8000 and 3000.
- Verification: backend `manage.py check` and tests; frontend `npm run build`.

Environment variables are documented in backend `.env.example` and frontend `.env.local.example`. Use `ENVIRONMENT=production` only with live deployment configuration.
