# hao-de-project
Hao's project for data engineering zoomcamp 2025

my_solana_dbt_project/
├── dbt_project.yml
├── README.md
├── models/
│   ├── staging/
│   │   └── stg_ohlc.sql  -- clean source a bit even if json converted file is pretty clean
|   |   └── schema.yaml
│   ├── core/
│   │   ├── ohlc_enriched.sql  -- enrich the OHLC data
│   │   ├── ohlc_daily.sql     -- aggregate to daily OHLC
│   │   └── schema.yaml   
├── macros/
├── snapshots/
├── seeds/

documentation generated https://vj048.us1.dbt.com/accounts/70471823456921/develop/70471823762484/docs/index.html#!/overview?g_v=1

dbt job with cron job created to run on every Monday at 6am to sync with the data source
dbt CI job also created to enable CI with every PR
