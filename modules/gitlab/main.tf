
resource "kubernetes_namespace" "gitlab" {
  metadata {
    name = "gitlab"
    labels = {
      name        = "gitlab"
      environment = var.environment
    }
  }
}

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

  values = [
    templatefile("${path.module}/gitlab-values.yaml", {
      gitlab_domain          = var.gitlab_domain
      external_ip            = var.external_ip
      ingress_class          = var.ingress_class
      storage_class          = var.storage_class
      time_zone              = var.time_zone
      gitlab_email_from      = var.gitlab_email_from
      gitlab_email_reply_to  = var.gitlab_email_reply_to
      minio_enabled          = var.minio_enabled
      postgres_storage_size  = var.postgres_storage_size
      redis_storage_size     = var.redis_storage_size
      gitaly_storage_size    = var.gitaly_storage_size
      gitlab_runner_enabled  = var.gitlab_runner_enabled
      backup_enabled         = var.backup_enabled
      backup_schedule        = var.backup_schedule
      registry_enabled       = var.registry_enabled
      registry_storage_secret = var.registry_storage_secret
      gitlab_root_password   = var.gitlab_root_password
    })
  ]

  depends_on = [
    kubernetes_namespace.gitlab
  ]
}
