

variable "project" {
  description = "Project"
  default     = "hao-de-project"
}

variable "region" {
  description = "Region"
  #Update the below to your desired region
  default     = "europe-west1-b"
}

variable "location" {
  description = "Project Location"
  #Update the below to your desired location
  default     = "europe-west1"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  #Update the below to what you want your dataset to be called
  default     = "hao_de_project_dataset"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  #Update the below to a unique bucket name
  default     = "hao-de-project-bucket"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}