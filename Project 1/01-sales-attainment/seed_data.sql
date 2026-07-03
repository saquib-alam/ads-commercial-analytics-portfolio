-- =============================================================
-- Synthetic seed data — realistic EMEA Ads sales scenario
-- Intentionally shaped so real insights are discoverable:
--   * DACH Mid-Market Display underperforms quota
--   * Several Enterprise advertisers buy Search but not YouTube
-- =============================================================

-- ---- sales_reps -------------------------------------------------
INSERT INTO sales_reps (rep_id, rep_name, region, team, manager_id) VALUES
(1,  'Elena Fischer',   'DACH',    'Enterprise',  100),
(2,  'Lukas Weber',     'DACH',    'Mid-Market',  100),
(3,  'Anna Schmidt',    'DACH',    'Mid-Market',  100),
(4,  'Jonas Becker',    'DACH',    'Mid-Market',  100),
(5,  'Sofia Marino',    'Iberia',  'Enterprise',  101),
(6,  'Diego Alvarez',   'Iberia',  'SMB',         101),
(7,  'Marta Ruiz',      'Iberia',  'SMB',         101),
(8,  'Chloe Dubois',    'France',  'Enterprise',  102),
(9,  'Hugo Laurent',    'France',  'Mid-Market',  102),
(10, 'Emma Nielsen',    'Nordics', 'Enterprise',  103),
(11, 'Oscar Lind',      'Nordics', 'SMB',         103),
(12, 'Julia Meijer',    'Benelux', 'Mid-Market',  104);

-- ---- product_catalog -------------------------------------------
INSERT INTO product_catalog (product_line, product_category, avg_deal_size) VALUES
('Search',   'Performance', 45000.00),
('Display',  'Brand',       28000.00),
('YouTube',  'Brand',       52000.00),
('Shopping', 'Commerce',    38000.00);

-- ---- advertisers ------------------------------------------------
INSERT INTO advertisers (advertiser_id, advertiser_name, industry, size_tier) VALUES
(201, 'NordCommerce AB',    'Retail',  'Enterprise'),
(202, 'BayernAuto GmbH',    'Auto',    'Enterprise'),
(203, 'Iberia Travel SL',   'Travel',  'Enterprise'),
(204, 'ParisFin SA',        'Finance', 'Enterprise'),
(205, 'Rhein Retail GmbH',  'Retail',  'Mid-Market'),
(206, 'Munich Mode GmbH',   'Retail',  'Mid-Market'),
(207, 'Alpine Sports GmbH', 'Retail',  'Mid-Market'),
(208, 'Lyon Eats SARL',     'CPG',     'Mid-Market'),
(209, 'Copenhagen Tech A/S','Tech',    'Enterprise'),
(210, 'Madrid Media SL',    'Tech',    'SMB'),
(211, 'Sevilla Shop SL',    'Retail',  'SMB'),
(212, 'Oslo Outdoor AS',    'Retail',  'SMB'),
(213, 'Amsterdam Auto BV',  'Auto',    'Mid-Market'),
(214, 'Berlin Bank AG',     'Finance', 'Enterprise'),
(215, 'Hamburg Home GmbH',  'Retail',  'Mid-Market');

-- ---- quotas (2026-Q1) ------------------------------------------
INSERT INTO quotas (rep_id, quarter, quota_amount) VALUES
(1,  '2026-Q1', 400000.00),
(2,  '2026-Q1', 250000.00),   -- DACH Mid-Market (will under-attain)
(3,  '2026-Q1', 250000.00),   -- DACH Mid-Market (will under-attain)
(4,  '2026-Q1', 250000.00),   -- DACH Mid-Market (will under-attain)
(5,  '2026-Q1', 380000.00),
(6,  '2026-Q1', 150000.00),
(7,  '2026-Q1', 150000.00),
(8,  '2026-Q1', 400000.00),
(9,  '2026-Q1', 240000.00),
(10, '2026-Q1', 390000.00),
(11, '2026-Q1', 140000.00),
(12, '2026-Q1', 240000.00);

-- ---- deals (2026-Q1) -------------------------------------------
-- Enterprise reps over-perform; DACH Mid-Market Display lags.
INSERT INTO deals (deal_id, rep_id, advertiser_id, product_line, close_date, revenue, stage) VALUES
-- Elena (DACH Enterprise) — strong, diversified
(1001, 1, 202, 'Search',   '2026-01-15', 180000, 'Closed Won'),
(1002, 1, 202, 'YouTube',  '2026-02-10', 160000, 'Closed Won'),
(1003, 1, 214, 'Search',   '2026-03-05', 110000, 'Closed Won'),
-- Lukas (DACH Mid-Market) — under quota, Display-heavy & weak
(1004, 2, 205, 'Display',  '2026-01-20',  60000, 'Closed Won'),
(1005, 2, 206, 'Display',  '2026-02-18',  55000, 'Closed Won'),
(1006, 2, 207, 'Search',   '2026-03-12',  55000, 'Closed Won'),
-- Anna (DACH Mid-Market) — under quota
(1007, 3, 206, 'Display',  '2026-02-01',  50000, 'Closed Won'),
(1008, 3, 215, 'Display',  '2026-03-15',  60000, 'Closed Won'),
-- Jonas (DACH Mid-Market) — under quota
(1009, 4, 207, 'Display',  '2026-01-28',  45000, 'Closed Won'),
(1010, 4, 215, 'Search',   '2026-03-20',  70000, 'Closed Won'),
-- Sofia (Iberia Enterprise) — strong
(1011, 5, 203, 'Search',   '2026-01-22', 200000, 'Closed Won'),
(1012, 5, 203, 'YouTube',  '2026-02-25', 130000, 'Closed Won'),
(1013, 5, 210, 'Search',   '2026-03-10',  90000, 'Closed Won'),
-- Diego & Marta (Iberia SMB)
(1014, 6, 211, 'Search',   '2026-02-05',  85000, 'Closed Won'),
(1015, 7, 211, 'Shopping', '2026-03-01',  80000, 'Closed Won'),
-- Chloe (France Enterprise) — strong
(1016, 8, 204, 'Search',   '2026-01-18', 210000, 'Closed Won'),
(1017, 8, 204, 'YouTube',  '2026-02-20', 120000, 'Closed Won'),
-- Hugo (France Mid-Market)
(1018, 9, 208, 'Search',   '2026-02-12', 130000, 'Closed Won'),
-- Emma (Nordics Enterprise) — strong, Search-only (cross-sell target!)
(1019, 10, 201, 'Search',  '2026-01-25', 220000, 'Closed Won'),
(1020, 10, 209, 'Search',  '2026-03-08', 150000, 'Closed Won'),
-- Oscar (Nordics SMB)
(1021, 11, 212, 'Shopping','2026-02-15',  90000, 'Closed Won'),
-- Julia (Benelux Mid-Market)
(1022, 12, 213, 'Search',  '2026-02-08', 140000, 'Closed Won'),
(1023, 12, 213, 'Display', '2026-03-18',  70000, 'Closed Won'),
-- A couple of in-flight (not closed) deals for realism
(1024, 2, 205, 'YouTube',  NULL,          80000, 'Negotiation'),
(1025, 10, 201,'YouTube',  NULL,         100000, 'Proposal');
