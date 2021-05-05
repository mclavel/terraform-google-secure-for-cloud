variable "log_retention" {
  type        = number
  default     = 5
  description = "Days to keep logs for CloudScanning"
}

variable "vpc" {
  type        = string
  description = "VPC where the workload is deployed"
}

variable "subnets" {
  type        = list(string)
  description = "Subnets where the CloudScanning will be deployed"
}

variable "ssm_endpoint" {
  type        = string
  description = "Name of the parameter in SSM containing the Sysdig Secure Endpoint URL"
}

variable "ssm_token" {
  type        = string
  description = "Name of the parameter in SSM containing the Sysdig Secure API Token"
}

variable "extra_env_vars" {
  type        = map(string)
  default     = {}
  description = "Extra environment variables for the Cloud Scanning deployment"
}

variable "verify_ssl" {
  type        = bool
  default     = true
  description = "Whether to verify the SSL certificate of the endpoint or not"
}

variable "image" {
  type        = string
  default     = "sysdiglabs/cloud-scanning:latest"
  description = "Image of the cloud scanning to deploy"
}

variable "naming_prefix" {
  type        = string
  default     = "SysdigCloud"
  description = "Prefix for resource names. Use the default unless you need to install multiple instances, and modify the deployment at the main account accordingly"

  validation {
    condition     = can(regex("^[a-zA-Z0-9\\-]+$", var.naming_prefix)) && length(var.naming_prefix) > 1 && length(var.naming_prefix) <= 64
    error_message = "Must enter a naming prefix up to 64 alphanumeric characters."
  }
}

variable "accounts_and_regions" {
  type        = list(object({
    account_id = string
    region     = string
  }))
  default     = []
  description = "A list of child GCP accounts and regions where PubSub is enabled."
}

variable "location" {
  type        = string
  default     = "us-central1"
  description = "Zone where the cloud scanning will be deployed"
}

variable "secure_api_token" {
  type        = string
  description = "Sysdig's Secure API Token"
}

variable "secure_api_url" {
  type        = string
  description = "Sysdig's Secure API URL"
}