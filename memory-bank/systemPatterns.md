# System patterns

## Source of truth

Django owns all business data. The browser never accesses the database directly. The Next.js app consumes only `/api/v1`.

## Catalogue

`Category → Subcategory → Product` is the navigational hierarchy. `Subcategory` is admin-managed; `Product.subcategory` remains only as compatibility data while `subcategory_ref` is the source for new content. Characteristics use `AttributeDefinition → ProductAttributeValue`, scoped by product category. Do not add new filter semantics to legacy `Product.specifications` JSON.

## Orders

Order creation must stay atomic. Products are locked, stock is checked/decremented, and order line snapshots are created inside one database transaction. The client generates a UUID `Idempotency-Key` for each checkout attempt.

## Configuration

No secret belongs in Git. Development defaults are local-only. Production requires explicit hosts, strong secret, HTTPS and secure cookies.
