-- =============================================================
-- Ads Commercial Analytics Portfolio — Shared Schema (DDL)
-- Dialect: PostgreSQL (primary). MySQL notes in postgres_vs_mysql.md
-- =============================================================

-- Clean slate (safe re-runs)
DROP TABLE IF EXISTS deals;
DROP TABLE IF EXISTS quotas;
DROP TABLE IF EXISTS advertisers;
DROP TABLE IF EXISTS product_catalog;
DROP TABLE IF EXISTS sales_reps;

-- 1) The sales team ------------------------------------------------
CREATE TABLE sales_reps (
    rep_id      INT PRIMARY KEY,
    rep_name    VARCHAR(100)  NOT NULL,
    region      VARCHAR(50)   NOT NULL,   -- e.g. DACH, Iberia, Nordics, France, Benelux
    team        VARCHAR(50)   NOT NULL,   -- SMB, Mid-Market, Enterprise
    manager_id  INT                       -- self-reference (nullable for leaders)
);

-- 2) The customers -------------------------------------------------
CREATE TABLE advertisers (
    advertiser_id   INT PRIMARY KEY,
    advertiser_name VARCHAR(150) NOT NULL,
    industry        VARCHAR(50)  NOT NULL,   -- Retail, Finance, Travel, Auto, Tech, CPG
    size_tier       VARCHAR(20)  NOT NULL    -- SMB, Mid-Market, Enterprise
);

-- 3) The Ads product lines ----------------------------------------
CREATE TABLE product_catalog (
    product_line     VARCHAR(50) PRIMARY KEY,  -- Search, Display, YouTube, Shopping
    product_category VARCHAR(50) NOT NULL,     -- Performance, Brand, Commerce
    avg_deal_size    NUMERIC(12,2) NOT NULL
);

-- 4) Quarterly targets per rep ------------------------------------
CREATE TABLE quotas (
    rep_id       INT NOT NULL,
    quarter      VARCHAR(10) NOT NULL,   -- e.g. 2026-Q1
    quota_amount NUMERIC(12,2) NOT NULL,
    PRIMARY KEY (rep_id, quarter),
    FOREIGN KEY (rep_id) REFERENCES sales_reps(rep_id)
);

-- 5) Deals (the fact table) ---------------------------------------
CREATE TABLE deals (
    deal_id       INT PRIMARY KEY,
    rep_id        INT NOT NULL,
    advertiser_id INT NOT NULL,
    product_line  VARCHAR(50) NOT NULL,
    close_date    DATE,                     -- NULL if not yet closed
    revenue       NUMERIC(12,2) NOT NULL,
    stage         VARCHAR(30) NOT NULL,     -- Prospecting..Closed Won/Lost
    FOREIGN KEY (rep_id)        REFERENCES sales_reps(rep_id),
    FOREIGN KEY (advertiser_id) REFERENCES advertisers(advertiser_id),
    FOREIGN KEY (product_line)  REFERENCES product_catalog(product_line)
);
