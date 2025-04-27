
## Foreword
Thanks Data Engineering Zoomcamp and its community for providing this learning opporunity. 
Started the project near the end of April after knowing there will be another project submission opportunity.

### 1. Terraform
The Terraform scripts in the `1.Terraform/` directory are used to provision the necessary Google Cloud resources:
- **`main.tf`**: Defines resources such as a GCS bucket and a BigQuery dataset.
- **`variables.tf`**: Contains configurable variables for the project, such as project name, region, and dataset name.

### 2. Spark Data Retrieval
The `2.get_data_spark/` directory contains a Python script (`get_SOL_data`) that:
- Fetch Solana price via CoinGecko Rest API (https://api.coingecko.com/api/v3/coins/solana/ohlc?vs_currency=usd&days=30) as row data - 30 days OHLC (open, high, low, close) price data with 4 hour intervals. 
- Converts the data into a Pandas DataFrame and then a Spark DataFrame.
- Writes the data directly to a BigQuery table.

### 3. dbt Data Transformation
The `3.data_transform_dbt/` directory contains dbt configurations and models for transforming the raw Solana OHLC data:
- **Staging Models**:
  - `stg_ohlc.sql`: Cleans and standardizes the raw data.
  - `schema.yml`: Defines metadata and tests for the staging model.
- **Core Models**:
  - `ohlc_enriched.sql`: Enriches the OHLC data with additional calculated attributes.
  - `ohlc_daily.sql`: Aggregates the data into daily OHLC values.
  - `schema.yml`: Defines metadata and tests for the core models.
- **`dbt_project.yml`**: Configures the dbt project.
- **`packages.yml`**: Includes the `dbt_utils` package for additional functionality.
- Use `README.md` under the directory for further info

### 4. Workflow Automation with Kestra
The `4.workflow_kestra/` directory contains a Kestra workflow (`job_submit.yaml`) that:
- Submits a PySpark job to a Dataproc cluster to fetch Solana OHLC data.
- Schedules the workflow to run on the 1st of every month at midnight (UTC).


## Workflow Overview

1. **Data Retrieval**:
   - The Spark script fetches Solana OHLC data from the CoinGecko API and writes it to BigQuery.
2. **Data Transformation**:
   - dbt models clean, enrich, and aggregate the data for analysis.
3. **Workflow Automation**:
   - Kestra orchestrates the data pipeline, ensuring timely execution and scheduling.

## How to Run the Project manually to validate its content

### Prerequisites
- Google Cloud account with BigQuery, GCS, Compute Engine (VM) and Dataproc enabled.
- Terraform (runs on Docker) installed to the VM.
- Python and Spark environment (incl Java) set up.
- dbt installed with the required dependencies - this project runs on dbt cloud.
- Kestra installed on local machine for workflow execution.

### Steps
1. **Provision Resources**:
   - Use Terraform (IaC) to create the necessary GCP resources:
     ```bash
     cd 1.Terraform
     terraform init
     terraform apply
     ```
2. **Fetch Data**:
   - Run the Spark script (stored in GCS Bucket) to fetch and load data into BigQuery directory:
     ```bash
     python 2.get_data_spark/get_SOL_data --output=<project.dataset.table>
     ```

1. **Transform Data**:
   - Run dbt to transform the data:
     ```bash
     cd 3.data_transform_dbt/hao-de-project_data
     dbt run
     ```
2. **Automate Workflow**:
   - Deploy the Kestra workflow to automate the pipeline.
