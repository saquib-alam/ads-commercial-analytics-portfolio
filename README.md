# 📊 Ads Commercial Strategy & Operations — SQL Portfolio

> Data-backed analyses mirroring the work of a **Commercial Strategy & Operations** team:
> sales prioritization, portfolio management, sales compensation, and executive business cadences.
>
> **Stack:** PostgreSQL · MySQL · Tableau Public · AI-assisted analysis

---

## 🎯 Why this portfolio exists

Each project answers a real question a **sales leader** would ask and ends with a
**concrete recommendation** — not just query output. The goal: demonstrate the ability to
turn commercial data into decisions.

## 📁 Projects

| # | Project | Business Question | Key SQL Skills | Live Dashboard |
|---|---------|-------------------|----------------|----------------|
| 1 | [Ads Sales Attainment Tracker](/Project%201/01-sales-attainment) | Who's hitting quota and where are we losing revenue vs. target? | JOINs, GROUP BY, CASE | _coming soon_ |
| 2 | [Adoption & Cross-Sell Map](Project%202/02-cross-sell) | Where is our untapped cross-sell revenue? | Anti-joins, CTEs, COUNT(DISTINCT) | _coming soon_ |
| 3 | Pipeline Health & Conversion Funnel | Where do deals stall and what's our forecast? | Window functions, date math | _planned_ |
| 4 | Sales Compensation Model | Is our comp plan driving the right behavior? | Range joins, nested CASE | _planned_ |
| 5 | Executive Business Review (capstone) | The automated monthly one-pager | Views, ROLLUP, time intelligence | _planned_ |

## 🗂️ Data Model

A shared, realistic Ads sales dataset powers every project:

- **`sales_reps`** — the EMEA sales team and reporting structure
- **`advertisers`** — customers, segmented by industry and size tier
- **`product_catalog`** — the Ads product lines (Search, Display, YouTube, Shopping)
- **`quotas`** — quarterly targets per rep
- **`deals`** — closed and in-flight deals linking reps, advertisers, and products

See [`01-sales-attainment/schema.sql`](/Project%201/01-sales-attainment/schema.sql) for full table definitions.

## 🤖 AI Workflow

The target role explicitly values using AI tools to query data, run scenarios, and generate
actions. See [`AI-WORKFLOW.md`](/AI-WORKFLOW.md) for a worked example of the
prompt → SQL → validated-insight loop.

## 🧭 Dialect Notes

Primary dialect is **PostgreSQL**, with **MySQL** equivalents documented per project
(see each project's `postgres_vs_mysql.md`).
