# AI-Assisted Analysis Workflow

The Commercial Strategy & Operations role explicitly values **using AI tools to query data,
run scenarios, and generate concrete actions**. This document shows how AI was used
*responsibly* in this portfolio — to accelerate work while keeping a human in the loop
for validation.

> **Principle:** AI drafts, the analyst verifies. Every AI-generated query was run,
> checked against the data, and corrected before being trusted.

---

## Worked example: from question to action

### 1️⃣ Business question (plain English)
> "Which advertisers only buy one Ads product, and which single-product advertiser
> represents the biggest cross-sell opportunity?"

### 2️⃣ AI prompt used
> "I have a PostgreSQL `deals` table with columns `advertiser_id`, `product_line`, and
> `revenue`. Write a query that finds advertisers buying only one product line, and rank
> them by total revenue so I can see the biggest cross-sell targets."

### 3️⃣ AI-drafted SQL (before review)
```sql
SELECT advertiser_id, SUM(revenue) AS total_revenue
FROM deals
GROUP BY advertiser_id
HAVING COUNT(DISTINCT product_line) = 1
ORDER BY total_revenue DESC;
```

### 4️⃣ Analyst refinement (after review)
The draft was correct but not *decision-ready*. I joined in advertiser names and the
single product they buy, so the output tells a story a sales leader can act on:

```sql
SELECT a.advertiser_name,
       a.industry,
       MAX(d.product_line)      AS only_product,
       SUM(d.revenue)           AS total_revenue
FROM deals d
JOIN advertisers a ON a.advertiser_id = d.advertiser_id
GROUP BY a.advertiser_name, a.industry
HAVING COUNT(DISTINCT d.product_line) = 1
ORDER BY total_revenue DESC
LIMIT 20;
```

### 5️⃣ Scenario modeling with AI
> "If we assume single-product Enterprise advertisers would spend 40% of their current
> Search budget on YouTube if cross-sold, estimate the incremental revenue."

AI proposed the assumption structure; I validated the math in SQL and sanity-checked the
totals against the raw data.

### 6️⃣ Action generated
> **Recommendation:** Launch a YouTube cross-sell play targeting the top 30 single-product
> Enterprise advertisers by Search spend — the highest-propensity, fastest-close segment.

---

## Where AI helped across the portfolio

| Task | AI's role | Human's role |
|------|-----------|--------------|
| Drafting first-pass SQL | Scaffolds syntax quickly | Verify logic & correctness |
| Explaining errors | Interprets error messages | Decide the fix |
| Scenario modeling | Structures "what-if" assumptions | Validate math against data |
| Narrative generation | Drafts executive summary prose | Edit for accuracy & tone |
| Action brainstorming | Lists possible interventions | Filter to realistic ones |
