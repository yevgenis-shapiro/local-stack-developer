
resource "helm_release" "gitlab" {
  name             = "gitlab"
  repository       = "https://charts.gitlab.io/"
  chart            = "gitlab"
  namespace        = "gitlab"
  version          = "7.7.0"
  create_namespace = true
  timeout          = 900
  wait             = true
  atomic           = true

  # Domain configuration
  set {
    name  = "global.hosts.domain"
    value = var.gitlab_domain
  }

  set {
    name  = "global.hosts.externalIP"
    value = var.external_ip
  }

  # GitLab URLs
  set {
    name  = "global.hosts.gitlab.name"
    value = "gitlab.${var.gitlab_domain}"
  }

  set {
    name  = "global.hosts.registry.name"
    value = "registry.${var.gitlab_domain}"
  }

  set {
    name  = "global.hosts.minio.name"
    value = "minio.${var.gitlab_domain}"
  }

  # Disable GitLab's built-in nginx ingress controller (use existing one)
  set {
    name  = "certmanager.install"
    value = "false"
  }

  set {
    name  = "global.ingress.configureCertmanager"
    value = "false"
  }

  set {
    name  = "nginx-ingress.enabled"
    value = "false"
  }

  set {
    name  = "global.ingress.enabled"
    value = "true"
  }

  set {
    name  = "global.ingress.class"
    value = var.ingress_class
  }

  set {
    name  = "global.ingress.provider"
    value = "nginx"
  }

  # Email configuration
  set {
    name  = "global.email.from"
    value = var.gitlab_email_from
  }

  set {
    name  = "global.email.display_name"
    value = "GitLab"
  }

  set {
    name  = "global.email.reply_to"
    value = var.gitlab_email_reply_to
  }

  # Initial root password (optional - auto-generated if not provided)
  dynamic "set_sensitive" {
    for_each = var.gitlab_root_password != "" ? [1] : []
    content {
      name  = "global.initialRootPassword.secret"
      value = var.gitlab_root_password
    }
  }

  # Storage configuration
  set {
    name  = "global.storageClass"
    value = var.storage_class
  }

  # PostgreSQL configuration
  set {
    name  = "postgresql.persistence.size"
    value = var.postgres_storage_size
  }

  # Redis configuration
  set {
    name  = "redis.master.persistence.size"
    value = var.redis_storage_size
  }

  # Gitaly (Git repository storage)
  set {
    name  = "gitlab.gitaly.persistence.size"
    value = var.gitaly_storage_size
  }

  # Registry
  set {
    name  = "registry.enabled"
    value = var.registry_enabled
  }

  set {
    name  = "registry.storage.secret"
    value = var.registry_storage_secret
  }

  # MinIO (object storage)
  set {
    name  = "global.minio.enabled"
    value = var.minio_enabled
  }

  set {
    name  = "minio.persistence.size"
    value = var.minio_storage_size
  }

  # GitLab Runner
  set {
    name  = "gitlab-runner.install"
    value = var.gitlab_runner_enabled
  }

  # Backup configuration
  set {
    name  = "gitlab.toolbox.backups.cron.enabled"
    value = var.backup_enabled
  }

  set {
    name  = "gitlab.toolbox.backups.cron.schedule"
    value = var.backup_schedule
  }

  # Time zone
  set {
    name  = "global.time_zone"
    value = var.time_zone
  }

  # Depends on cert-manager if managing it separately
  depends_on = [
    kubernetes_namespace.gitlab
  ]
}

# Supporting resources
resource "kubernetes_namespace" "gitlab" {
  metadata {
    name = "gitlab"
    labels = {
      name        = "gitlab"
      environment = var.environment
    }
  }
}

# Output important information
output "gitlab_url" {
  description = "GitLab URL"
  value       = "https://gitlab.${var.gitlab_domain}"
}

output "registry_url" {
  description = "Container Registry URL"
  value       = "https://registry.${var.gitlab_domain}"
}

output "gitlab_root_password_note" {
  description = "Note about retrieving the root password"
  value       = "If not set via variable, retrieve with: kubectl get secret gitlab-gitlab-initial-root-password -n gitlab -ojsonpath='{.data.password}' | base64 -d"
}
