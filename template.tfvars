
###  ---  Default Template  ---  ###
kind_cluster_name        = "dev-cluster"
kind_cluster_config_path = "~/.kube/config"
k8s_version              = "v1.31.0"
additional_control_planes_count = 0
worker_count = 0

# Domain and ingress
gitlab_domain         = "gitlab.example.com"
external_ip           = "localhost"
ingress_class         = "nginx"

# Storage
storage_class         = "standard"
postgres_storage_size = "10Gi"
redis_storage_size    = "10Gi"
gitaly_storage_size   = "10Gi"
minio_storage_size    = "10Gi"

# GitLab features
gitlab_runner_enabled = true
backup_enabled        = true
backup_schedule       = "0 2 * * *"  # Daily at 2:00 AM
registry_enabled      = true
registry_storage_secret = "gitlab-registry-storage" # must exist in GitLab namespace
minio_enabled         = true

# Email configuration
gitlab_email_from     = "gitlab@example.com"
gitlab_email_reply_to = "noreply@example.com"

# Initial root password (leave empty for auto-generated)
gitlab_root_password  = "q1w2e3r4100@"

# Environment and timezone
environment           = "production"



