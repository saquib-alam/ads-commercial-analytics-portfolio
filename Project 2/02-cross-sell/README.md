# 🔗 Project 2 — Ads Solution Adoption & Cross-Sell Opportunity Map

**Level:** Beginner–Intermediate · **Skills:** Anti-joins, CTEs, COUNT(DISTINCT), HAVING

---

## 🧩 Business question
> "Which advertisers are only buying one Ads product, and where's our biggest untapped
> cross-sell revenue?"

## 💡 The insight (lead with the "so what")
> Several **Enterprise** advertisers buy **Search but not YouTube**, representing significant
> cross-sell whitespace (e.g., NordCommerce and Copenhagen Tech are Search-only despite large
> Search budgets).
>
> **Recommendation:** build a targeted **YouTube cross-sell play** for the top Enterprise
> accounts by Search spend — highest propensity, fastest close.

## 🗺️ Why this matters for Commercial Strategy & Ops
This is a bullseye for **"diversifying adoption of Ads solutions"** and **"developing sales
priorities"** — nearly verbatim from the role. It proves the ability to find *where the
growth is*, the core of GTM prioritization.

## 🛠️ How to run it
Uses the **same dataset** as Project 1. Run Project 1's
[`schema.sql`](../01-sales-attainment/schema.sql) and
[`seed_data.sql`](../01-sales-attainment/seed_data.sql) first, then run
[`analysis.sql`](analysis.sql) here.

## 📊 BI / visualization angle
A **matrix/crosstab heatmap** (advertisers × product lines, colored by spend) instantly
reveals adoption gaps. Pair with a "Top cross-sell targets" ranked table.

## 🔄 KQL → SQL note
KQL's `dcount(product_line)` → SQL's `COUNT(DISTINCT product_line)`.
The "find what's missing" whitespace pattern uses a **`LEFT JOIN ... WHERE NULL`**
anti-join — equivalent to filtering an `leftanti` join in KQL.
