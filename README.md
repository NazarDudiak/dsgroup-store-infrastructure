# DSGroup: local start

This repository starts the DSGroup Django API and Next.js storefront on macOS.

## First run

Clone the three repositories into the same parent directory:

```bash
git clone https://github.com/NazarDudiak/dsgroup-store-backend.git
git clone https://github.com/NazarDudiak/dsgroup-store-frontend.git
git clone https://github.com/NazarDudiak/dsgroup-store-infrastructure.git
```

Then run one command:

```bash
cd dsgroup-store-infrastructure && ./setup-and-run.sh
```

The script creates the local Python environment, installs backend and frontend dependencies, copies local `.env` files from the included examples, applies database migrations, seeds a new DSGroup demo catalogue, starts both services, and opens the storefront at `http://127.0.0.1:3000`. On later launches it preserves all catalogue and admin edits. Use `./setup-and-run.sh --seed-demo` only when you intentionally want to refresh the demo records.

Requirements: macOS, Python 3, Node.js LTS, npm, Git, and internet access for the first dependency installation.

## Existing local folders

The script also recognizes the original folder names `store-backend` and `store-web`. To use custom paths, set `DSGROUP_BACKEND_DIR` and `DSGROUP_FRONTEND_DIR` before running it.

The older `toggle_store.sh` and `store-launchd` files remain available for Apple Shortcuts on the original Mac setup; they contain machine-specific paths.

## Shared project memory

The living cross-repository context is in [`memory-bank/`](./memory-bank/). Before changing catalogue, checkout, configuration or deployment behavior, read it; update `activeContext.md` and append to `progress.md` when a meaningful milestone is complete.
