# DSGroup local infrastructure

Local macOS launchd scripts for the DSGroup Django API and Next.js storefront.

Before using, update the absolute paths in `toggle_store.sh` and the `store-launchd/*.plist` files to the directory where you cloned the backend and frontend repositories.

Install the Apple Shortcut by running `toggle_store.sh` from the Shortcuts app. It starts or stops both services and opens the storefront at `http://127.0.0.1:3000`.
