WITH base AS (

    SELECT
      ts,
      open,
      high,
      low,
      close
    FROM {{ ref('ohlc_enriched') }}

),

daily AS (

    SELECT
      DATE(ts) AS day,
      FIRST_VALUE(open) OVER (PARTITION BY DATE(ts) ORDER BY ts ASC) AS first_open,
      MAX(high) OVER (PARTITION BY DATE(ts)) AS daily_high,
      MIN(low) OVER (PARTITION BY DATE(ts)) AS daily_low,
      LAST_VALUE(close) OVER (PARTITION BY DATE(ts) ORDER BY ts ASC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_close
    FROM base

)

SELECT
  day,
  MIN(first_open) AS open,   -- Should be the same for each day but MIN handles duplicates safely
  MAX(daily_high) AS high,
  MIN(daily_low) AS low,
  MAX(last_close) AS close
FROM daily

GROUP BY day
ORDER BY day
