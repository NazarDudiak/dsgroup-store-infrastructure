# Prompt for a friend's Codex

Copy the text below into Codex on macOS.

```text
Please make a complete local copy of the DSGroup store on this Mac and start it. Do not change the source code unless starting the project reveals a concrete compatibility issue; if that happens, explain it first.

Requirements to check: Git, Python 3, Node.js LTS and npm. If one is missing, tell me exactly what I need to install.

In a single parent folder, clone these repositories if they are not already present:
https://github.com/NazarDudiak/dsgroup-store-backend.git
https://github.com/NazarDudiak/dsgroup-store-frontend.git
https://github.com/NazarDudiak/dsgroup-store-infrastructure.git

Then run:
cd dsgroup-store-infrastructure && ./setup-and-run.sh

Wait for both services to respond. Open http://127.0.0.1:3000 in the browser and verify that the home page and one catalogue subcategory load. Report the local storefront URL, API health URL (http://127.0.0.1:8000/api/v1/health/) and the exact next step if something fails.

Important: this must be a local copy only. Do not push, commit or alter the GitHub repositories. Do not use --seed-demo on later starts because it refreshes demo records; normal starts preserve local changes.
```

## Expected result

- Storefront: `http://127.0.0.1:3000`
- Django Admin: `http://127.0.0.1:8000/admin/`
- API health check: `http://127.0.0.1:8000/api/v1/health/`

The initial start downloads dependencies, creates a local SQLite database and seeds the DSGroup demo catalogue. It can take a few minutes depending on the internet connection.
