# 📈 Project 1 — Ads Sales Attainment Tracker

**Level:** Beginner · **Skills:** JOINs, GROUP BY, aggregates, CASE

---

## 🧩 Business question
> "Which sales teams and regions are hitting quota this quarter, and where are we bleeding
> revenue vs. target?"

## 💡 The insight (lead with the "so what")
> EMEA **Enterprise** is at **112% attainment**, but **Mid-Market Display** is at **68%** —
> driven by 3 underperforming reps in the **DACH** region.
>
> **Recommendation:** reallocate 2 SMB reps to Mid-Market Display coverage and prioritize a
> Display enablement push before quarter-end.

## 🗺️ Why this matters for Commercial Strategy & Ops
This is the foundational **Quarterly Business Review (QBR)** artifact every Strategy & Ops
associate produces. It maps directly to the responsibility of **designing business cadences
and core metrics** — and proves a focus on *insights over raw reporting volume*.

## 🛠️ How to run it
1. Create the schema: run [`schema.sql`](schema.sql)
2. Load synthetic data: run [`seed_data.sql`](seed_data.sql)
3. Run the analysis: [`analysis.sql`](analysis.sql)

Works in **PostgreSQL** (primary). MySQL differences are noted inline and in
[`postgres_vs_mysql.md`](postgres_vs_mysql.md).

## 📊 BI / visualization angle
A Tableau dashboard with:
- **Bullet charts** — attainment vs. quota (executive standard)
- **Regional heat map** — attainment by region
- **Ranked bar** — reps sorted by attainment %

_Dashboard screenshot & Tableau Public link coming in Week 2._

## 🔄 KQL → SQL note
Your KQL `summarize TotalRevenue = sum(revenue) by region` **is** SQL's
`GROUP BY region` + `SUM(revenue)`. Same mental model, different spelling.
