module "project_iam_bindings" {
  source  = "terraform-google-modules/iam/google//modules/projects_iam"
  version = "~> 6.4"

  projects = [var.project_id]

  bindings = {
    "roles/secretmanager.secretAccessor" = [
      "serviceAccount:${var.service_account_email}"
    ]
  }
}
