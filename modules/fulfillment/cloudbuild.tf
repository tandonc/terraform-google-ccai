resource "google_cloudbuild_trigger" "github" {
  provider = google-beta

  name        = var.service_name
  description = var.trigger_description

  github {
    owner = var.github_org
    name  = var.github_repo
    push {
      branch = var.github_branch
    }
  }

  filename = "cloudbuild.yaml"

  substitutions = {
    _APP_ENV         = var.env
    _SERVICE_NAME    = var.service_name
    _SERVICE_ACCOUNT = var.service_account_email
    _DEPLOY_REGIONS  = join(",", var.regions)
    _EXPOSE_PORT     = var.port
    _GCR_HOSTNAME    = var.gcr_hostname
  }
}
