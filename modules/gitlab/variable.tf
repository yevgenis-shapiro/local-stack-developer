# Required variables
variable "gitlab_domain" {
  description = "Domain for GitLab installation"
  type        = string
  default     = "appflex.io"
}

variable "external_ip" {
  description = "External IP address for GitLab ingress"
  type        = string
  default     = "localhost"
}

variable "storage_class" {
  description = "Kubernetes storage class"
  type        = string
  default     = "standard"
}

variable "ingress_class" {
  description = "Ingress controller class"
  type        = string
  default     = "nginx"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

# Optional: Root password (will be auto-generated if empty)
variable "gitlab_root_password" {
  description = "Initial root password (leave empty for auto-generation)"
  type        = string
  default     = "Tegrity123!"
  sensitive   = true
}

# Email configuration
variable "gitlab_email_from" {
  description = "From email address for GitLab"
  type        = string
  default     = "gitlab@example.com"
}

variable "gitlab_email_reply_to" {
  description = "Reply-to email address"
  type        = string
  default     = "noreply@example.com"
}

# Storage sizes
variable "postgres_storage_size" {
  description = "PostgreSQL storage size"
  type        = string
  default     = "8Gi"
}

variable "redis_storage_size" {
  description = "Redis storage size"
  type        = string
  default     = "5Gi"
}

variable "gitaly_storage_size" {
  description = "Gitaly storage size"
  type        = string
  default     = "10Gi"
}

variable "minio_storage_size" {
  description = "MinIO storage size"
  type        = string
  default     = "10Gi"
}

# Component toggles
variable "registry_enabled" {
  description = "Enable container registry"
  type        = bool
  default     = true
}

variable "registry_storage_secret" {
  description = "Registry storage secret name"
  type        = string
  default     = "gitlab-registry-storage"
}

variable "minio_enabled" {
  description = "Enable MinIO object storage"
  type        = bool
  default     = true
}

variable "gitlab_runner_enabled" {
  description = "Enable GitLab Runner"
  type        = bool
  default     = false
}


# Backup configuration
variable "backup_enabled" {
  description = "Enable automated backups"
  type        = bool
  default     = true
}

variable "backup_schedule" {
  description = "Cron schedule for backups"
  type        = string
  default     = "0 2 * * *"  # 2 AM daily
}


# Replica counts
variable "webservice_min_replicas" {
  description = "Minimum webservice replicas"
  type        = number
  default     = 1
}

variable "sidekiq_min_replicas" {
  description = "Minimum Sidekiq replicas"
  type        = number
  default     = 1
}

variable "shell_min_replicas" {
  description = "Minimum GitLab Shell replicas"
  type        = number
  default     = 1
}

# Miscellaneous
variable "time_zone" {
  description = "Time zone for GitLab"
  type        = string
  default     = "UTC"
}
