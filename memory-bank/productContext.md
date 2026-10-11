# Product context

Customers browse categories, subcategories, brands and category-specific characteristics; they add products to a local cart and submit an order request. Store staff maintain catalogue content, images, SEO metadata, filter definitions and orders in Django Admin.

Important experience rules:

- A subcategory URL must keep its parent category selected in the filter UI.
- Brand filtering supports multiple brands, case-preserved names and an in-filter brand search.
- Product galleries work in cards and product pages.
- Cart changes must be available both on the full cart page and preview.
- Product images in demo seed data are placeholders and must be replaced with licensed/uploaded assets before production.
