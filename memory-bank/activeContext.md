# Active context

Last updated: 2026-10-12

Completed in the current development cycle:

- Admin-managed `Subcategory`, nested catalogue API and dynamic storefront mega-menu.
- Normalized product characteristics supplied to the storefront and used for category-specific filters.
- Atomic idempotent order handling, Ukrainian phone normalization and order rate limit.
- Production-safe Django configuration guards and health endpoint.
- Local launcher now preserves manual catalogue edits by not reseeding existing databases.
- Demo catalogue was professionally revised so each of the 11 visible subcategories has an actual product model and model-specific image references. Generic stock photos were removed from published products.
- A ready-to-paste, non-destructive bootstrap prompt for a second Mac is maintained in `FRIEND_CODEX_PROMPT.md`.

Next decisions requiring the owner:

1. Select payment, delivery, email/SMS and analytics providers.
2. Provide domain, production hostnames and a secrets manager/deployment target.
3. Replace sample external images with licensed assets uploaded to managed storage.
4. Add GitHub Actions workflows after granting the publishing token the GitHub `workflow` scope. The current token cannot create `.github/workflows/*`, so CI configuration was intentionally not pushed.
