WITH base AS (

    SELECT
      ts,
      open,
      high,
      low,
      close
    FROM {{ ref('stg_ohlc') }} 

)

SELECT
  ts,
  open,
  high,
  low,
  close,
  (high + low) / 2 AS mid_price,
  ABS(close - open) AS candle_body_size,
  high - GREATEST(open, close) AS upper_wick,
  LEAST(open, close) - low AS lower_wick,
  CASE
    WHEN ABS(close - open) < 0.1 THEN 'doji'
    WHEN close > open THEN 'bullish'
    ELSE 'bearish'
  END AS candle_type,
  ((close - open) / open) * 100 AS percent_change,
  (high - low) / open AS volatility,
  CASE WHEN close > open THEN TRUE ELSE FALSE END AS is_green
FROM base
