## dbt Workflow Overview

The dbt workflow for this project is designed to transform raw Solana OHLC data into enriched and aggregated datasets for analysis. Below is an overview of the workflow:

1. **folder structure**:
 ```bash
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
```

2. **Staging Models**:
   - The `stg_ohlc.sql` model cleans and standardizes the raw OHLC data fetched from the CoinGecko API.
   - The `schema.yaml` file defines metadata and tests to ensure data quality.

3. **Core Models**:
   - The `ohlc_enriched.sql` model enriches the OHLC data by adding calculated attributes such as moving averages or percentage changes.
   - The `ohlc_daily.sql` model aggregates the OHLC data into daily values for easier analysis.
   - The `schema.yaml` file defines metadata and tests for the core models.

4. **Documentation**:
   - Documentation for the dbt models is automatically generated and can be accessed [here](https://vj048.us1.dbt.com/accounts/70471823456921/develop/70471823762484/docs/index.html#!/overview?g_v=1). (only accessible via dbt cloud)

5. **Automation**:
   - A dbt job is scheduled to run every Month on the first day using a cron job to sync with the data source. Moreover, it makes sure the staging data is deployed to the PROD tables.
   - A dbt CI job is also configured to run on every pull request, ensuring that changes to the models are tested before merging.

## Notes
- Ensure that all required dependencies and configurations are set up before running the dbt workflow.
- Use the `dbt run` command to execute the models and transform the data.

After transformation, the new dataset are fed to Google Looker Studio for visualization. Please visit the dashboard [here](https://lookerstudio.google.com/reporting/227ebf49-b651-44dc-b34b-099cd3abac20)