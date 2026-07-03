-- =============================================================
-- Project 1 — Ads Sales Attainment Tracker : Analysis
-- Dialect: PostgreSQL primary. MySQL variants noted inline.
-- Only closed-won revenue counts toward attainment.
-- =============================================================

-- -------------------------------------------------------------
-- Q1. Revenue by region  (your KQL `summarize sum(revenue) by region`)
-- -------------------------------------------------------------
SELECT r.region,
       SUM(d.revenue) AS total_revenue
FROM deals d
JOIN sales_reps r ON r.rep_id = d.rep_id
WHERE d.stage = 'Closed Won'
GROUP BY r.region
ORDER BY total_revenue DESC;


-- -------------------------------------------------------------
-- Q2. Attainment by REP  (revenue vs. quota, with over/under flag)
-- -------------------------------------------------------------
SELECT r.rep_name,
       r.region,
       r.team,
       q.quota_amount,
       COALESCE(SUM(d.revenue), 0)                       AS closed_revenue,
       -- cast to numeric so we don't get integer-truncated division
       ROUND(COALESCE(SUM(d.revenue), 0) / q.quota_amount * 100, 1) AS attainment_pct,
       CASE
           WHEN COALESCE(SUM(d.revenue), 0) >= q.quota_amount THEN 'At / Above'
           ELSE 'Below'
       END AS attainment_status
FROM sales_reps r
JOIN quotas q
      ON q.rep_id = r.rep_id
     AND q.quarter = '2026-Q1'
LEFT JOIN deals d
      ON d.rep_id = r.rep_id
     AND d.stage  = 'Closed Won'
GROUP BY r.rep_name, r.region, r.team, q.quota_amount
ORDER BY attainment_pct DESC;
-- MySQL note: division works the same on DECIMAL columns; ROUND identical.
-- PostgreSQL note: if quota were an INT, cast e.g. SUM(d.revenue)::numeric.


-- -------------------------------------------------------------
-- Q3. Attainment by TEAM  (the executive roll-up)
-- -------------------------------------------------------------
SELECT r.team,
       SUM(q.quota_amount)                                        AS total_quota,
       COALESCE(SUM(d.revenue), 0)                                AS total_revenue,
       ROUND(COALESCE(SUM(d.revenue),0) / SUM(q.quota_amount) * 100, 1) AS team_attainment_pct
FROM sales_reps r
JOIN quotas q
      ON q.rep_id = r.rep_id
     AND q.quarter = '2026-Q1'
LEFT JOIN deals d
      ON d.rep_id = r.rep_id
     AND d.stage  = 'Closed Won'
GROUP BY r.team
ORDER BY team_attainment_pct DESC;


-- -------------------------------------------------------------
-- Q4. The "so what" — underperforming Mid-Market reps by region
--     (this is the slide that drives the recommendation)
-- -------------------------------------------------------------
SELECT r.region,
       r.rep_name,
       q.quota_amount,
       COALESCE(SUM(d.revenue),0) AS closed_revenue,
       ROUND(COALESCE(SUM(d.revenue),0) / q.quota_amount * 100, 1) AS attainment_pct
FROM sales_reps r
JOIN quotas q
      ON q.rep_id = r.rep_id
     AND q.quarter = '2026-Q1'
LEFT JOIN deals d
      ON d.rep_id = r.rep_id
     AND d.stage  = 'Closed Won'
WHERE r.team = 'Mid-Market'
GROUP BY r.region, r.rep_name, q.quota_amount
HAVING COALESCE(SUM(d.revenue),0) < q.quota_amount
ORDER BY attainment_pct ASC;


-- -------------------------------------------------------------
-- Q5. Revenue by product line within Mid-Market
--     (confirms Display is the soft spot)
-- -------------------------------------------------------------
SELECT d.product_line,
       SUM(d.revenue) AS revenue
FROM deals d
JOIN sales_reps r ON r.rep_id = d.rep_id
WHERE r.team = 'Mid-Market'
  AND d.stage = 'Closed Won'
GROUP BY d.product_line
ORDER BY revenue DESC;
