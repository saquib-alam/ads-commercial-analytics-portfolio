# 🔀 PostgreSQL vs. MySQL — Project 1 notes

The queries in this project are written for **PostgreSQL** but run almost unchanged in
**MySQL 8.0+**. Here are the differences worth knowing.

| Topic | PostgreSQL | MySQL |
|-------|-----------|-------|
| **Integer division** | `10 / 4` = `2` (truncates for ints). Cast: `col::numeric` or `CAST(col AS numeric)`. | `10 / 4` = `2.5000` (division returns DECIMAL automatically). |
| **Current date** | `CURRENT_DATE` | `CURDATE()` or `CURRENT_DATE` |
| **Quarter truncation** | `date_trunc('quarter', CURRENT_DATE)` | No `date_trunc`; use `MAKEDATE`/`QUARTER()` logic. |
| **String type** | `VARCHAR` / `TEXT` | `VARCHAR` / `TEXT` (same) |
| **Boolean** | native `BOOLEAN` | `TINYINT(1)` under the hood |
| **`ROUND`** | `ROUND(x, 1)` | `ROUND(x, 1)` (identical) |

## Why we cast in this project
Our `revenue` and `quota_amount` columns are `NUMERIC`, so division is safe in **both**
dialects. The `::numeric` cast is only strictly needed in PostgreSQL when both operands are
integers — it's included defensively so the queries stay correct if you change column types.

## Rule of thumb
> Write for PostgreSQL first (stricter, more analytics-standard). When porting to MySQL,
> the two things to check are **date functions** and **integer division**.
