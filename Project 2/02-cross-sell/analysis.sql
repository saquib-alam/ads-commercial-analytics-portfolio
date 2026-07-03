-- =============================================================
-- Project 2 — Adoption & Cross-Sell Opportunity Map : Analysis
-- Uses the shared dataset from 01-sales-attainment.
-- Dialect: PostgreSQL primary. MySQL notes inline.
-- =============================================================

-- -------------------------------------------------------------
-- Q1. Products purchased per advertiser
--     (KQL: summarize dcount(product_line) by advertiser_id)
-- -------------------------------------------------------------
SELECT a.advertiser_name,
       a.size_tier,
       COUNT(DISTINCT d.product_line) AS products_bought
FROM advertisers a
JOIN deals d ON d.advertiser_id = a.advertiser_id
WHERE d.stage = 'Closed Won'
GROUP BY a.advertiser_name, a.size_tier
ORDER BY products_bought DESC, a.advertiser_name;


-- -------------------------------------------------------------
-- Q2. Single-product advertisers, ranked by revenue
--     (the cross-sell target list)
-- -------------------------------------------------------------
SELECT a.advertiser_name,
       a.industry,
       a.size_tier,
       MAX(d.product_line)  AS only_product,
       SUM(d.revenue)       AS total_revenue
FROM advertisers a
JOIN deals d ON d.advertiser_id = a.advertiser_id
WHERE d.stage = 'Closed Won'
GROUP BY a.advertiser_name, a.industry, a.size_tier
HAVING COUNT(DISTINCT d.product_line) = 1
ORDER BY total_revenue DESC;


-- -------------------------------------------------------------
-- Q3. WHITESPACE: advertisers who buy Search but NOT YouTube
--     Anti-join pattern (LEFT JOIN ... IS NULL)
-- -------------------------------------------------------------
WITH search_buyers AS (
    SELECT DISTINCT advertiser_id
    FROM deals
    WHERE product_line = 'Search' AND stage = 'Closed Won'
),
youtube_buyers AS (
    SELECT DISTINCT advertiser_id
    FROM deals
    WHERE product_line = 'YouTube' AND stage = 'Closed Won'
)
SELECT a.advertiser_name,
       a.size_tier,
       a.industry
FROM search_buyers s
JOIN advertisers a       ON a.advertiser_id = s.advertiser_id
LEFT JOIN youtube_buyers y ON y.advertiser_id = s.advertiser_id
WHERE y.advertiser_id IS NULL          -- <-- the anti-join: "has Search, lacks YouTube"
ORDER BY a.size_tier, a.advertiser_name;
-- MySQL note: identical. CTEs supported in MySQL 8.0+.
-- Alternative in PostgreSQL: use EXCEPT to subtract youtube_buyers from search_buyers.


-- -------------------------------------------------------------
-- Q4. Size the prize: Search spend of the YouTube-whitespace accounts
--     (prioritise the cross-sell play by $$)
-- -------------------------------------------------------------
WITH youtube_buyers AS (
    SELECT DISTINCT advertiser_id
    FROM deals
    WHERE product_line = 'YouTube' AND stage = 'Closed Won'
)
SELECT a.advertiser_name,
       a.size_tier,
       SUM(d.revenue) AS current_search_spend
FROM deals d
JOIN advertisers a ON a.advertiser_id = d.advertiser_id
LEFT JOIN youtube_buyers y ON y.advertiser_id = d.advertiser_id
WHERE d.product_line = 'Search'
  AND d.stage = 'Closed Won'
  AND y.advertiser_id IS NULL          -- only accounts with NO YouTube yet
GROUP BY a.advertiser_name, a.size_tier
ORDER BY current_search_spend DESC;
