variable "project_id" {
  description = "The ID of the project in which to enable the IAM API"
  type        = string
}

variable "sa_teamname" {
  description = "Used as a suffix for the service account name"
  type        = string
}
variable "deletion_protection" {
  type        = string
  description = "Whether or not to protect Cloud SQL resources from deletion when solution is modified or changed."
  default     = false
}
variable "labels" {
  type        = map(string)
  description = "A map of labels to apply to contained resources."
  default     = { "genai-rag" = true }
}

variable "region" {
  description = "The region in which to set the provider"
  type        = string
  default     = "us-central1" # You can set a default region if you like
}
variable "enable_apis" {
  type        = string
  description = "Whether or not to enable underlying apis in this solution. ."
  default     = true
}
variable "instance_name" {
  description = "The name of the Cloud SQL instance"
  type        = string
}

variable "database_version" {
  description = "The version of the database (e.g., MYSQL_5_7, POSTGRES_13)"
  type        = string
}

variable "tier" {
  description = "The machine type to use (e.g., db-f1-micro, db-g1-small)"
  type        = string
}

variable "backup_enabled" {
  description = "Whether backup is enabled"
  type        = bool
  default     = true
}

variable "backup_start_time" {
  description = "Start time for the backup (e.g., 23:00)"
  type        = string
  default     = "23:00"
}

variable "ipv4_enabled" {
  description = "Whether the instance should be assigned an IPv4 address"
  type        = bool
  default     = true
}

variable "disk_autoresize" {
  description = "Whether the disk should automatically resize"
  type        = bool
  default     = true
}

variable "disk_size" {
  description = "The size of the disk in GB"
  type        = number
  default     = 10
}

variable "disk_type" {
  description = "The type of disk (e.g., PD_SSD, PD_HDD)"
  type        = string
  default     = "PD_SSD"
}

variable "database_name" {
  description = "The name of the database to create"
  type        = string
}

variable "database_user" {
  description = "The name of the database user"
  type        = string
}

variable "database_password" {
  description = "The password for the database user"
  type        = string
  sensitive   = true
}